function erg = argmax(x,coeff,k,scale,sigma,amin,gmin,amax,gmax,anod)

	

if (x==0 | k==0)
	erg = 0;
	return;
end


erg = -scale .* funcg(log2(k.*x)./(-scale),amin,gmin,amax,gmax,anod) + (abs(coeff)-x).^2 / (2.*sigma.^2);
%erg = -erg;