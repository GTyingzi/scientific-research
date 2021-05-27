function [out]=fracreglog2d(in,trshld,start_level,type_ond,siz1)

%Régularisation de signaux 2D par multiplication des coeff d'ondelettes par un nombre Xj
%entre 0 et 1 constant par echelle
%PL 2000

%Last review : january 2005  Pierrick Legrand

if isempty(type_ond)
q=MakeQMF('daubechies',4);
else
q=MakeQMF(type_ond,siz1);
end

 n=floor(log2(max(size(in))));
 d=trshld/5;N=2^n;
 
if isempty(start_level)
nn=floor((n+1)/2);
else
    nn=start_level;
end

o=zeros(1,n-nn);
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
 xm2=xm(end:-1:1);  

[wt,wti,wtl,siz] =FWT2D(in,n,q);

%%%%%%%%%%%%%%%%%%%%%%%%%
wnbsc = WT2DNbScales(wt);
wtout=wt;
for sc=1:(wnbsc-nn),
    for j=1:3,
      wtout( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ) ...
	   = the2dreglog(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ), ...
	 xm2(sc));
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
out=IWT2D(wtout);
out=out(1:siz(1),1:siz(2));


function [out] = the2dreglog(in,s)
 	out = in*s;
    

