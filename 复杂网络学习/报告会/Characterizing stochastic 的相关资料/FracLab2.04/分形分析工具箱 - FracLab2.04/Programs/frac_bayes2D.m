function [out]=frac_bayes2D(in,trshld,niveau,type_ond,siz1)

q=MakeQMF(type_ond,siz1);
n=floor(log2(max(size(in))));
d=trshld;N=2^n;
[wt,wti,wtl,siz] =FWT2D(in,n,q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wnbsc = WT2DNbScales(wt);
wtout=wt;
%%%%%%%%find the Kj%%%%%%%%%%%%%%%%
maximum=zeros(1,wnbsc-niveau+1);
K=zeros(1,wnbsc-niveau+1);
maximum1=zeros(1,3);
for sc=1:(wnbsc-niveau+1),
    for j=1:3,
      maximum1(j)=max(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ));
    end;
    maximum(sc)=max(maximum1);
    K(sc)=maximum(sc);%*2^((wnbsc-sc+1)*trshld);
end;
k=max(K);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for sc=1:(wnbsc-niveau+1),
    for j=1:3,
      wtout( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ) ...
	   = the2dbayes(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ), ...
	  2.^(-trshld*(wnbsc-sc+1)),k);
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
out=IWT2D(wtout);
out=out(1:siz(1),1:siz(2));

function [out] = the2dbayes(in,s,k)
 	tmp = abs(in);
    signe=sign(in);
 	out = max(tmp.*((tmp/k)<s) , k*s*((tmp/k)>=s)); 
    out=signe.*out;
    
    
    

