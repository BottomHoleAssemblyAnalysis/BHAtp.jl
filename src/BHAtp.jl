module BHAtp

# package code goes here

using Reexport, DataFrames, Statistics, Distributed

if VERSION.minor > 6
  @eval using SparseArrays, LinearAlgebra 
end

@reexport using PtFEM

include("createcasetable.jl")
include("runcase.jl")
include("tprun.jl")
include("p44_1.jl")

export
  tprun,
  p44_1

end # module
