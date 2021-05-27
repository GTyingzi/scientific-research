function n = geom(a)

r = rand;
n = 1;
prb = a;
while r > prb
    n = n + 1;
    prb = prb + (1-a)^(n-1)*a;
end
n = 2*n;