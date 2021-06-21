using DataFrames
using Plots

using Futbolista: DataLoaders, Plotter
using Test

@testset "DataLoaders Tests" begin

    const sb = DataLoaders.Statsbomb
    ldr = sb.SBLoader()

	comp_df = sb.load_competitions(ldr)
	matches_df = sb.load_matches(ldr, 72, 30)
	events_df = sb.load_events(ldr, 7298)

    @test typeof(comp_df) == DataFrame
    @test typeof(matches_df) == DataFrame
    @test typeof(events_df) == DataFrame
end

@testset "Plotting Tests" begin

    const pl = Plotter.StatsbombPitch
    const pm = Plotter.Passmap
    const sb = DataLoaders.Statsbomb

    ldr = sb.SBLoader()
	events_df = sb.load_events(ldr, 7298)
    
    pitch = pl.plot_pitch(line_color=:silver, line_width=1)
    passmap = pm.plot_passmap(events_df, "home", "mean")

    @test typeof(pitch) <: Plots.Plot
    @test typeof(passmap) <: Plots.Plot
end