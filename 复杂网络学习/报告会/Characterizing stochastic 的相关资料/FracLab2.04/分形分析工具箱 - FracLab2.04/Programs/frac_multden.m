function [out]=frac_multden(in,trshld,niveau,type_ond,siz1)



q=MakeQMF(type_ond,siz1);
n=floor(log2(max(size(in))));
[wt,wti,wtl,siz] =FWT(in,n,q);
d=trshld;
wtout=wt;

for sc=1:(n-niveau+1),
	wtout( wti(sc):(wti(sc)+wtl(sc)-1) ) ...
        = thepump(wt(wti(sc):(wti(sc)+wtl(sc)-1)), 2.^(-trshld*(n-sc+1)));
end;

out=IWT(wtout);
out=out(1:siz);

function [out] = thepump(in,s)
  out=in*s;



