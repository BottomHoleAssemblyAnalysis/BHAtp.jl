function  problem(segments, traj, wobrange, inclinationrange,
  materials=materials, media=media, medium=:lightmud,
  computefunction=PtFEM.p44, pdir=ProjDir)
  
  println("In problem")
  prob = Dict(
    :segments => segments,
    :traj => traj,
    :wobrange => wobrange,
    :inclinationrange => inclinationrange,
    :materials => materials,
    :media => media,
    :medium => :lightmud,
    :penalty => 1e19,
    :survey => nothing,
    :computefunction => PtFEM.p44,
    :pdir => ProjDir
  )
  
  
  prob
end