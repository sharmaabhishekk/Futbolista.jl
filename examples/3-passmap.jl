### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 6f58c330-cce4-11eb-3e45-6787cd75141f
begin
	using Pkg
	Pkg.activate("../")
end

# ╔═╡ e850ce3c-f57e-41ab-acb3-958a1b5951a9
begin
	using Futbolista: DataLoaders, Plotter
	const sb = DataLoaders.Statsbomb
	const pm = Plotter.Passmap
	
	ldr = sb.SBLoader("local", raw"C:\repository\open-data\data")
	events_df = sb.load_events(ldr, 7298)
	p = pm.plot_passmap(events_df, "home", "mean")
end

# ╔═╡ Cell order:
# ╠═6f58c330-cce4-11eb-3e45-6787cd75141f
# ╠═e850ce3c-f57e-41ab-acb3-958a1b5951a9
