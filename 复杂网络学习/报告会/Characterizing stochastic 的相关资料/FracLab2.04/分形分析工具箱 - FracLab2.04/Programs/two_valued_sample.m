function n = two_valued_sample(a,k)

mu = 2*a+2*k*(1-a);
r = rand;
if r<(2*a/mu)
	n = 2;
else
	n = 2*k;
end