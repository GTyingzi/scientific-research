
%   idmt
%   Inverse Discrete Mellin transform
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes the Inverse Fast Fourier-Mellin transform of a signal.
%
%   1.  Usage
%
%   [x,t] = idmt(mellin,beta,[M])
%
%   1.1.  Input parameters
%
%   o  mellin :  complex vector [1,N]
%      Fourier-Mellin transform to be inverted. For a correct inversion of
%      the Fourier-Mellin transform, the direct Fourier-Mellin transform
%      mellin must have been computed from fmin to 0.5 cycles per sec.
%
%   o  beta : real vector [1,N]
%      Variable of the Mellin transform mellin.
%
%   o  M : positive integer.
%      Number of time samples to be recovered from mellin.
%
%   1.2.  Output parameters
%
%   o  x : complex vector [1,M]
%      Inverse Fourier-Mellin transform of mellin.
%
%   o  t : time variable of the Inverse Fourier-Mellin transform x.
%
%   2.  See also:
%
%   dmt, Frac_dilate
%
%   3.  Examples
%
%   % Signal synthesis
%   x = Frac_morlet(0.1,32) ;
%   % Computation of the Mellin transform
%   [mellin,beta] = dmt(x,0.01,0.5,128) ;
%   [y,t] = idmt(mellin,beta,65) ;
%   subplot(211) ;
%   plot(t,x,t,y) ; title('Signals in time') ; xlabel('time')
%   legend('Original','Inverse Mellin transformed') ;
%   subplot(212)
%   plot(beta,abs(mellin))
%   title('Mellin Spectrum'), xlabel('\beta') ;
%
function [x,t] = idmt(y,beta,M);

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


% IDMT       [x,t] = idmt(y,beta,M) computes the inverse fast 
%		Fourier-Mellin transform of signal y.
%            !!! WARNING : the inverse F-Mellin of the F-Mellin transform y 
%			   is correct only if the direct F-Mellin transform 
%                          has been computed from FMIN to 0.5 cycles/sec.
%
% Input:     -y  F-Mellin transform to be inverted. Mellin must have
%             been obtained from DMT with frequency running from FMIN
%             to 0.5
%            -beta  Mellin variable issued from DMT
%            -[M] number of point of the inverse Mellin transform. Its
%             default value is the length of Mellin
%
% Output:    -x inverse Mellin transform with M points in time
%            -[t] time vector with M points.
%
% Example:   S = amaltes(128,0.1,0.4) ; 
%            [MELLIN,BETA] = dmt(S,0.05,0.5,256) ;
%            [X,T] = idmt(MELLIN,BETA,128) ; plot(T,X) ;
%
% See also:
%

%File Name: idmt.m
%Last Modification Date: %G%	%U%
%Current Version: %M%	%I%
%File Creation Date: Thu Oct 26 14:40:01 1995
%Author: Paulo Goncalves  <gpaulo@ece.rice.edu>
%
%Permission is granted for use and non-profit distribution providing that this
%notice be clearly maintained. The right to distribute any portion for profit
%or as part of any commercial product is specifically reserved for the author.
%
%Change History:
%

[yy,xy]=size(y) ; 
if yy>xy , y = y.' ; else, end;
N = length(y) ;
if nargin==2
  M = N ;
end
q = exp(1/(N*(beta(2)-beta(1)))) ;
fmin = 0.5/(q^(N/2-1)) ;

k = 1:N/2 ;
geo_f(k) = fmin*(exp((k-1).*log(q))) ;
itfmatx=[];

itfmatx = exp(2*i*(0:M-1)'*geo_f(1:N/2)*pi);

t = [0:M-1] ;   	

% Inverse Mellin transform computation 

S = fft(fftshift(y)) ;  S=S(1:N/2) ;  
for kk=1:M
   x(kk)=real(2*integ(itfmatx(kk,:).*S,geo_f)) ;
end;

x = x(:) ;






