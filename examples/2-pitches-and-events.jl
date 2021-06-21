### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 781a3590-d1ed-11eb-17ae-fdf1ffd5bdb0
begin
	using Pkg
	using Plots
	using PlutoUI
	Pkg.activate("../")	
end

# ╔═╡ f2bc9edf-548c-4958-82f4-e65d6fe99f3d
begin
	using Futbolista: Plotter, DataLoaders
end

# ╔═╡ af773761-1267-4dcb-9e60-a5358f6bb319
begin
	const pl = Plotter.StatsbombPitch
	pl.plot_pitch(line_color=:silver, line_width=1)
end

# ╔═╡ e61162bf-c488-4c11-a446-11f65e3b8512
begin
	const sb = DataLoaders.Statsbomb
	ldr = sb.SBLoader("local", raw"C:/repository/open-data/data")
	events_df = sb.load_events(ldr, 22912)
	
	players = unique(events_df.player)
	players[2]
end

# ╔═╡ f934ef47-7558-4960-98f4-c264772e23b2
@bind player_index Slider(2:29)

# ╔═╡ 82e4a033-347b-423e-a8a3-6329f50023c0
player_name = players[player_index]["name"]

# ╔═╡ f4e11cf7-b68e-4881-b328-2640ef562240
begin
	pass_df = filter(row -> row.type["name"] == "Pass", events_df)
	player_df = filter(row -> row.player["name"] == player_name, pass_df);
	
	player_df.location = eval.(Meta.parse.(player_df.location))
    player_df[!, "x"] = map(ar -> ar[1], player_df."location") 
    player_df[!, "y"] = map(ar -> ar[2], player_df."location")
	
	player_df[!, "end_x"] = map(d -> d["end_location"][1], player_df."pass")
	player_df[!, "end_y"] = map(d -> d["end_location"][2], player_df."pass")
	
	p = pl.plot_pitch(;line_color=:silver, line_width=1)
	for row in eachrow(player_df[:, ["x", "y", "end_x", "end_y"]])
		plot!(p, [row.x, row.end_x], [row.y,row.end_y], color=:white,                          linewidth=1.1, label="")	
	end
	scatter!(p, player_df.x, player_df.y)
	p
end

# ╔═╡ Cell order:
# ╠═781a3590-d1ed-11eb-17ae-fdf1ffd5bdb0
# ╠═f2bc9edf-548c-4958-82f4-e65d6fe99f3d
# ╠═af773761-1267-4dcb-9e60-a5358f6bb319
# ╠═e61162bf-c488-4c11-a446-11f65e3b8512
# ╠═f934ef47-7558-4960-98f4-c264772e23b2
# ╠═82e4a033-347b-423e-a8a3-6329f50023c0
# ╠═f4e11cf7-b68e-4881-b328-2640ef562240
