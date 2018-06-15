using BHAtp

ProjDir = dirname(@__FILE__)

data = Dict(
  # Frame(nels, nn, ndim, nst, nip, finite_element(nod, nodof))
  :struc_el => Frame(3, 4, 3, 1, 1, Line(2, 3)),
  :properties => [
    4.0e6 1.0e6 0.3e6 0.3e6],
  :x_coords => [0.0, 5.0, 5.0, 5.0],
  :y_coords => [5.0, 5.0, 5.0, 0.0],
  :z_coords => [5.0, 5.0, 0.0, 0.0],
  :gamma => [0.0, 0.0, 90.0],
  :g_num => [
    1 3 4;
    2 2 3],
  :support => [
    (1, [0 0 0 0 0 0]),
    (4, [0 0 0 0 0 0])
    ],
  :loaded_nodes => [
    (2, [0.0 -100.0 0.0 0.0 0.0 0.0])]
)

@time m, dis_df, fm_df = p44(data)

data |> display
println()

@time fem, dis_df, fm_df = p44(data)
println()

display(dis_df)
println()
display(fm_df)
println()
  
if VERSION.minor < 6
  using Plots
  gr(size=(400,600))

  p = Vector{Plots.Plot{Plots.GRBackend}}(3)
  titles = ["p44.1 rotations", "p44.1 y shear force", "p44.1 z moment"]
  moms = vcat(
    convert(Array, fm_df[:, :z1_Moment]), 
    convert(Array, fm_df[:, :z2_Moment])[end]
  )
  fors = vcat(
    convert(Array, fm_df[:, :y1_Force]), 
    convert(Array, fm_df[:, :y2_Force])[end]
  )
  x_coords = data[:x_coords]
  
  p[1] = plot(fem.displacements[3,:], ylim=(-0.002, 0.002),
    xlabel="node", ylabel="rotation [radians]", color=:red,
    line=(:dash,1), marker=(:circle,4,0.8,stroke(1,:black)),
    title=titles[1], leg=false)
  p[2] = plot(fors, lab="y Shear force", ylim=(-150.0, 250.0),
    xlabel="node", ylabel="shear force [N]", color=:blue,
    line=(:dash,1), marker=(:circle,4,0.8,stroke(1,:black)),
    title=titles[2], leg=false)
  p[3] = plot(moms, lab="z Moment", ylim=(-10.0, 150.0),
    xlabel="node", ylabel="z moment [Nm]", color=:green,
    line=(:dash,1), marker=(:circle,4,0.8,stroke(1,:black)),
    title=titles[3], leg=false)

  plot(p..., layout=(3, 1))
  savefig(ProjDir*"/Ex44.1.png")
  
end
