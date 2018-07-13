using BHAtp
using Test

ProjDir = dirname(@__FILE__)
cd(ProjDir) do

  media = mediatable()
  
  @test media[:mud] == 11.35
end # cd
