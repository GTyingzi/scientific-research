function [mBm2D, basefBm2D] = mBm2DQuantif(n,k,H,seed)
%   mBm2DQuantif
%   Synthesis of a multifractional Brownian motion
%   Olivier Barrière
%   January 20006
%
%   Generates a 2D Multi-Fractional Brownian Motion (mBm) using
%   Peltier and Levy Véhel approximation and a prequantification
%
%   1.  Usage
%
%   ______________________________________________________________________
%   mBm2D = mBm2DQuantif(n,k,H[,tmax[,sigma[,seed]]])
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
%   mBmQuantifKrigeage, mBm2DQuantifKrigeage
%
%   3.  Examples
%
%   % Synthesis
%   x = linspace(0,1,256); y = linspace(0,1,256); [X,Y]=meshgrid(x,y); f = inline('0.1+0.8*x.*y','x','y'); Hxy = f(X,Y);
%   mBm2D=mBm2DQuantif(256,25,Hxy);


switch nargin
  case 3
    seed = rand(1) * 1e6 ;
end

avancement = 0;
h_waitbar = fl_waitbar('init');
n2 = n^2;
mBm2D=zeros(n,n);

%Mise à plat de H
%for i = 1:n
%	for j = 1:n
%		Hline(i+n*(j-1)) = H(i,j);	
%	end
%end
Hline = reshape(H,[1 n^2]);

%k-moyennes
[moy, out] = k_means(Hline,k);

%Remise sous forme Matricielle, avec la kième valeur obtenue
%for i = 1:n
%	for j = 1:n
%		Hk(i,j) = out(i+n*(j-1));
%		Hk2(i,j) = moy(Hk(i,j));
%	end
%end
Hk =  reshape(out,[n n]);
Hk2 =  reshape(moy(out),[n n]);

%disp('K moyennes..  OK');


%Précalcul des k fBm 2D avec les entrées aléatoires.
randn('seed',seed);
W = fft2(randn(2*n));
Wx = fft(randn(2*n,1))/sqrt(2*n);
Wy = fft(randn(1,2*n))/sqrt(2*n);

avancement = 0;
for i = 1:k
	basefBm2D(:,:,i) = synth2(n,moy(i),'strfbm',W,Wx,Wy)/(n2^moy(i));
	%p=5;
	%if avancement < fix(100/p*i/(k+1))
    		%avancement = fix(100/p*i/(k+1));
    		%fprintf('%d %% \n', p*avancement); 
	%end
	fl_waitbar('view',h_waitbar,i,k);
end


for i=1:n
	for j=1:n
	%Localement, un mBm est un fBm
	    	mBm2D(i,j) = basefBm2D(i,j,Hk(i,j));
	end
end

fl_waitbar('close',h_waitbar);
