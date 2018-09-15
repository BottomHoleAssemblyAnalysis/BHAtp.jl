function  problem(segments, traj, wobrange, inclinationrange;
  materials=materials, media=media, medium=:lightmud,
  penalty=1.0e9, computefunction=PtFEM.p44, pdir=ProjDir)
  
  prob = Dict(
    :segments => segments,
    :traj => traj,
    :wobrange => wobrange,
    :inclinationrange => inclinationrange,
    :materials => materials,
    :media => media,
    :medium => medium,
    :penalty => penalty,
    :survey => nothing,
    :computefunction => computefunction,
    :pdir => pdir
  )
  
  prob
end