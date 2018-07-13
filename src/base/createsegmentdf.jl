function createsegmentdf(segments)
  segment_types = [Symbol, Symbol, Float64, Float64, Float64, Float64, Int]
  segment_names = [:eltype, :material, :length, :id, :od, :frictioncoefficient, :noofelements]
  segs = reshape(segments, (7, :));

  segmentdf = DataFrame(segment_types, segment_names, 0)
  for i in 1:size(segs, 2)
    seg = segs[:, i]
      append!(segmentdf,
        DataFrame(eltype=seg[1], material=seg[2], length=seg[3], id=seg[4], od=seg[5],
          frictioncoefficient=seg[6], noofelements=seg[7])
      )
  end
  
  (segmentdf, segs)
  
end