 function solve!(data)
   
   segmentdf = createsegmentdf(data[:segments])
   data[:segmentdf] = segmentdf

   elementdf = createelementdf(segmentdf, data[:traj])
   data[:elementdf] = elementdf
   
   casetable = createcasetable(elementdf,
      data[:wobrange], data[:inclinationrange],
      data[:computefunction], data[:pdir])
      
   pmap(runcase, casetable)
   
 end
 