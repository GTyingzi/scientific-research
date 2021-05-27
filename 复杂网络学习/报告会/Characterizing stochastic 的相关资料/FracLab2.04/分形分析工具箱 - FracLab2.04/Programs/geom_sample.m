function n = geom_sample(a)

r = rand;
n = 1;
prb = a^2;
while r > prb
    n = n + 1;
    prb = prb + n*(1-a)^(n-1)*a^2;
end
n = 2*n;