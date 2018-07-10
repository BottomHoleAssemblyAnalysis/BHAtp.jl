 function tprun(segs, wobrange, inclinationrange, computefunction::Function)
   
   casetable = createcasetable(segs, wobrange, inclinationrange, computefunction)
   results = pmap(runcase, casetable)
   println("Done!")
   
   results
 end
 