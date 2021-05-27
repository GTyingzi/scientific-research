function [out]=frac_bayes(in,trshld,niveau,type_ond,siz1,KM)



q=MakeQMF(type_ond,siz1);
n=floor(log2(max(size(in))));
[wt,wti,wtl,siz] =FWT(in,n,q);
d=trshld;N=2^n;
wtout=wt;

%%%%%%%%find the Kj%%%%%%%%%%%%%%%%
maximum=zeros(1,n-niveau+1);
K=zeros(1,n-niveau+1);
for sc=1:(n-niveau+1),
        maximum(sc)=max(wt(wti(sc):(wti(sc)+wtl(sc)-1)));
        K(sc)=maximum(sc);%*2^((n-sc+1)*trshld);
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=max(K);
for sc=1:(n-niveau+1),
	wtout( wti(sc):(wti(sc)+wtl(sc)-1) ) ...
        = thebayes(wt(wti(sc):(wti(sc)+wtl(sc)-1)), 2.^(-trshld*(n-sc+1)),K(sc));
end;
	
out=IWT(wtout);
out=out(1:siz);

function [out] = thebayes(in,s,k)
 	tmp = abs(in);
    signe=sign(in);
 	out = max(tmp.*((tmp/k)<s) , k*s*((tmp/k)>=s)); 
    out=signe.*out;

