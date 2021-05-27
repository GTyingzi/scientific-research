function viewWTLM(maxmap,scale,wt) ;
%   viewWTLM
%   Vizualises the local maxima lines of a CWT
%   Paulo Goncalves
%   June 6th 1997
%
%   Displays the local maxima of a continuous wavelet transform
%
%   1.  Usage
%
%   ______________________________________________________________________
%   viewWTLM(maxmap[,scale,wt])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  maxmap : 0/1 matrix  [N_scale,N]
%      Indicator matrix of the local wavelet coefficients maxima
%
%   o  scale : real vector  [1,N_scale]
%      Analyzed scale vector
%
%   o  wt : Complex matrix  [N_scale,N]
%      Wavelet coefficients of a continuous wavelet transform (output of
%      FWT or contwt)
%
%   2.  See also:
%
%   findWTLM, viewmat, contwt, cwt1D
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

[y,x] = find(maxmap) ;

if exist('scale') == 1
  logscale = log2(scale(y)) ;
else
  logscale = 1:size(maxmap,1) ;
end
if exist('wt') == 1
  viewmat(abs(wt),1:size(wt,2),log2(scale),[1 1 24]) ; hold on ;
end

plot(x,logscale,'.k','MarkerSize',8) ; hold off ;
