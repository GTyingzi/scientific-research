
function [vectech,vectlog]=radius(in,point,rad,prof)
%in=Wei0;
%rad=2;
%point=128;
type_ond='daubechies';
siz=10;
N=length(in);
n=floor(log2(N));

%%%%%%%%%%% Création du filtre %%%%%%%%%%%%
q=MakeQMF(type_ond,siz);
[wt,wti,wtl] =FWT(in,n,q);


%%%%%%%%%%% Extraction des coeffs %%%%%%%%%
c=zeros(n,-wti(1)+wti(2));
for j=1:n
   for i=1:-wti(j)+wti(j+1)
      c(n-j+1,i)=wt(wti(j)+i-1);
   end;
end;

%vect=ones(1,n);
%valmin=max(1,floor(point/2)-rad)
%valmax=min(N,floor(point/2)+rad)
%[a,b]=max(abs(c(n,valmin:valmax)))
%vect(n)=c(n,valmin+b-1)

vectech=[];
vectlog=[];
k0=floor(point/2);
start=n;
while start>0%~=1
   x1=max(1,k0-rad);
   x2=min(N,k0+rad);
   vectmax=[];
   lieumax=[];
   for k=1:min(start,prof+1);%start:start-prof
      %start,k;
      j=start-k+1;%,x1,x2;
      [a,b]=max(c(j,x1:x2));
      vectmax=[vectmax a]
      lieumax=[lieumax b+x1-1]
      x1=ceil(x1/2);
      x2=ceil(x2/2);
      if j==1
         %j=(start-prof+1);
         k=prof+2;
      end;
   end;
   [a,b]=max(vectmax);
   vectech=[vectech start-b+1];
   vectlog=[vectlog (c(start-b+1,lieumax(b)))]
   if start==start-b+1 & k0==lieumax(b);
      start=start-b;
      k0=ceil(k0/2);
      %b,lieumax
   else
      %b,lieumax
      start=start-b;
      k0=lieumax(b);
      %vectech=[vectech start-b+1];
      %vectlog=[vectlog (c(start-b+1,lieumax(b)))];
   end;
 end;   