### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 737bd5e0-cc69-11eb-3650-d5862b2b7d32
begin
	using Pkg
	Pkg.activate("../")
end

# ╔═╡ 3b86934d-dbef-4ff5-b555-47d6a9456efa
begin	
	import Futbolista: DataLoaders
	const sb = DataLoaders.Statsbomb
end

# ╔═╡ cd78a60c-56db-4f35-a82c-26e9b5335852
begin
	rldr = sb.SBLoader()
	lldr = sb.SBLoader("local", raw"C:\repository\open-data\data")
end

# ╔═╡ 3d945a95-e6ff-44a7-8f42-46064e2d76d1
begin
	comp_df = sb.load_competitions(lldr)
	matches_df = sb.load_matches(lldr, 72, 30)
	events_df = sb.load_events(lldr, 7298);
end

# ╔═╡ 6aab4a57-ba7c-4c9b-837f-e51164b991ee
matches_df

# ╔═╡ 6daad45f-e62c-4963-ab09-4fa307bd914d
comp_df

# ╔═╡ Cell order:
# ╠═737bd5e0-cc69-11eb-3650-d5862b2b7d32
# ╠═3b86934d-dbef-4ff5-b555-47d6a9456efa
# ╠═cd78a60c-56db-4f35-a82c-26e9b5335852
# ╠═3d945a95-e6ff-44a7-8f42-46064e2d76d1
# ╠═6aab4a57-ba7c-4c9b-837f-e51164b991ee
# ╠═6daad45f-e62c-4963-ab09-4fa307bd914d
