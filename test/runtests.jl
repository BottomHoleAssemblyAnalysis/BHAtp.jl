using BHAtp
using Test

code_tests = [
  "ex01.jl",
  "fisher_a1_01.jl"
]

println("\n\nRunning BottomHoleAssemblyAnalysis/BHatp.jl tests:\n\n")

@testset "BHAtp.jl" begin
  
  for test in code_tests
      println("\n\n  * $(test) *\n")
      include("test_"*test)
      println()
  end  
  
end