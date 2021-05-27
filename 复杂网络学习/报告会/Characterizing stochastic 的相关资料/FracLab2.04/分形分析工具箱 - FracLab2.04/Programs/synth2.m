function [B I2 Ix Iy] = synth2(M,H,core,W,Wx,Wy)
%   synth2
%   Stationary Increments 2D Process
%   B. Pesquet-Popescu (ENS-Cachan)
%   February 20th 1998
%
%   Modified by Olivier Barrière  (optionnal Gaussian Variables)
%   September 2004
%
%   Incremental Fourier synthesis method for processes with stationary
%   increments of order (0,1) and (1,0)
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [B] = synth2(M,H,core)
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   M  : Positive integer
%      Vertical/Horizontal dimension of the generated field
%
%   o   H  : Real in [0,1]
%      parameter of the structure function (e.g. : Hurst parameter)
%
%   o   core  : string
%      Name of the structure function of type core(x,y,H) with x,y :
%      vertical/horizontal coordinates
%
%   1.2.  Output parameters
%
%   o   B  : real matrix  [N,N]
%      Synthesized random field
%
%   2.  See also:
%
%   fbmlevinson, fbmcwt, fbmfwt, mbmlevinson
%
%   3.  Example:
%
%   4.  Examples
%
%   % clean figure
%   clf
%   % Computes a [128 x 128] stationary increment process with isotropic H = 0.8
%   [B] = synth2(128,0.8,'strfbm') ;
%   % Visualization of the matrix (in linear dynamic and pseudo color)
%   viewmat(B)
%

% This Software is ( Copyright INRIA . 1998 1999  1 )
% 
% INRIA  holds all the ownership rights on the Software. 
% The scientific community is asked to use the SOFTWARE 
% in order to test and evaluate it.
% 
% INRIA freely grants the right to use modify the Software,
% integrate it in another Software. 
% Any use or reproduction of this Software to obtain profit or
% for commercial ends being subject to obtaining the prior express
% authorization of INRIA.
% 
% INRIA authorizes any reproduction of this Software.
% 
%    - in limits defined in clauses 9 and 10 of the Berne 
%    agreement for the protection of literary and artistic works 
%    respectively specify in their paragraphs 2 and 3 authorizing 
%    only the reproduction and quoting of works on the condition 
%    that :
% 
%    - "this reproduction does not adversely affect the normal 
%    exploitation of the work or cause any unjustified prejudice
%    to the legitimate interests of the author".
% 
%    - that the quotations given by way of illustration and/or 
%    tuition conform to the proper uses and that it mentions 
%    the source and name of the author if this name features 
%    in the source",
% 
%    - under the condition that this file is included with 
%    any reproduction.
%  
% Any commercial use made without obtaining the prior express 
% agreement of INRIA would therefore constitute a fraudulent
% imitation.
% 
% The Software beeing currently developed, INRIA is assuming no 
% liability, and should not be responsible, in any manner or any
% case, for any direct or indirect dammages sustained by the user.
% 
% Any user of the software shall notify at INRIA any comments 
% concerning the use of the Sofware (e-mail : FracLab@inria.fr)
% 
% This file is part of FracLab, a Fractal Analysis Software


N = 2*M;

switch nargin
  case 3
    W = fft2(randn(N));
    Wx = fft(randn(N,1))/sqrt(N); % variance of Wx, Wy equal to 1
    Wy = fft(randn(1,N))/sqrt(N);
end

%  Step 1 
%---------

% synthesis of the driving white zero-mean Gaussian noise

%W = fft2(randn(N));

% Step 2
%--------

% computation of the matrices Ind1 and Ind2 of vertical and horizontal coordinates 
% the vertical coordinates are between 0:N/2
% and the horizontal coordinates are between 0:N/2 or -N/2+1:-1

ind = 0:N/2;	% k_y, m_x, m_y
ind1 = [ind -N/2+1:-1];
[Ind1,Ind2]= meshgrid(ind,ind1);
Ind1 = Ind1.';
Ind2 = Ind2.';

% computation of the correlation of the increments of order (1,1)

r2 = 1/2*(2*(feval(core,Ind1+1,Ind2,H)+feval(core,Ind1-1,Ind2,H)+...
feval(core,Ind1,Ind2+1,H)+feval(core,Ind1,Ind2-1,H))-...
(feval(core,Ind1+1,Ind2+1,H)+feval(core,Ind1+1,Ind2-1,H)+...
feval(core,Ind1-1,Ind2+1,H)+feval(core,Ind1-1,Ind2-1,H))-4*feval(core,Ind1,Ind2,H));

% symmetrisation of the 2D correlation function
r2 = symcori(r2);

% Step 3
%--------
% compute the power spectrum

S2 = real(fft2(r2));
clear r2

% Step 4
%--------
% truncate the negative part of the spectrum 

t = find(S2(:)<0);  S2(t) = zeros(size(t));
S2(1,:) = zeros(1,N); S2(:,1) = zeros(N,1);

% Step 5
%--------
% compute the DFT coefficients

I2 = sqrt(S2).*W;
clear S2 W

% Step 6
%--------
% compute the increments of order (1,1)

i2 = real(ifft2(I2));
inds = 1:M;
i2 = i2(inds,inds);

% Step 7
%-------

%Wx = fft(randn(N,1))/sqrt(N); % variance of Wx, Wy equal to 1
%Wy = fft(randn(1,N))/sqrt(N);

% Step 8 
%-------- 
% calculate correlation functions of first order increments 
 
rx = 1/2*(feval(core,Ind1+1,Ind2,H)+feval(core,Ind1-1,Ind2,H)... 
-2*feval(core,Ind1,Ind2,H)); 
ry = 1/2*(feval(core,Ind1,Ind2+1,H)+feval(core,Ind1,Ind2-1,H)... 
-2*feval(core,Ind1,Ind2,H)); 
 
% symmetrically expand 
 
rx = symcori(rx); 
ry = symcori(ry); 
 
 
% Step 9 
%-------- 
% spectrum of the increments of order (1,0)/(0,1) 
 
Sx = real(fft(sum(rx.'))).';
Sy = real(fft(sum(ry))) ;
clear rx ry 
 
% Step 10 
%--------- 
% keep the positive part of the spectra 
 
t = find(Sx<0); Sx(t) = zeros(size(t)); 
t = find(Sy<0); Sy(t) = zeros(size(t)); 
 
% Step 11 
%--------- 
% DFT coefficients of the increments of order (1,0)/(0,1) 
 
Ix = zeros(N); Iy = zeros(N); 
indis = 1:N-1; 
 
Ix(indis+1,indis+1) = -i*I2(indis+1,indis+1)/2.*(ones(N-1,1)*... 
(exp(-i*pi*indis/N)./sin(pi*indis/N))); 
 
Iy(indis+1,indis+1) = -i*I2(indis+1,indis+1)/2.*... 
((exp(-i*pi*indis/N)./sin(pi*indis/N)).'*ones(1,N-1)); 
 
Ix(:,1) = N*sqrt(Sx).*Wx; % variance of the noise normalized to N^2 
Iy(1,:) = N*sqrt(Sy).*Wy ;

 
% Step 12 
%--------- 
% first order increments along the image boundaries 
 
ix = ifft(mean(Ix.')).'; 
ix = real(ix(1:M)); 
 
iy = ifft(mean(Iy)); 
iy = real(iy(1:M)); 
%clear Ix Iy 
 
% Step 13 
%--------- 
% add up the increments to obtain the fBm 
 
B = zeros(M); 
B(1,1) = 0; 
 
for mx = 2:M 
    B(mx,1) = B(mx-1,1) + ix(mx-1); 
end 
 
for my = 2:M 
    B(1,my) = B(1,my-1) + iy(my-1); 
end 
 
 
for mx = 2:M 
	for my = 2:M 
	    B(mx,my) = B(mx,my-1)+B(mx-1,my)-B(mx-1,my-1)+i2(mx-1,my-1); 
	end 
end 
 
