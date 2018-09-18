using BHAtp, Test

ProjDir = dirname(@__FILE__)
ProjName = split(ProjDir, "/")[end]

bha[:segs] = [
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

bha[:traj] = [
#   Heading,      Diameter
  ( 60.0,      9.0)
]

bha[:wobs] = 20:10:40
bha[:incls] = 20:10:40               # Or e.g. incls = [5 10 20 30 40 45 50]

properties, nodes, elements = input!(bha)

properties |> display
println()

nodes |> display
println()

elements |> display
println()



# mesh = problem()

# ... = solve()

#=
Needs to generate something like:

data = Dict(
  # Frame(nels, nn, ndim, nst, nip, finite_element(nod, nodof))
data = Dict(
  # Frame(nels, nn, ndim, nst, nip, finite_element(nod, nodof))
  :struc_el => Frame(7, 8, 2, 1, 1, Line(2, 3)),
  :properties => [
    1.0e10 1.0e6 20.0;
    1.0e10 1.0e6 50.0;
    1.0e10 1.0e6 80.0
     ],
  :etype => [1, 2, 2, 1, 3, 3, 1],
  :x_coords => [0.0,  0.0, 10.0, 20.0, 20.0, 35.0, 50.0, 50.0],
  :y_coords => [0.0, 15.0, 15.0, 15.0,  0.0, 15.0, 15.0,  0.0],
  :g_num => [
    1 2 3 5 4 6 8;
    2 3 4 4 6 7 7],
  :support => [
    (1, [0 0 0]),
    (5, [0 0 0]),
    (8, [0 0 0])
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
