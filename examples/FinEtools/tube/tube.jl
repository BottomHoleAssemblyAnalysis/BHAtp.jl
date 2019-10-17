using BHAtp, FinEtools

ProjDir = @__DIR__
cd(ProjDir)

h = 1.0
l = 3.0
nh = 1
nl = 3
nc = 6

fens, fes  = H8block(h, l, 2.0 * pi, nh, nl, nc) # generate a block
# Shape into a cylinder
R = zeros(3, 3)
for i = 1:count(fens)
    x, y, z = fens.xyz[i,:];
    rotmat3!(R, [0, z, 0])
    Q = [cos(psi * pi / 180) sin(psi * pi / 180) 0;
        -sin(psi * pi / 180) cos(psi * pi / 180) 0;
        0 0 1]
    fens.xyz[i,:] = reshape([x + Rmed - h / 2, y - l / 2, 0], 1, 3) * Q * R;
end
# Merge the nodes where the tube  closes up
candidates = selectnode(fens, box = boundingbox([Rmed - h -Inf 0.0; Rmed + h +Inf 0.0]), inflate = tolerance)
fens, fes = mergenodes(fens, fes,  tolerance, candidates);

rin = 0.6*phun("m")
rex = 0.7*phun("m")
nr = 1
nc = 6
Angl = 0.0

fens, fes = Q4annulus(rin::FFlt, rex::FFlt, nr::FInt, nc::FInt, Angl::FFlt)

