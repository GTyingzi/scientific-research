function [X, Hxy] = mBm2DQuantifKrigeage(n,k,H,seed)
%   mBm2DQuantifKrigeage
%   Synthesis of a multifractional Brownian motion
%   Olivier Barrière
%   January 20006
%
%   Generates a 2D Multi-Fractional Brownian Motion (mBm) using
%   Krigging and a prequantification
%
%   1.  Usage
%
%   ______________________________________________________________________
%   mBm2D = mBm2DQuantifKrigeage(n,k,H[,tmax[,sigma[,seed]]])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   n  : Positive integer
%      Vertical/Horizontal dimension of the generated field
%
%   o   k  : Positive integer
%      Number of levels for the prequantification
%
%   o   H  : Real matix [N,N] 
%      H contains the discretized Holder exponents at each position. 
%      Each element in [0,1].
%
%   o   seed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   mBm2D  : real matrix  [N,N]
%      Synthesized random field
%
%
%   2.  See also:
%
%   mBmQuantifKrigeage, mBm2DQuantif
%
%   3.  Examples
%
%   % Synthesis
%   x = linspace(0,1,256); y = linspace(0,1,256); [X,Y]=meshgrid(x,y); f = inline('0.1+0.8*x.*y','x','y'); Hxy = f(X,Y);
%   mBm2D=mBm2DQuantifKrigeage(256,25,Hxy);

switch nargin
  case 3
    seed = rand(1) * 1e6 ;
end

%Carré de taille n x n
n = [n n];


%x = linspace(0,1,n(1));
%y = linspace(0,1,n(2));
%[X,Y]=meshgrid(x,y);
%f = inline(fxy,'x','y');
%Hxy = f(X,Y);
Hxy=H;

eps = 10^-3;

H = min(1-eps,H) ;
H = max(eps,H) ;

h_waitbar = fl_waitbar('init');

Hline = reshape(H,[1 prod(n)]);

%k-moyennes
[moy, out, xmin, xmax] = k_means(Hline,k);
Hk =  reshape(out,n);
Hk2 =  reshape(moy(out),n);

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

%Step 1 and 2 : Generate u fBm 2D
U = k;

g = (fix(log(2*n-1)/log(2)+1));
m=2.^g;
W_xy = fft2(randn(m));
W_x = fft(randn(m(1),1))/sqrt(m(1));
W_y = fft(randn(1,m(2))).'/sqrt(m(2));

Bh = zeros(n(1),n(2),U);

for u=1:U+2
	Hu(u) = moy(u);
	Bh(:,:,u) = fastfBm2D(n,Hu(u),W_xy,W_x,W_y,1);
	fl_waitbar('view',h_waitbar,u/2,U+2);
end

for i=2:n(1)-1
fl_waitbar('view',h_waitbar,1/2*(n(1)-1)+i/2, n(1)-1);
	for j=2:n(2)-1
		% Zij = [B_Hv(k1,k2), (v,k1,k2) in Nij] taille 1*18
		I = [i-1 i-1 i-1 i i i i+1 i+1 i+1];
		I = [I I];
		J = [j-1 j j+1];
		J = [J J J J J J];
		u=1;
		while Hxy(i,j) >= Hu(u)
			u = u+1;
		end
		u = max(2,u);
		u = min(u,U);
		if abs(Hxy(i,j)-Hu(u)) < eps
		  X(i,j) = Bh(i,j,u);
		elseif abs(Hxy(i,j)-Hu(u-1)) < eps
		  X(i,j) = Bh(i,j,u-1);
		else
  		H_index = [(u-1)*ones(1,9) (u)*ones(1,9)];
  		H = [Hu(u-1)*ones(1,9) Hu(u)*ones(1,9)];
  		for k=1:18
  			x1 = I(k);
  			x2 = J(k);
  			Hx = H(k);
  			
  			Z(k,1) = Bh(x1,x2,H_index(k));
  			
  			Hij = Hxy(i,j);
  			Hxy2 = (Hx+Hij)/2;
  			B(k,1) = gg(Hx,Hij)/2*((x1^2+x2^2)^Hxy2+(i^2+j^2)^Hxy2+((x1-i)^2+(x2-j)^2)^Hxy2);
  			
  			for l=1:18
  				y1 = I(l);
  				y2 = J(l);
  				Hy = H(l);
  				Hxy2 = (Hx+Hy)/2;
  				A(k,l) = gg(Hx,Hy)/2*((x1^2+x2^2)^Hxy2+(y1^2+y2^2)^Hxy2+((x1-y1)^2+(x2-y2)^2)^Hxy2);
  			end
  			
  		end
  		g_opt = inv(A)*B;
  		X(i,j) = g_opt'*Z;
  	end
	end
end

X = X(2:n(1)-1,2:n(2)-1);

fl_waitbar('close',h_waitbar);

function [gg] = gg(h1,h2)
gg = ii((h1+h2)/2)/sqrt(ii(h1)*ii(h2));

%%%%%%%%%%%%%%%%%%
function [ii]=ii(h);
if h<0.5
	q=1/h;
	ii=gamma(1-2*h)*q*sin(pi*(0.5-h));
elseif h==0.5;
	ii=pi;
else
	qq=1/(h*(2*h-1));
	ii=gamma(2-2*h)*qq*sin(pi*(h-0.5));
end;
