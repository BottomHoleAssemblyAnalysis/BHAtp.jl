module BHAtp

# package code goes here

using Reexport, DataFrames, Statistics, Distributed
using SparseArrays, LinearAlgebra 

@reexport using PtFEM

include("base/materialtable.jl")
include("base/mediatable.jl")
include("base/createsegmentdf.jl")
include("base/createelementdf.jl")
include("base/createcasetable.jl")
include("base/runcase.jl")
include("base/tprun.jl")
include("base/p44_1.jl")

materials = materialtable()
media = mediatable()

export
  tprun,
  materials,
  media,
  createsegmentdf,
  createelementdf,
  p44_1

end # module
