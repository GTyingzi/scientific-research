function [a,f]=lump2s(a1,f1,a2,f2,N)
a_min=min(min(a1),min(a2));
a_max=max(max(a1),max(a2));
a=linspace(a_min,a_max,N);
sf1=interp1(a1,f1,a);
sf2=interp1(a2,f2,a);
for i=1:N
  f(i)=max(sf1(i),sf2(i));
end
return;
