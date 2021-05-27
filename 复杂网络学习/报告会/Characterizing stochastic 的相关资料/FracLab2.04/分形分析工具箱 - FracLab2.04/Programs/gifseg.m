%   gifseg
%   Khalid Daoudi
%   June 6th 1997
%
%   Replaces at each scale the left (resp. right) nodes of the diadic
%   tree, associated to the GIFS coefficients, that belong to [cmin,cmax]
%   by a ceratin unique value.
%
%   1.  Usage
%
%   [Ci_new, marks, L]=gifseg(Ci,[cmin,cmax,epsilon])
%
%   1.1.  Input parameters
%
%   o  Ci : Real matrix
%      Contains the GIFS coefficients (obtained using FWT)
%
%   o  cmin : Real scalar [1,n]
%      Specifies the minimal value of the Ci's to be considered (cmin=0 by
%      default)
%
%   o  cmax : Real scalar [1,n]
%      Specifies the maximal value of the Ci's to be considered (cmin=0 by
%      default)
%
%   o  epsilon :  real scalar
%      Specifies the maximal error desied on the Ci's approximation.
%
%   1.2.  Output parameters
%
%   o  Ci_new : Real matrix
%      Contains the the new GIFS coefficients.
%
%   o  marks : Real vector
%      Contains the segmentation marques. length(marks)-1 is the number of
%      segmented parts.
%
%   o  L : Real matrix
%      A structure containing the left and right lambda_i's corresponding
%      to each segmented part.
%
%   2.  See also:
%
%   hist, wave2gifs.
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

