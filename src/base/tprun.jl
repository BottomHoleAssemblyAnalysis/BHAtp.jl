 function tprun(data)
   
   (segmentdf, segs) = createsegmentdf(data[:segments])
   elementdf = createelementdf(segmentdf, data[:traj])

   casetable = createcasetable(Array{Float64, 2}(segs[3:end, :]),
      data[:wobrange], data[:inclinationrange],
      data[:computefunction], data[:pdir])
      
   pmap(runcase, casetable)
   
 end
 