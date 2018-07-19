module BHAtp

# package code goes here

using Reexport, DataFrames, Statistics, Distributed
using SparseArrays, LinearAlgebra 

@reexport using PtFEM

# init routines (called from BHAtp.jl)

include("init/materialtable.jl")
include("init/mediatable.jl")

# user visible (called from e.g. example projects)

include("user/tprun.jl")
#include("user/updatematerialtable.jl")
#include("user/updatemediatable.jl")

# tprun 

include("tprun/createsegmentdf.jl")
include("tprun/createelementdf.jl")
include("tprun/createcasetable.jl")

# core ptfem based mp runs

include("ptfem/runcase.jl")
include("ptfem/p44_1.jl")

# These table are created here, a user might update and/or add to these dicts

materials = materialtable()
media = mediatable()

export
  tprun!,
  materials,
  media,
  #updatedmaterialstable,
  #updatemedatable,
  p44_1

end # module
