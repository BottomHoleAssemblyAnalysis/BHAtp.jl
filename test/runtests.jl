using BHAtp
using Test

# write your own tests here

tests = Array{String, 1}([
  "case_01"
])

for test in tests
  println()
  println("\nRunning $(test)_test.jl.\n")
  include(test*"_test.jl")
  println()
end
