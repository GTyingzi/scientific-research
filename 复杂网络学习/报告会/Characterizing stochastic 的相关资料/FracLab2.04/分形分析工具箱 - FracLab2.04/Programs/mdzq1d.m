%   mdzq1d
%   Discrete partition function estimation on 1d measure
%   Christophe Canus
%   February 9, 1999
%
%   This routine computes the discrete partition function on a pre-multi-
%   fractal 1d measure.
%
%   1.  Usage
%
%   [zaq,[a,q]]=mdzq1d(mu_n,[q,[J min max],partstr])
%
%   1.1.  Input parameters
%
%   o  mu_n : strictly positive real vector
%      Contains the pre-multifractal 1d measure.
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
%   1.2.  Output parameters
%
%   o  zaq : real matrix [size(q),size(a)]
%      Contains the partition function.
%
%   o  a : real vector [1,J]
%      Contains the scales.
%
%   o  q : strictly positive real vector
%      Contains the exponents.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   The  discrete  partition    function zaq  is    computed  on  the pre-
%   multifractal 1d measure mu_n.
%
%   The vector of exponents q  and the number of intervals, resp.  of
%   partitions J set  the size of the output  real matrix zaq to
%   size(q)*J.  The  default value for  length(q) is 21  and the default
%   value for J is -log(N_n)/log(2.) where N_n is length(mu_n).
%
%   The partition string progstr specifies the type of partition.  It can
%   be  'linpart' for  linear,  'logpart' for  logarithmic,
%
%   2.2.  Algorithm details
%
%   The discrete partition   function zaq   is computed by    summing mu_n
%   on intervals, resp.  on  partitions, of increasing  diameter (fix-mass
%   box couting method).
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
%   mdzq2d,fczq1d,reynitq,linearlt,mdfl1d,mdfl2d,fcfl1d.
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

