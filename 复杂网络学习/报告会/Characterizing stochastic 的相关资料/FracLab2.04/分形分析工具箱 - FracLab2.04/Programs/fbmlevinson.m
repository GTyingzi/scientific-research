function [x,y,r] = fbmlevinson2(N,H,tmax,sigma,seed) 
%   fbmlevinson
%   Levinson synthesis of a fractional Brownian motion
%   Paulo Goncalves
%   June 6th 1997
%
%   Generates a Fractional Brownian Motion (fBm) using Cholesky/Levinson
%   factorization
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x,y,r] = fbmlevinson(N,H,[seed])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   N  : Positive integer
%      Sample size of the fBm
%
%   o   H  : Real in [0,1]
%      Holder exponent
%
%   o   seed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   x  : real vector  [1,N]
%      Time samples of the fBm
%
%   o   y  : real vector [1,N]
%      Vector of N i.i.d. white standard Gaussian r.v.'s (input process of
%      the generator)
%
%   o   r  : real vector [1,N]
%      First  row of the var/cov Toeplitz matrix R of the increment
%      process w[k] = x[k+1] - x[k].
%
%   2.  See also:
%
%   mbmlevinson
%
%   3.  Examples
%
%   % Synthesis of a fractional Brownian Motion with Holder exponent H
%   N = 1024 ; H = 0.8 ;
%   t = linspace(0,1,N) ;
%   clf ;
%   [x] = fbmlevinson(N,H) ;
%   plot(t,x) ;
%   title ('Fractional Brownian Motion - H = 0.8') ;
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

if all(H-H(1))
  error('Time-dependant regularity not allowed yet.')
end

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
      
t = linspace(0,tmax,N) ;
s = 0 ;
alpha = 2*H ; 
r = sigma^2*(abs(t+shift-s).^alpha + abs(t-s-shift).^alpha - ...
2*abs(t-s).^alpha)/2 ;

randn('seed',seed) ;
y = randn(N,1) ;

x = zeros(1,N) ;

inter1 = r ;
inter2 = [0 r(2:N) 0] ;
Y = y(1)*r ;

k = -inter2(2) ;
aa = sqrt(r(1)) ;

for j = 2:N

  aa = aa*sqrt(1-k^2) ;
  inter = k*inter2(j:N) + inter1(j-1:N-1) ;
  inter2(j:N) = inter2(j:N) + k*inter1(j-1:N-1) ;	
  inter1(j:N) = inter ;					
  bb = y(j)/aa ; ;
  x(j:N) = x(j:N) + bb*inter1(j:N) ;
  k = -inter2(j+1)/(aa^2) ;

end

x = cumsum(x(:)) ;
