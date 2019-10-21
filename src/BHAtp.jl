module BHAtp

using DataFrames
using Interpolations
using Documenter
using Distributed
using CSV

# package code goes here

include("utils/Types.jl")
include("utils/Parameters.jl")
include("utils/Dataframes.jl")

# Base level methods

include("base/EndForces.jl")
include("base/InertiaForces.jl")
include("base/CurvatureForces.jl")
include("base/InitialRelease.jl")
include("base/ExceedanceAdjustment.jl")
include("base/FinalRelease.jl")
include("base/Fem.jl")
include("base/TpRunSetup.jl")
include("base/FinalInit.jl")
include("base/CreateMaterialTable.jl")
include("base/CreateMediaTable.jl")
include("base/CheckInput.jl")
include("base/CreateMesh.jl")
include("base/Interpolate.jl")
include("base/Xyinit.jl")
include("base/DalphaInit.jl")
include("base/Stiffness.jl")
include("base/GeometricMatrix.jl")
include("base/Weightforces.jl")

# Exported methods

include("exported/Bha.jl")
include("exported/TheoreticalPerformance.jl")
include("exported/ShowFunctions.jl")

export
  BHAJ,
  tp!,
  show_solution,
  show_tp,
  create_final_tp_df,
  create_element_df,
  create_node_df


end # module
