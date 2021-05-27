%   mdfl2d
%   Discrete Legendre spectrum estimation on 2d measure
%   Christophe Canus
%   March 12, 1998
%
%   This routine estimates the discrete Legendre spectrum on a pre-multi-
%   fractal 2d measure.
%
%   1.  Usage
%
%   [alpha,fl_alpha]=mdfl2d(mu_n,N,n)
%
%   1.1.  Input parameters
%
%   o  mu_n : strictly positive real matrix [nux_n,nuy_n]
%      Contains the pre-multifractal measure.
%
%   o  N : strictly positive real (integer) scalar
%      Contains the number of Hoelder exponents.
%
%   o  n : strictly positive real (integer) scalar
%      Contains the final resolution.
%
%   1.2.  Output parameters
%
%   o  alpha : real vector [1,N]
%      Contains the Hoelder exponents.
%
%   o  fl_alpha : real vector [1,N]
%      Contains the dimensions.
%
%   2.  See also
%
%   mdznq1d,mdznq2d,reynitq,linearlt,mdfl1d.
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

