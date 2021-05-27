function result = funcg(val,amin,gmin,amax,gmax,anod)

for i=1:1:size(val,2)

	if (val(i)<=anod)
	
		m = (1-gmin)/(anod-amin);
	
	else
	
		m = (gmax-1)/(amax-anod);
	
	end
	
	n = 1-m*anod;	
	result(i) = m*val(i)+n;
end