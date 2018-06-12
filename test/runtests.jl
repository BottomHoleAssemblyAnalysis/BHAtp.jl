using BHAtp

@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

# write your own tests here

@testset "BHAtp.jl" begin

  @test greet() == "Hello BHA World!"

end