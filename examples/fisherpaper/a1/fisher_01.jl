using BHAtp, DataFrames, Distributed, Test

ProjDir = dirname(@__FILE__)
ProjName = split(ProjDir, "/")[end]

#bha = BHA(ProjName, ProjDir)
#bha.ratio = 1.7
#bha.medium = :lightmud

materials = materialtable()
println()
display(materials)
println()

media = mediatable()
println()
display(media)
println()

segments = [
# Element type,  Material,    Length,     OD,         ID,        fc,     noofelements
  :bit,                    :steel ,        0.00,      2.75,      12.25,     0.0,         0,
  :collar ,              :monel ,    25.00,      2.75,       7.75,      0.0,       25,  
  :stabilizer,         :steel,         0.00,       2.75,     12.125,    0.0,         0,
  :collar,             :steel,         30.00,      2.75,       7.75,      0.0,        30,
  :stabilizer,       :steel,          0.00,       2.75,     12.125,    0.0,          0,
  :collar,             :steel,        30.00,       2.75,      7.75,      0.0,         30,
  :stabilizer,       :steel,          0.00,       2.75,     12.125,    0.0,          0,
  :collar,             :steel,        90.00,       2.75,      7.75,      0.0,         90,
  :stabilizer,       :steel,          0.00,       2.75,     12.125,    0.0,          0,
  :pipe,               :steel,     100.00,       2.75,      7.75,       0.0,       100
];

traj = [
#   Heading,      Diameter
   60.0,      12.25
]

segment_types = [Symbol, Symbol, Float64, Float64, Float64, Float64, Int]
segment_names = [:eltype, :material, :length, :id, :od, :frictioncoefficient, :noofelements]

segs = reshape(segments, (7, :));

segments = DataFrame(segment_types, segment_names, 0)
for i in 1:size(segs, 2)
  seg = segs[:, i]
    append!(segments,
      DataFrame(eltype=seg[1], material=seg[2], length=seg[3], id=seg[4], od=seg[5],
        frictioncoefficient=seg[6], noofelements=seg[7])
    )
end

println()
display(segments)
println()

element_types = [Symbol, Symbol, Float64, Float64, Float64, Int, Float64, Float64, Float64, Float64]
element_names = [:eltype, :material, :length, :id, :od, :etype, :ea, :ei, :gj, :holediameter]

elements = DataFrame(element_types, element_names, 0)
j = 0
for i in 1:size(segments, 1)
  seg = segments[i, :]
  if seg[:eltype][1] in [:collar, :pipe]
    # New etype
    j += 1          
    append!(elements, 
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

println()
display(elements)
println()

wobrange = 45:5:55
inclinationrange = 35:5:55           # Or e.g. incls = [5, 10]

println()
@time results = tprun(Float64.(segs[3:end, :]), wobrange, inclinationrange, p44_1, ProjDir)

sleep(1)
println("\nSize of result  array of tuples = $(size(results))\n")

#=
Needs to generate something like:

data = Dict(
  # Frame(nels, nn, ndim, nst, nip, finite_element(nod, nodof))
  :struc_el => Frame(10, 11, 2, 1, 1, Line(2, 3)),
  :properties => [
    1.07207e9 4.53116e9;],
  :x_coords =>0.0:1.0:10.0,
  :y_coords => [0.0 for i in 1:11],
  :g_num => [
    1 2 3 4 5 6 7 8 9 10;
    2 3 4 5 6 7 8 9 10 11],
  :support => [
    (1, [1 0 1]),
    (5, [1 0 1]),
    (11, [0, 1, 1])
    ],
  :loaded_nodes => [
    (1, [10000.0 -600.0 -600.0]),
    (2, [0.0 -600.0 0.0]),
    (3, [0.0 -600.0 0.0]),
...
    (10, [0.0 -600.0 0.0]),
    (11, [0.0 -600.0 -600.0])
    ],
  :penalty => 1e19,
  :eq_nodal_forces_and_moments => [
    (1, [0.0 -60.0 -60.0 0.0 -60.0 60.0]),
    (2, [0.0 -120.0 -140.0 0.0 -120.0 140.0]),
    (3, [0.0 -20.0 -6.67 0.0 -20.0 6.67])
  ]
)
  =#
