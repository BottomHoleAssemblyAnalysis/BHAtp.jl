__precompile__()

module BHAtp

# package code goes here

using Reexport, DataFrames, Statistics, Distributed
using SparseArrays, LinearAlgebra 

@reexport using PtFEM

# init routines (called from BHAtp.jl)

include("init/materialdict.jl")
include("init/mediadict.jl")
#include("init/updatematerialtable.jl")
#include("init/updatemediatable.jl")

# problem input handling

include("problem/createsegmentdf.jl")
include("problem/createelementdf.jl")
include("problem/createcasetable.jl")

# user visible (called from e.g. example projects)

include("solve/solve.jl")

# core ptfem based mp runs

include("ptfem/runcase.jl")
include("ptfem/p44_1.jl")

# These table are created here, a user might update and/or add to these dicts

materials = materialdict()
media = mediadict()

export
  materials,
  media,
  #updatedmaterialstable,
  #updatemedatable,
  solve!,
  p44_1

end # module
