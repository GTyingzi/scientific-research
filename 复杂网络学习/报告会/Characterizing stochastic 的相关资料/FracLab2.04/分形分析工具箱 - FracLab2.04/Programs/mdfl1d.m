%   mdfl1d
%   Discrete Legendre spectrum estimation on 1d measure
%   Christophe Canus
%   March 12, 1998
%
%   This routine estimates the discrete Legendre Spectrum on 1d measure.
%
%   1.  Usage
%
%   [alpha,f_alpha]=mdfl1d(mu_n,)
%
%   1.1.  Input parameters
%
%   o  mu_n : strictly positive real vector [1,nu_n]
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
%   o  f_alpha : real vector [1,N]
%      Contains the dimensions.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   The discrete Legendre spectrum f_alpha is estimated on the finite
%   finer resolution of the pre-multifractal 1d measure mu_n. The three
%   steps of the estimatation are:
%
%   o  estimation of the partition function;
%
%   o  estimation of the Reyni exponents;
%
%   o  estimation of the Legendre transform.
%
%   2.2.  Algorithm details
%
%   The discrete partition function is estimated by coarse-graining masses
%   mu_n into non-overlapping boxes of increasing diameter (box method).
%   If nu_n is a power of 2, 2^n corresponds to the coarser scale.
%
%   The reyni exponents are estimated by least square linear regression.
%
%   The Legendre transform of the mass exponent function is estimated with
%   the linear-time Legendre transform.
%
%   3.  See also
%
%   mdzq1d,mdzq2d,reynitq,linearlt,mdfl2d.
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

