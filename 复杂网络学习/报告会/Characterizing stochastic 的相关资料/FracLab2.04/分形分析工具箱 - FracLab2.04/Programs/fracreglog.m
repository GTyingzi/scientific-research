function [out]=fracreglog(in,trshld,start_level,type_ond,siz1)

%Régularisation de signaux 1D par multiplication des coeff d'ondelettes par un nombre Xj
%entre 0 et 1 constant par echelle
%PL 2000

%Last review : january 2005  Pierrick Legrand

if isempty(type_ond)
q=MakeQMF('daubechies',10);
else
q=MakeQMF(type_ond,siz1);
end

n=floor(log2(max(size(in))));
[wt,wti,wtl,siz] =FWT(in,n,q);
d=trshld/5;


if isempty(start_level)
nn=floor((n+1)/2);
else
    nn=start_level;
end

o=zeros(1,n-nn);
rap=zeros(1,n-nn);
for j=1:n-nn
   o(j)=j+nn-(n+1)/2;
   rap(j)=(j+nn-(n+1)/2)^2/(2^(j+nn));
end;
somme=sum(rap);
k=12/(n^3-n);

% raz des multiplicateurs
xm=ones(1,n-nn);

% calcul des Xj 
for j=1:n-nn
   xm(j)=2^(-d*o(j)/(k*2^(j+nn)*somme));
end;

wtout=wt;
for sc=1:(n-nn),
	wtout( wti(sc):(wti(sc)+wtl(sc)-1) ) ...
        = thereglog(wt(wti(sc):(wti(sc)+wtl(sc)-1)), xm(n-nn-sc+1));
end;
	

if (d == 0)
  wtout = wt;
end

out=IWT(wtout);
out=out(1:siz);

function [out] = thereglog(in,s)
   out=in*s;
   
   
