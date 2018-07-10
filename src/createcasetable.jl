function createcasetable(segs::Array{Float64, 2}, wobrange, inclinationrange, computefunction)
  
  # The casetable contains a case for every requested wob and inclination
  
  casetable = Array{Tuple}(undef, length(wobrange) * length(inclinationrange))
  for (i, wob) in enumerate(wobrange)
    for (j, incl) in enumerate(inclinationrange)
      casetable[ (i-1) * length(inclinationrange) + j ] = (segs, wob, incl, computefunction)
    end
  end
  
  casetable
end

