using BHAtp, Test

ProjDir = dirname(@__FILE__)
ProjName = split(ProjDir, "/")[end]

data = Dict{Symbol, Any}()

data[:segs] = [
# Element type,  Material,    Length,     OD,         ID,      fc,    NoOfElements
  (:bit,          :steel,     0.00,   2.75,   9.0,  0.0),
  (:collar,       :steel,    45.00,   2.75,   7.0,  0.0),
  (:stabilizer,   :steel,     0.00,   2.75,   9.0,  0.0),
  (:pipe,         :steel,    30.00,   2.75,   7.0,  0.0),
  (:stabilizer,   :steel,     0.00,   2.75,   9.0,  0.0),
  (:pipe,         :steel,    90.00,   2.75,   7.0,  0.0),
  (:stabilizer,   :steel,     0.00,   2.75,   9.0,  0.0),
  (:pipe,         :steel,   100.00,   2.75,   7.0,  0.0)
]

data[:traj] = [
#   Heading,      Diameter
  ( 60.0,      9.0)
]

data[:wobs] = 20:10:40
data[:incls] = 20:10:40             # Or e.g. incls = [5 10 20 30 40 45 50]

data[:materials] = materials
data[:media] = media
data[:noofelements] = Int(sum([data[:segs][i][3] for i in 1:length(data[:segs])]))
data[:noofnodes] = data[:noofelements] + 1

elements = [BHAtp.Element() for i in 1:data[:noofelements]]
nodes = [BHAtp.Node() for i in 1:data[:noofnodes]]

@test data[:materials][:monel].sg == 0.319
@test data[:noofelements] == 265
@test size(elements) == (265, )

println(BHAtp.MeshRecord())

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
