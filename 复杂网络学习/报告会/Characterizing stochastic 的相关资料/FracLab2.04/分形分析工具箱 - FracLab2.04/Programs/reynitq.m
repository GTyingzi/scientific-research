%   reynitq
%   Reyni exponents estimation on a partition function
%   Christophe Canus
%   February 9, 1999
%
%   This routine estimates the Reyni exponents on a partition function.
%
%   1.  Usage
%
%   [tq,[Dq]]=reynitq(zaq,q,a)
%
%   1.1.  Input parameters
%
%   o  zaq : strictly positive real matrix
%      Contains the partition function.
%
%   o  q : strictly positive real vector
%      Contains the exponents.
%
%   o  a : strictly positive real (integer) vector
%      Contains the resolutions.
%
%   o  lrstr : string
%      Contains the  string which specifies  the type of linear regression
%      to be used.
%
%   1.2.  Output parameters
%
%   o  tq : real vector [1,size(q)]
%      Contains the Reyni exponents.
%
%   o  Dq : real vector [1,size(q)]
%      Contains the generalized dimensions.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   The Reyni exponents tq and the generalized dimensions Dq (if used) are
%   computed on the partition function zaq.
%
%   The input real matrix zaq must be of height size(q) and of width
%   size(a).
%
%   The output real vectors tq and Dq (if used) are of size size(q).
%
%   The linear  regression string lrstr specifies the  type of linear
%   regression used.  It can be 'ls' for least square, 'wls' for weighted
%   least   square,  'pls'  for   penalized  least  square, procedure
%   least   square.   The  default  value   for  lrstr  is
%
%   2.2.  Algorithm details
%
%   The  mass  exponent function  tq  is  estimated using  differents
%   linear  regression methods.  For  the details  of  these methods,  see
%   monolr   (monovariate    linear   regression)   C_LAB   routine's
%   help.
%
%   3.  Examples
%
%   3.1.  Matlab
%
%   ______________________________________________________________________
%   % Pre-multifractal binomial 1d measure synthesis
%   mu_n=binom(.1,'meas',10);
%
%   % Partition function: z(a,q) on 1d measure with default input arguments and
%   % all output arguments
%   [zaq,a,q]=mdzq1d(mu_n);
%   plot(log(a),log(zaq));
%
%   % Reyni mass exponents: t(q) with custom input arguments and
%   % all ouput arguments
%   [tq,Dq]=reynitq(zaq,q,a,'wls');
%   plot(q,tq);
%
%   % Just to see that it doesn't look very good
%   [alpha,f_alpha]=linearlt(q,tq);
%   plot(alpha,f_alpha);
%   ______________________________________________________________________
%
%   3.2.  Scilab
%
%   ______________________________________________________________________
%   //
%   ______________________________________________________________________
%
%   4.  References
%
%   To be published.
%
%   5.  See also
%
%   mdzq1d,mdzq2d,fczq1d,monolr,linearlt,mdfl1d,mdfl2d,fcfl1d.
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

