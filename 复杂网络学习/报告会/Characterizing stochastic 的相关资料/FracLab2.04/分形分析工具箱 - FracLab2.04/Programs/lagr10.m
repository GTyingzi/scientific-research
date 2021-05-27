function lag10=lagr10(mu,m2,s,nn,n,r,dl,ot,o,a)
lag10=dl-ot;
for j=1:nn
      lag10=lag10+o(j)*log2(1+m2(s,j)*sqrt(1-mu/(a(j)*r(j))));
   end;   