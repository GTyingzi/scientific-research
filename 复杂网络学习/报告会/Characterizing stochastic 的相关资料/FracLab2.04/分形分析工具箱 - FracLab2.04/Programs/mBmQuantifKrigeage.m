function [mBm1D, z] = mBmQuantifKrigeage(n,k,H,tmax,sigma,seed)
%   mBmQuantifKrigeage
%   Enhanced Wood and Whan synthesis of a multifractional Brownian motion
%   Olivier Barrière
%   January 20006
%
%   Generates a Multi-Fractional Brownian Motion (mBm) using
%   Wood and Chan circulant matrix, some krigging, and a prequantification
%
%   1.  Usage
%
%   ______________________________________________________________________
%   mBm1D = mBmQuantifKrigeage(n,k,H[,tmax[,sigma[,seed]]])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   n  : Positive integer
%      Sample size of the fBm
%
%   o   k  : Positive integer
%      Number of levels for the prequantification
%
%   o   H  : Real vector [1,N] 
%      H contains the discretized Holder exponents at each time. 
%      Each element in [0,1].
%
%   o   seed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   mBm1D  : real vector  [1,N]
%      Time samples of the mBm
%
%
%   2.  See also:
%
%   fbmWoodChan
%
%   3.  Examples
%
%   % Synthesis of the Holder function H(t): 0 < t < 1
%   N=1024; t=linspace(0,1,N); Ht=eval('0.5+0.3*sin(4*pi*t)');
%   mBm0=mBmQuantifKrigeage(N,10,Ht,1,1);





switch nargin
  case 3
    tmax = 1 ; 
    sigma = 1 ;
    seed = rand(1) * 1e6 ;
  case 4
    sigma = 1 ;
    seed = rand(1) * 1e6 ;
  case 5
    seed = rand(1) * 1e6 ;
end

eps = 10^-3;

H = min(1-eps,H) ;
H = max(eps,H) ;

h_waitbar = fl_waitbar('init');

mBm1D=zeros(n,1);

%k-moyennes
[moy, out, xmin, xmax] = k_means(H,k);

%Pour ne jamais être dans le cas de "3 voisins" on rajoute les valeurs min et max aux k moyennes
%avec une marge de "sécurité"
moymin = moy(1);
moymax = moy(end);
if 2*xmin-moymin < 0
  moyinf = max(eps,xmin-10*eps);
else
  moyinf = 2*xmin-moymin;
end
if 2*xmax-moymax > 1
  moysup = min(1-eps,xmax+10*eps);
else
  moysup = 2*xmax-moymax;
end
moy = [ moyinf moy moysup ];

%disp('K moyennes..  OK');

%Précalcul des k fBm 1D avec les entrées aléatoires.
%randn('seed',seed);
%ar = randn(n,1);
%ai = randn(n,1);

for i = 1:k+2
	basefBm1D(:,i) = fBmWoodChan(n,moy(i),1,1,seed);
	fl_waitbar('view',h_waitbar,i/2,k+2);
end

%disp('Base fBms..  OK');

Hu = zeros(n,1);
%Recherche du voisinage en H
for i = 1:n
	ind = out(i);
	if H(i) < moy(ind+1)
		Hu(i) = ind;
	else
		Hu(i) = ind+1;
	end
end
Hu1 = Hu+1;


%disp('Voisinage en H..  OK');

%Vérification de l'encadrement
%figure;
%plot(H);
%hold;
%plot(moy(Hu), 'g');
%plot(moy(Hu1), 'r');

%Krigeage
%Calculating of some common coefficients for covariance matrices
for i = 1:k+2
	q(i)=ii(moy(i));
end 
for i = 2:k+2
	f(i)=0.5*ii((moy(i)+moy(i-1))/2)*(1/sqrt(q(i)*q(i-1)));
end 

for i = 2:n-1
   	hu = Hu(i);
   	hu1 = Hu1(i);
    if abs(H(i)-moy(hu)) < eps
		  mBm1D(i)=basefBm1D(i,hu);
 	    z(i)=abs(H(i)-moy(hu));
		elseif abs(H(i)-moy(hu1)) < eps
		  mBm1D(i)=basefBm1D(i,hu1);
 	    z(i)=abs(H(i)-moy(hu1));
		else  	
	   [v,err]=coeff(i,hu,hu1,q(hu),q(hu1),f(hu1),H(i),n,moy);
	   u=[basefBm1D(i-1,hu) basefBm1D(i,hu) basefBm1D(i+1,hu) basefBm1D(i-1,hu1) basefBm1D(i,hu1) basefBm1D(i+1,hu1)];
 	   mBm1D(i)=u*v;
 	   z(i)=err;
 	  end
	fl_waitbar('view',h_waitbar,1/2*(n-1)+i/2, n-1);
end

%disp('Krigeage..  OK');

%mBm1D = mBm1D(2:n-1);
%z = z(2:n-1);
mBm1D(n) = mBm1D(n-1);

fl_waitbar('close',h_waitbar);


%figure;
%plot(mBm1D);
%figure;
%plot(z);


function[v, err]=coeff(index,hu,hu1,h1,h2,f,h,n,moy);
%calculates the covariance matrix of basic FBMs and coefficients
% for the calculating of MFBM in the case of 6 grid neighbours of (t,H(t))
t=index/n;
tau=1/n;
num1=moy(hu);
num2=moy(hu1);
hh=ii(h);
f1=0.5*ii((num1+h)/2)*(1/sqrt(h1*hh));
f2=0.5*ii((num2+h)/2)*(1/sqrt(h2*hh));
b1=f1*[t.^(num1+h)+(t-tau)^(num1+h)-tau.^(num1+h) 2*t.^(num1+h) t.^(num1+h)+(t+tau).^(num1+h)-...
   tau.^(num1+h)];
b2=f2*[t.^(num2+h)+(t-tau)^(num2+h)-tau.^(num2+h) 2*t.^(num2+h) t.^(num2+h)+(t+tau).^(num2+h)-...
    tau.^(num2+h)];
b=[b1 b2]';
A=0.5*[2*(t-tau).^(2*num1) (t-tau).^(2*num1)+(t).^(2*num1)-tau.^(2*num1)  (t-tau).^(2*num1)+...
      (t+tau).^(2*num1)-(2*tau).^(2*num1);
0 2*(t).^(2*num1)  (t).^(2*num1)+(t+tau).^(2*num1)-tau.^(2*num1);    
 0 0  2*(t+tau)^(2*num1)];
A=A+triu(A,1)';
B=0.5*[2*(t-tau).^(2*num2) (t-tau).^(2*num2)+(t).^(2*num2)-tau.^(2*num2)  (t-tau).^(2*num2)+...
      (t+tau).^(2*num2)-(2*tau).^(2*num2);
0  2*(t).^(2*num2)  (t).^(2*num2)+(t+tau).^(2*num2)-tau.^(2*num2);    
 0 0  2*(t+tau)^(2*num2)];
B=B+triu(B,1)'; 
C=f*[2*(t-tau).^(num1+num2) (t-tau).^(num1+num2)+(t).^(num1+num2)-tau.^(num1+num2)...  
   (t-tau).^(num1+num2)+(t+tau).^(num1+num2)-(2*tau).^(num1+num2);
0  2*(t).^(num1+num2)  (t).^(num1+num2)+(t+tau).^(num1+num2)-tau.^(num1+num2);    
0  0  2*(t+tau)^(num1+num2)];
C=C+triu(C,1)';
D=[A C;C B];
covm=inv(D);
v=covm*b;
err=abs(t.^(2*h)-b'*v);
%clear A B C  n;
%t1=cputime-t0;


%%%%%%%%%%%%%%%%%%
function [ii]=ii(h);
if h<0.5
	q=1/h;
	ii=newgamma(1-2*h)*q*sin(pi*(0.5-h));
elseif h==0.5;
	ii=pi;
else
	qq=1/(h*(2*h-1));
	ii=newgamma(2-2*h)*qq*sin(pi*(h-0.5));
end;

function res = newgamma(z,a)
% MATLAB's function gamma(z) adjusted to the scalar z 0<z<1

%   Ref: Abramowitz & Stegun, Handbook of Mathemtical Functions, sec. 6.1.
%   Copyright (c) 1984-98 by The MathWorks, Inc.
%   $Revision: 5.10 $  $Date: 1997/11/21 23:45:34 $

%   This is based on a FORTRAN program by W. J. Cody,
%   Argonne National Laboratory, NETLIB/SPECFUN, October 12, 1989.
%
% References: "An Overview of Software Development for Special
%              Functions", W. J. Cody, Lecture Notes in Mathematics,
%              506, Numerical Analysis Dundee, 1975, G. A. Watson
%              (ed.), Springer Verlag, Berlin, 1976.
%
%              Computer Approximations, Hart, Et. Al., Wiley and
%              sons, New York, 1968.
%
ppp = [-1.71618513886549492533811e+0; 2.47656508055759199108314e+1;
     -3.79804256470945635097577e+2; 6.29331155312818442661052e+2;
      8.66966202790413211295064e+2; -3.14512729688483675254357e+4;
     -3.61444134186911729807069e+4; 6.64561438202405440627855e+4];
qqq = [-3.08402300119738975254353e+1; 3.15350626979604161529144e+2;
     -1.01515636749021914166146e+3; -3.10777167157231109440444e+3;
      2.25381184209801510330112e+4; 4.75584627752788110767815e+3;
     -1.34659959864969306392456e+5; -1.15132259675553483497211e+5];
 
                xnum=0;
                xden=1;
      for i = 1:8
         xnum = (xnum + ppp(i)) .* z;
         xden = xden .* z + qqq(i);
      end
      %                  res=xnum./xden+1;
            res=(xnum+xden)/(xden*z);
 %     res=xnum./xden +1;
%  Adjust result for case  0.0 < x < 1.0
%        res=res./z;
