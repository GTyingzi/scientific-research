function [Cn,pc] = clip(C,cmax)

N = length(C) ;
Cn = C ;
count = 0 ;
for n=1:N,
	c = C(n) ;
	if abs(c) > cmax
		Cn(n) = sign(c)*cmax ;
		count = count+1 ;
	end
end
pc = (count/N) *100 ;