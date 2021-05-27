function  [h,alpha] = Frac_morlet(nu,N,analytic) ;
%   Frac_morlet
%   Morlet wavelet
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes a Morlet wavelet.
%
%   1.  Usage
%
%   [wavelet,alpha] = Frac_morlet(nu,[N,analytic])
%
%   1.1.  Input parameters
%
%   o  nu :  real scalar between 0 and 1/2
%      Central (reduced) frequency of the wavelet
%
%   o  N : Positive integer
%      Half length of the wavelet transform. Default value corresponds to
%      a total length of 4.5 periods.
%
%   o  analytic : boolean (0/1) under Matalb or (%F/%T) under Scilab.
%      0 or %F : real Morlet wavelet
%      1 or %T : analytic Morlet wavelet
%
%   1.2.  Output parameters
%
%   o  wavelet : real or complex vector [1,2*N+1]
%      Morlet wavelet in time.
%
%   o  alpha : real scalar
%      Attenuation exponent of the Gaussian enveloppe of the Morlet
%      wavelet.
%
%   2.  See also:
%
%   mexhat, contwt
%
%   3.  Examples
%
%   % wavelet synthesis
%   x1 = Frac_morlet(0.1,128) ;
%   clf
%   plot(-128:128,x1) ;
%   title('a Morlet Wavelet')
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

narg = nargin ;
if narg ==1 
  n_periods = 2.25 ;
  N = ceil(n_periods * nu.^(-1)) ;
  narg = 2 ;
end
if narg == 2
  analytic = 0;
end

tol = 1e-3 ;
alpha = -log(tol)/N^2 ;

t = -N:N ;
h = sqrt(sqrt(2*alpha/pi))*exp(-alpha*t.^2).*exp(-i*2*pi*t*nu) ;
if ~analytic
  h = sqrt(2).*real(h) ;
end





