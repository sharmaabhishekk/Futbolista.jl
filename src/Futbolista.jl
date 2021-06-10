module Futbolista

using DataFrames
using JSON: Parser, parsefile
using HTTP
using Statistics
using Plots

include("DataLoaders.jl")
include("Plotter.jl")

using .Plotter: Pitch
using .DataLoaders: StatsbombLoader

end ##end of module
