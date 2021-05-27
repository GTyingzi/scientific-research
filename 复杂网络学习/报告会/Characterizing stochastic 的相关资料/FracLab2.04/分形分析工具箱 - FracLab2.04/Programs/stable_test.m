%   stable_test
%   stable law conformicy test
%   Lotfi Belkacem
%   1 April 1997
%
%   This routine tests the stability property of a signal.
%
%   1.  Usage
%
%   [param,sd_param]=stable_test(maxr,data)
%
%   1.1.  Input parameters
%
%   o  maxr : integer positive scalar.
%      maximum resolution witch depend on the size of the sample.
%
%   o  data : real vector [size,1]
%      corresponding to the data sample (increments of the signal).
%
%   1.2.  Output parameters
%
%   o  param : real matrix [maxr,4]
%      corresponding to the four estimated parameters  of the fited stable
%      law at each level of resolution.
%      param(i,:), for i=1, ...maxr, gives respectively
%      alpha(characteristic exponent), beta (skewness parameter), mu
%      (location parameter), gamma (scale parameter) estimated at the
%      resolution i.
%
%   o  sd_param : real matrix [maxr,4]
%      corresponding to the estimated standard deviations of the four
%      previous parameters at each level of resolution.
%      sd_param(i,:), for i=1, ...maxr, gives respectively standard
%      deviation of alpha, beta, mu and gamma estimated at the resolution
%      i.
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

