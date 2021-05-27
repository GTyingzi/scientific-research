function [out]=frac_multden2D(in,trshld,niveau,type_ond,siz1)

q=MakeQMF(type_ond,siz1);
n=floor(log2(max(size(in))));
d=trshld;
[wt,wti,wtl,siz] =FWT2D(in,n,q);


%%%%%%%%%%%%%%%%%%%%%%%%%
wtout=wt;
for sc=1:(n-niveau+1),
    for j=1:3,
      wtout( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ) ...
	   = the2dpump(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ), ...
	  2.^(-trshld*(n-sc+1)));
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
out=IWT2D(wtout);
out=out(1:siz(1),1:siz(2));


function [out] = the2dpump(in,s)
out =  in.* s;
