module Passmap

using DataFrames
using Statistics
using Plots

theme(:dark)

include("pitch.jl")
using .StatsbombPitch


"""
plots a passmap using the statsbomb data

Arguments:
events_df::DataFrame - df returned from load_events
side::String - 'home' or 'away'
agg::String - 'mean' or 'median' 

Returns:
plot
"""
function plot_passmap(events_df, side, agg_func)
    
    agg_func == "median" ? agg = median : agg = mean
    side == "home" ? team_number = 1 : team_number = 2

    starting_players = [player["player"]["name"] for player in events_df[!, "tactics"][team_number]["lineup"]]
    team_name = events_df."team"[team_number]["name"]

    pass_df = filter(row -> row["type"]["name"] == "Pass", events_df)
    pass_df."location" = eval.(Meta.parse.(pass_df."location"))

    pass_df[!, "type"] = map(d -> d["name"], pass_df."type")
    pass_df[!, "team"] = map(d -> d["name"], pass_df."team")
    pass_df[!, "player"] = map(d -> d["name"], pass_df."player")
    pass_df[!, "outcome"] = map(d -> haskey(d, "outcome") ? 0 : 1, pass_df."pass") ##successful passes and unsuccessful passes
    pass_df[!, "X"] = map(ar -> ar[1], pass_df."location") 
    pass_df[!, "Y"] = map(ar -> ar[2], pass_df."location")

    pass_df = pass_df[((pass_df."outcome" .== 1) .& (pass_df."team" .== team_name)), :] ##get only successful passes from particular team
    pass_df[!, "recipient"] = map(d -> d["recipient"]["name"], pass_df[!, "pass"]); ##get recipients for successful passes
    pass_df = pass_df[ ([x in starting_players for x in pass_df."player"]) .& ([x in starting_players for x in pass_df."recipient"]) ,:]

    pass_df = pass_df[!, [:player, :recipient, :X, :Y, :minute, :second]]

    grouped_df = groupby(pass_df, [:player, :recipient])
    pass_links = combine(grouped_df, :player => size) ##important
    pass_links[!, "passes"] = map(ar -> ar[1], pass_links."player_size")

    player_df = groupby(pass_df, :player)
    locations = combine(player_df, [:X, :Y] => ((x, y) -> (avg_x=agg(x), avg_y=agg(y))) => AsTable)
    player_totals = combine(player_df, :player => size)
    player_totals[!, "total"] = map(ar -> ar[1], player_totals."player_size") ##important

    fin = outerjoin(locations, player_totals, on = :player)
    final = outerjoin(fin, pass_links, on=:player, makeunique=true);

    p = StatsbombPitch.plot_pitch(line_color=:silver, line_width=1)

    min_val = minimum(skipmissing(final."passes")); max_val = maximum(skipmissing(final."passes"))
    alphas = (final."passes" .- min_val) ./ (max_val - min_val)

    min_val = minimum(skipmissing(fin."total")); max_val = maximum(skipmissing(fin."total"))
    totals_std = (fin."total" .- min_val) ./ (max_val - min_val)

    for (row, alpha) in zip(eachrow(final), alphas)
        end_x = locations[locations."player" .== row.recipient, "avg_x"][1]
        end_y = locations[locations."player" .== row.recipient, "avg_y"][1]
        plot!(p, [row.avg_x, end_x], [row.avg_y, end_y], color=:gray, linewidth=(alpha+0.1)*10, linealpha=alpha) 

    end

    scatter!(p, fin.avg_x, fin.avg_y, color=:dodgerblue, markersize=totals_std.*15, dpi=120, markerstrokewidth=3, markerstrokecolor=:gray)
    [annotate!(p, row.avg_x, row.avg_y, text(split(row.player, " ")[end], :white, :center, 4)) for row in eachrow(fin)]
    annotate!(p, 60, -2, text(team_name, :gray, :center, 14))
    p
end

end