module BHAtp

using Reexport

@reexport using PGFPlotsX, LaTeXStrings
@reexport using DataFrames, DataFramesMeta
@reexport using Interpolations
@reexport using BHAtp, CSV, Distributed


# Types and derived types

include("Types.jl")
include("Parameters.jl")
include("Dataframes.jl")

# Exported methods

include("Bha.jl")
include("TheoreticalPerformance.jl")
include("ShowFunctions.jl")

# Base level methods

include("InertiaForces.jl")
include("CurvatureForces.jl")
include("InitialRelease.jl")
include("ExceedanceAdjustment.jl")
include("FinalRelease.jl")
include("Fem.jl")
include("TpRunSetup.jl")
include("Finalinit.jl")
include("CreateMaterialTable.jl")
include("CreateMediaTable.jl")
include("CheckInput.jl")
include("CreateMesh.jl")
include("Interpolate.jl")
include("Xyinit.jl")
include("DalphaInit.jl")
include("Stiffness.jl")
include("GeometricMatrix.jl")
include("Weightforces.jl")
include("Endforces.jl")
include("Savefig.jl")

export
  BHAJ,
  tp!,
  show_solution,
  show_tp,
  create_final_tp_df,
  create_element_df,
  create_node_df,
  savefig

end # module
