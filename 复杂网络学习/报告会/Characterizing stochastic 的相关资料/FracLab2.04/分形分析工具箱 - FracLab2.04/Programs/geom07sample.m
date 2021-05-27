function n = geom07sample

r = rand;
n = 1;
prb = 0.7^2;
while r > prb
    n = n + 1;
    prb = prb + n*0.3^(n-1)*0.7^2;
end
n = 2*n;