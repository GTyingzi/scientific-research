function [x,y,r] = mbmlevinson(N,H,tmax,sigma,seed) ;
%   mbmlevinson
%   Levinson synthesis of a multifractional Brownian motion
%   Paulo Goncalves
%   June 6th 1997
%
%   Generates a Multi-Fractional Brownian Motion (mBm) using
%   Cholesky/Levinson factorization
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x,y,r] = mbmlevinson(N,H,[seed])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   N  : Positive integer
%      Sample size of the fBm
%
%   o   H  : Real vector [1,N] of character string
%      H real vector: contains the Holder exponents at each time. Each
%      element in [0,1].
%      H character string: analytic expression of the Holder function
%      (e.g. 'abs(0.5 * ( 1 + sin(16 t) ) )')
%
%   o   seed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   x  : real vector  [1,N]
%      Time samples of the mBm
%
%   o   y  : real vector [1,N]
%      Vector of N i.i.d. white standard Gaussian r.v.'s (input process of
%      the generator)
%
%   o   r  : real matrix [N,N]
%      Matrix containing columnwise each first row of the var/cov Toeplitz
%      matrices R(n) of the non-stationary increment process w[n] = x[n+1]
%      - x[n].
%
%   2.  See also:
%
%   fbmlevinson
%
%   3.  Examples
%
%   % Synthesis of the Holder function H(t): 0 < t < 1
%   % Linear variation between H(0) = 0 and H(1) = 1
%   N = 256 ; H0 = 0 ; H1 = 1 ; SmoothParam = 1 ;
%   t = linspace(0,1,N) ;
%   H = AtanH(N,H0,H1,SmoothParam) ;
%   clf ; subplot(211) ;
%   plot(t,H) ;
%   title ('Holder trajectory') ; xlabel ('time') ;
%   % Synthesis of the corresponding multifractional Brownian Motion
%   [x,y,r] = mbmlevinson(N,H) ;
%   subplot(212) ;
%   plot(t,x) ;
%   title ('Multifractional Brownian Motion') ;
%   xlabel ('time') ;
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

 
switch nargin
  case 2
    tmax = N-1 ; 
    sigma = 1 ;
    seed = rand(1) * 1e6 ;
    shift = 1 ;
  case 3
    sigma = 1 ;
    seed = rand(1) * 1e6 ;
    shift = tmax/N ;
  case 4
    seed = rand(1) * 1e6 ;
    shift = tmax/N ;
  case 5
    shift = tmax/N ;
end


if length(H) ~= N
  t = linspace(0,tmax,N) ;
  H =  eval(ht) ;
end

H = min(0.9999,H) ;
H = max(eps,H) ;

t = linspace(0,tmax,N) ;
s = eps ;
alpha = 2*H(:) ; 
r = (sigma^2*(exp(alpha(:)*log(abs(t+shift-s))) + ...
exp(alpha(:)*log(abs(t-s-shift))) - ...
2*exp(alpha(:)*log(abs(t-s))))/2)' ;

randn('seed',seed) ;
y = randn(N,1) ;

x = zeros(N,N) ;

inter1 = r ;
inter2 = [zeros(1,N) ; r(2:N,:) ; zeros(1,N)] ; 
Y = y(1)*r ;

k = -inter2(2,:) ;
aa = sqrt(r(1,:)) ;

for j = 2:N , 

  aa = aa.*sqrt(1-k.^2) ;
  inter = k(ones(N-j+1,1),:).*inter2(j:N,:) + inter1(j-1:N-1,:) ;
  inter2(j:N,:) = inter2(j:N,:) + k(ones(N-j+1,1),:).*inter1(j-1:N-1,:) ;	
  inter1(j:N,:) = inter ; clear inter ;					
  bb = y(j)*aa.^(-1) ;
  x(j:N,:) = x(j:N,:) + bb(ones(N-j+1,1),:).*inter1(j:N,:) ;
  k = -inter2(j+1,:)./(aa.^2) ;

end

% coef = sigma.*((N.^H).^(-1)) ; coef = coef(:) ;
x = diag(cumsum(x)) ;


