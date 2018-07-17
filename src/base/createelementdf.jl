function createelementdf(segmentdf, traj)
  
  element_types = [Symbol, Symbol, Float64, Float64, Float64, Int, Float64, Float64, Float64, Float64]
  element_names = [:eltype, :material, :length, :id, :od, :etype, :ea, :ei, :gj, :holediameter]

  elementdf = DataFrame(element_types, element_names, 0)
  j = 0
  for i in 1:size(segmentdf, 1)
    seg = segmentdf[i, :]
    if seg[:eltype][1] in [:collar, :pipe]
      # New etype
      j += 1          
      append!(elementdf, 
        DataFrame(eltype=seg[:eltype][1], material=seg[:material][1],
          length=seg[:length][1], id=seg[:id][1], od=seg[:od][1], etype=j, 
          ea=0.0, 
          ei=1.0, 
          gj=2.0, 
          holediameter=traj[2]
        )
      )
    end
  end
  
  elementdf
  
end