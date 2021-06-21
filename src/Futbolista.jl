module Futbolista

using DataFrames
using JSON: Parser, parsefile
using HTTP
using Statistics
using Plots

include("DataLoaders.jl")
include("Plotter.jl")

using .Plotter
using .DataLoaders

end ##end of module
