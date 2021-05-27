function lag3=lagr3(mu,m2,s,nn,n,r,dl,ot,o)
lag3=dl-ot;
for j=1:n-nn
      lag3=lag3+o(j)*log2(1+m2(s,j)*sqrt(1-2*mu/r(j)));
   end;   