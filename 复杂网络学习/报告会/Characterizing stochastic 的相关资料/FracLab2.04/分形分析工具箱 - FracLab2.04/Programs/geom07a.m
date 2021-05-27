function n = geom07a

r = rand;
n = 1;
prb = 0.7;
while r > prb
    n = n + 1;
    prb = prb + 0.3^(n-1)*0.7;
end
n = 2*n;