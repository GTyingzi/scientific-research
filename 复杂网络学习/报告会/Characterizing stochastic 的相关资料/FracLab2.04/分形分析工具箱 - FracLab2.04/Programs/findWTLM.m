function [maxmap] = findWTLM(wt,scale,depth)
%   findWTLM
%   Finds local maxima lines of a CWT
%   Paulo Goncalves
%   June 6th 1997
%
%   Finds the local maxima of a continuous wavelet transform
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [maxmap] = findWTLM(wt,scale[,depth])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  wt : Complex matrix  [N_scale,N]
%      Wavelet coefficients of a continuous wavelet transform (output of
%      FWT or contwt)
%
%   o  scale : real vector  [1,N_scale]
%      Analyzed scale vector
%
%   o  depth : real in [0,1]
%      maximum relative depth for the peaks search.  Default value is 1
%      (all peaks found)
%
%   1.2.  Output parameters
%
%   o  maxmap : 0/1 matrix  [N_scale,N]
%      If maxmap(m,n) = 0 : the coefficient wt(m,n) is not a local maximum
%      If maxmap(m,n) = 1 : the coefficient wt(m,n) is a local maximum
%
%   2.  See also:
%
%   contwt, cwt1D
%
%   3.  Examples
%
%   % signal synthesis
%   N = 256 ; H = 0.7 ;
%   [x] = fbmlevinson(N,H) ;
%   % Continuous Wavelet transform (L2 normalization)
%   [wt,scale] = contwtmir(x,2^(-6),2^(-1),64,12*i) ;
%   % Finding the local maxima lines of the wavelet transform
%   [maxmap] = findWTLM(wt,scale) ;
%   % Vizualisation
%   viewWTLM(maxmap,scale,wt)
%   title('Wavelet coefficients and maxima lines')
%   xlabel('time') , ylablel('scale')
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

if nargin == 2
  depth = 1 ;
elseif nargin == 3
  depth = min(1,depth) ;
end

n = size(wt,2) ;
s = size(wt,1) ;

maxmap = zeros(s,n) ;

x = 1:n ;
xplus = [x(2:n) x(1)] ; 
xminus = [x(n) x(1:n-1)] ;

wt = abs(wt) ;
% wt = real(wt) ;

for k = 1:s
  maxdepth = (1-depth) * max(wt(k,:)) ;
  maxmap(k,x) = wt(k,x) > wt(k,xminus) & wt(k,x) > wt(k,xplus) & wt(k,x) >= maxdepth ;
end






