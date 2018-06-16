
#=
Compare formulas at:
http://www.awc.org/pdf/codes-standards/publications/design-aids/AWC-DA6-BeamFormulas-0710.pdf
=#

data = Dict(
  # Frame(nels, nn, ndim, nst, nip, finite_element(nod, nodof))
  :struc_el => Frame(200, 201, 3, 1, 1, Line(2, 3)),
  :properties => [1.0e6 1.0e6 1.0e6 3.0e5;],
  :x_coords => range(0, stop=4, length=201),
  :y_coords => zeros(201),
  :z_coords => zeros(201),
  :g_num => [
    collect(1:200)';
    collect(2:201)'],
  :support => [
    (1, [0 0 0 0 0 0]),
    (201, [0 0 0 0 0 0]),
    ],
  :loaded_nodes => [
    (101, [0.0 -10000.0 0.0 0.0 0.0 0.0])]
)

@time m, dis_df, fm_df = p44(data)

# See figure 24 in above reference (Δmax): 
@eval @test round.(m.displacements[2,101], digits=11) ≈ -0.00333333333

# See figure 24 in above reference (Mmax): 
@eval @test m.actions[12,101] ≈ 4899.999997801155
  