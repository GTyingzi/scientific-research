function  [h,alpha] = mexhat(nu) ;
%   mexhat
%   Mexican hat wavelet
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes a Mexican Hat wavelet (seconde derivative of the gaussian).
%
%   1.  Usage
%
%   [wavelet,alpha] = mexhat(nu)
%
%   1.1.  Input parameters
%
%   o  nu :  real scalar between 0 and 1/2
%      Central (reduced) frequency of the wavelet.
%
%   1.2.  Output parameters
%
%   o  wavelet : real vector [1,2*N+1]
%      Mexican Hat wavelet in time.
%
%   o  alpha : real scalar
%      Attenuation exponent of the Gaussian enveloppe of the Mexican Hat
%      wavelet.
%
%   2.  See also:
%
%   Frac_morlet, contwt
%
%   3.  Examples
%
%   % wavelet synthesis
%   wavelet = mexhat(0.1) ;
%   N = length(wavelet) ;
%   clf
%   plot(-(N-1)/2:(N-1)/2,wavelet) ;
%   title('a Mexican hat Wavelet')
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

N = 1.5 ;
alpha = pi^2*nu^2 ;
n = ceil(N/nu) ; 
t = -n:n ;
h = sqrt(sqrt(32*alpha/pi)/3)*exp(-alpha*t.^2);%.*(1-2*alpha*t.^2) ;
h=h.*(1-2*alpha*t.^2) ; 










