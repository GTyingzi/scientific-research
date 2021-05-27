%   wave2gifs
%   Computation of IFS coef. with Discrete Wavelet coefficients
%   Khalid Daoudi
%   June 6th 1997
%
%   Computes the GIFS cefficients of a 1-D real signal as the ratio
%   between (synchrounous) wavelets coefficients at successive scales. You
%   have to compute the wavelet coefficients of the given signal (using
%   FWT) before using wave2gifs.
%
%   1.  Usage
%
%   [Ci, Ci_idx, Ci_lg, pc0, pc_ab]=wave2gifs(wt, wt_idx, wt_lg, [M0, a,
%   b])
%
%   1.1.  Input parameters
%
%   o  wt : Real matrix [1,n]
%      Contains the wavelet coefficients (obtained using FWT).
%
%   o  wt_idx : Real matrix [1,n]
%      Contains the indexes (in wt) of the projection of the signal on the
%      multiresolution subspaces (obtained also using FWT).
%
%   o  wt_lg : Real matrix [1,n]
%      Contains the dimension of each projection (obtained also using
%      FWT).
%
%   o  M0 :  Real positive scalar
%      If specified, each GIFS coefficient whose absolute value belong to
%      ]1,M0[ will be replaced by 0.99 (keeping its signe).
%
%   o  a,b : Real positive scalars
%      The routine gives the percentage of the Ci's whose absolute value
%      belong to ]a,b[ (if not specified, ]a,b[=]0,2[).
%
%   1.2.  Output parameters
%
%   o  Ci : Real matrix
%      Contains the GIFS coefficients plus other informations.
%
%   o  Ci_idx : Real matrix
%      Contains the the indexes of the first Ci at each scale (the finest
%      scale is 1).
%
%   o  Ci_lg : Real matrix
%      Contains the length of Ci's at each scale.
%
%   o  pc0 : Real scalar
%      Gives the percentage of vanishing Ci's
%
%   o  pc_ab : Real scalar
%      Gives the percentage of Ci's which belong to ]a,b[
%
%   2.  See also:
%
%   FWT and MakeQMF.
%
%   3.  Example:
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

