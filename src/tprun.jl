 function tprun(segs, wobrange, inclinationrange, computefunction::Function)
   casetable = createcasetable(segs, wobrange, inclinationrange, computefunction)
   pmap(runcase, casetable)
   println("Done!")
 end
 