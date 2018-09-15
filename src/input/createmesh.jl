function createmesh!(data::Dict{Symbol, Any})
  
  seg = data[:segs]
  bha[:materials] = materials
    # Future: Use updatematerialtable() to add or change an entry in the materials table
  bha[:media] = media
  # Future: Use updatemediatable() to add or change an entry in the media table
  bha[:medium] = :mud
  bha[:noofelements] = Int(sum([bha[:segs][i][3] for i in 1:length(bha[:segs])]))
  bha[:noofnodes] = bha[:noofelements] + 1

  elements = [BHAtp.Element() for i in 1:data[:noofelements]]
  nodes = [BHAtp.Node() for i in 1:data[:noofnodes]]
  mesh = [BHAtp.MeshRecord() for i in  1:data[:noofelements]]
  propertties = fill(0.0, length(seg), 4)

  el = 0
  sgmedium = data[:media][data[:medium]] / 231.     # in [in^3]
  for i in 1:length(seg)
    mat = data[:materials][seg[i][2]]
    radius = seg[i][5] / 2.0
    dm2 = seg[i][5]^2 - seg[i][4]^2
    dm4 = seg[i][5]^4 - seg[i][4]^4
    dp2 = seg[i][5]^2 + seg[i][4]^2
    if seg[i][1] in [:bit, :stabilizer]
      if (el+1) < data[:noofelements] && radius > nodes[el+1].stringradius
        nodes[el+1].fc = seg[i][6]
        nodes[el+1].stringradius = radius
      end
    else
      nels = Int(seg[i][3])
      elength = 12.0      # [in]

      # Cross sectional area: csa = pi * d^2 / 4
      csa = pi * dm2 / 4.0
      sgstring = mat.sg
      eweight = elength * csa * (sgstring - sgmedium)
      
      # See http://en.wikipedia.org/wiki/Area_moment_of_inertia
      # Area moment of inertia: Pi * r^4 / 4 or Pi * d^4 / 64

      # See http://en.wikipedia.org/wiki/Polar_moment_of_inertia
      # Polar moment of inertia: Pi * r^4 / 2 or Pi * d^4 / 32
      
      ea = csa * mat.ea
      er = pi * mat.ex * dm4 / 64
      gj = pi * mat.gj * dm4 / 32

      for j in 1:nels
      	el += 1
	
      	# nodes[1] is usually the bit or a 1st support for deflection testing
      	# nodes[1] = 0.0, add length of element.

        nodes[el+1].z = nodes[el].z + elength
        if typeof(seg[i]) in [Pipe, Collar]
          elements[el].ea = ea
          elements[el].er = er
          elements[el].gj = gj
        else
          # Adjust these values for Stabilizers. :od is not the whole story.
          elements[el].ea = 0.58 * ea
          elements[el].er = 0.68 * er
          elements[el].gj = 0.36 * gj
        end
		
				# Use largest stringRadius if 2 elements differ.
		
        if radius > nodes[el].stringradius
          nodes[el].fc = seg[i][6]
        end
				nodes[el].stringradius = max(radius, nodes[el].stringradius)
				nodes[el+1].fc = seg[i].fc
				nodes[el+1].stringradius = radius
		
				# Pattern always the same, asign 0.5 to this node and 0.5 to next node,
				# during next loop add 0.5 of next element.
		
				nodes[el].weight += eweight / 2.0
				nodes[el+1].weight = eweight / 2.0
		
				# Set element data if it is not a "(Exc)Stab(ilizer)" or "NBS" or "Bit" or "Rig"

				if typeof(seg[i]) in [Pipe, Collar]
					elements[el].fc = seg[i][6]
					elements[el].length = elength
					elements[el].radius = radius
					elements[el].od = seg[i][5]
					elements[el].id = seg[i][4]
				end
      end
    end
  end
  (mesh, properties, nodes, elements)
end