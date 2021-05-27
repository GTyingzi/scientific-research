%   fcfl1d
%   Continuous Legendre spectrum estimation on 1d function
%   Christophe Canus
%   January 15, 1999
%
%   This routine estimates the continuous Legendre Spectrum on 1d func-
%   tion.
%
%   1.  Usage
%
%   [alpha,f_alpha,[zaq,a,tq,q]]=fcfl1d(f_x,[q,[J min
%   max],partstr,oscstr,lrstr])
%
%   1.1.  Input parameters
%
%   o  f_x : real vector
%      Contains the 1d function.
%
%   o  q : strictly positive real vector
%      Contains the exponents.
%
%   o  [J min max] : strictly positive real (integer) vector
%      Contains the number of intervals, resp. of partitions, and the
%      minimum and maximum interval sizes, resp. partition numbers.
%
%   o  partstr : string
%      Contains the string which specifies the intervals, resp. the
%      partitions progression.
%
%   o  oscstr : string
%      Contains the string which specifies the oscillation to be used.
%
%   o  lrstr : string
%      Contains the  string which specifies  the type of linear regression
%      to be used.
%
%   1.2.  Output parameters
%
%   o  alpha : real vector [1,N]
%      Contains the Hoelder exponents.
%
%   o  f_alpha : real vector [1,N]
%      Contains the dimensions.
%
%   o  zaq : real matrix [size(q),size(a)]
%      Contains the partition function.
%
%   o  a : real vector [1,J]
%      Contains the scales.
%
%   o  tq : real vector [1,size(q)]
%      Contains the Reyni exponents.
%
%   o  q : strictly positive real vector
%      Contains the exponents.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   The continuous Legendre spectrum f_alpha is estimated on the 1d
%   function f_x. The three steps of the estimation are:
%
%   o  partition function estimation;
%
%   o  Reyni exponents estimation;
%
%   o  Legendre transform estimation.
%
%   2.2.  Algorithm details
%
%   The reyni exponents are estimated by least square linear regression.
%
%   The Legendre transform of the mass exponent function is estimated with
%   the linear-time Legendre transform.
%
%   3.  Examples
%
%   3.1.  Matlab
%
%   ______________________________________________________________________
%   % Fractional Brownian motion synthesis
%   fbm=fbmlevinson(256,.6);
%
%   % Continuous legendre spectrum: f(alpha) on 1d function with default input arguments and
%   % all output arguments
%   [alpha,f_alpha,zaq,a,tq,q]=fcfl1d(fbm);
%   % plot outputs
%   plot(log(a),log(zaq));
%   plot(q,tq);
%   plot(alpha,f_alpha);
%
%   % Continuous legendre spectrum: f(alpha) on 1d function with custom input arguments and
%   % two output arguments
%   [alpha,f_alpha]=fcfl1d(fbm,[-5:.1:+5],[10 1 128],'lin','l2','lapls');
%   % plot outputs
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
%   fczq1d,mdzq1d,mdzq2d,reynitq,linearlt,mdfl2d.
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

