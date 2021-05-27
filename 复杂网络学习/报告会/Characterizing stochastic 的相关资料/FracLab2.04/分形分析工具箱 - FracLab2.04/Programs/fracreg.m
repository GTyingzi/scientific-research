function [out]=fracreg(in,trshld,niveau,type_ond,siz1)

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

if nargin<3
    %niveau=ceil((n)/2);
    niveau=(floor(log2(N))-floor((log2(N))/2)+1);
end    
niveau;

[wt,wti,wtl,siz] =FWT(in,n,q);
d=trshld;N=2^n;
%nn=n-niveau;
%nn=floor((n+1)/2);
nn=n-niveau+1;

for sc=1:(nn),
	energie(sc)=(wt(wti(sc):(wti(sc)+wtl(sc)-1)))*(wt(wti(sc):(wti(sc)+wtl(sc)-1)))';
end;

energie=energie(end:-1:1);

o=zeros(1,n);
for j=1:n
    o(j)=j-(n+1)/2;
   %o(j)=n-j+1-(n+1)/2;
end;

o=o(niveau:n);

ot=sum(o);
k=12/(n^3-n);

% raz des multiplicateurs
xm=ones(1,nn);


% la fonction a minimiser depend du rapport des energies par 
%niveau sur les o(j)
r=zeros(1,nn);
for j=1:nn
    r(j)=energie(j)/o(j);
end;
rm=min(r);
dl=d/k;


% %%%%%%%%%%%%%%%%Matrice de tous les cas%%%%%%%%%%
% m1=cell(2^(n-nn),n-nn,1);
% tmp=2;
% m1(1,1,1)={[1]};  
% m1(2,1,1)={[-1]};
% for i=1:n-nn-1
%    for j=1:tmp
%       m1(2*(j-1)+1,i+1,1)={[m1{j,i,1} 1]};
%       m1(2*j,i+1,1)={[m1{j,i,1} -1]};
%    end;
%    tmp=tmp*2;
% end;      
% 
% m2=zeros(2^(n-nn),n-nn);
% for i=1:n-nn
%    for j=1:2^(n-nn)
%       m2(j,i)=m1{j,n-nn,1}(i);
%    end;
% end;

m2=ones(n-nn+1,n-nn);
for j=1:n-nn
    m2(j+1,1:j)=-1*ones(1,j);
end;
m2;
% 
% 
% %%%%%%%%%%%%%%%%optimisation%%%%%%%%%%%%%%%%%%%%%
p=version;
oldopt= optimset('display','final','LargeScale','on', ...
   'TolX',1e-6,'TolFun',1e-6,'DerivativeCheck','off',...
   'Jacobian','off','MaxFunEvals','100*numberOfVariables',...
   'Diagnostics','off',...
   'DiffMaxChange',1e-1,'DiffMinChange',1e-8,...
   'PrecondBandWidth',0,'TypicalX','ones(numberOfVariables,1)','MaxPCGIter','max(1,floor(numberOfVariables/2))', ...
   'TolPCG',0.1,'MaxIter',400,'JacobPattern',[], ...
   'LineSearchType','quadcubic','LevenbergMarq','off');
if str2num(p(1))>5
  options=optimset(oldopt,'Display','off');
else 
  options=optimset(oldopt);
end;


eps1=zeros(1,nn);
for i=1:nn
   eps1(i)=inf;
end;   
v=zeros(1,nn);
mu=inf;mu1=inf;
%for s=1:2^(n-nn)
for s=1:nn    
  [mu,fval,exitflag]=fsolve('lagr3',1^(-10),options,m2,s,nn,n,r,dl,ot,o);
  %[mu,fval,exitflag]=frac_dicho(0,rm,m2,s,nn,n,r,dl,ot,o);
  if exitflag>0 & ((mu/rm)-1)<0 & mu>0 
     v(s)=real(mu);
     eps2=0;
     for j=1:nn
        xm(j)=real((1+m2(s,j)*sqrt(1-mu/r(j)))/2);
        eps2=real(eps2+energie(j)*(1-xm(j))^2);
     end;
     eps1(s)=eps2;
  end;   
end;

[a,b]=min(eps1);
mu1=v(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
 
% calcul des Xj a partir de mu
   for j=1:nn
      xm(j) = real((1+m2(b,j)*sqrt(1-mu1/r(j))))/2;
   end;
%blindage
   if min(eps1)==inf & d~=0
      xm(:)=0;
   end;   
xm;

wtout=wt;
for sc=1:(nn),
	wtout( wti(sc):(wti(sc)+wtl(sc)-1) ) ...
        = thereg(wt(wti(sc):(wti(sc)+wtl(sc)-1)), xm(sc));
end;
	
out=IWT(wtout);
out=out(1:siz);
%figure;subplot(1,2,1);plot(in);subplot(1,2,2);plot(out);

function [out] = thereg(in,s)
    out=in*s;


