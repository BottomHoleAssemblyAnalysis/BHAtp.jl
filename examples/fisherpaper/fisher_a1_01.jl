using BHAtp, DataFrames, Distributed, Test

ProjDir = dirname(@__FILE__)
ProjName = split(ProjDir, "/")[end]

#bha = BHA(ProjName, ProjDir)
#bha.ratio = 1.7
#bha.medium = :lightmud

segs2 = [
# Element type,  Material,    Length,     OD,         ID,        fc
  :bit,                    :steel ,        0.00,      2.75,      12.25,     0.0,
  :collar ,              :monel ,    25.00,    2.75,   7.75,  0.0,
  :stabilizer,         :steel,         0.00,        2.75,   12.125,  0.0,
  :collar,             :steel,       30.00,        2.75,   7.75,  0.0,
  :stabilizer,       :steel,         0.00,         2.75,   12.125,  0.0,
  :collar,             :steel,       30.00,   2.75,   7.75,  0.0,
  :stabilizer,       :steel,         0.00,   2.75,   12.125,  0.0,
  :collar,             :steel,       90.00,   2.75,   7.75,  0.0,
  :stabilizer,       :steel,         0.00,   2.75,   12.125,  0.0,
  :pipe,               :steel,    100.00,   2.75,   7.75,  0.0
];

segs1 = reshape(segs2, (6, :));
syms = Array{Symbol, 2}(reshape(segs1[1:2, :], (2, :)))

global segs

segs = Array{Float64, 2}(reshape(segs1[3:6, :], (4, :)))

df = DataFrame([Symbol, Symbol, Float64], [:eltype, :material, :length], 0)
append!(df, DataFrame(eltype=:bit, material=:steel, length=0.0))

traj = [
#   Heading,      Diameter
  ( 60.0,      12.25)
]

wobrange = 45:5:55
inclinationrange = 35:5:55           # Or e.g. incls = [5, 10]

results = BHAtp.tprun(segs, wobrange, inclinationrange, p44_1)

println(size(results))

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
