ProjDir = joinpath(dirname(@__FILE__), "..", "examples", "fisherpaper")
cd(ProjDir) do

  isdir("tmp") &&
    rm("tmp", recursive=true);
    
  include(joinpath(ProjDir, "a1/fisher_01.jl"))
  
  println("testing: size(segs) == (4, 10)")
  @test size(segs) == (4, 10)

  isdir("tmp") &&
    rm("tmp", recursive=true);

end # cd
