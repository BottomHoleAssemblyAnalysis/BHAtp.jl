using BHAtp, FinEtools

ProjDir = @__DIR__
cd(ProjDir)

include("h20.jl")

h20.neohookean_h20()

