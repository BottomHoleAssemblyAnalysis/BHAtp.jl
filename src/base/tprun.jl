 function tprun(segs, wobrange, inclinationrange, computefunction::Function, pdir)
   
   casetable = createcasetable(segs, wobrange, inclinationrange, computefunction, pdir)
   pmap(runcase, casetable)
   
 end
 