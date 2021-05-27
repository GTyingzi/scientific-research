%   sim_stable
%   Generation of stable random processes
%   Lotfi Belkacem
%   1 April 1997
%
%   This routine generates a stable random process and its increments
%   using the Chambers, Mallows and Stuck (1976) algorithm.
%
%   1.  Usage
%
%   [proc,inc]=sim_stable(alpha,beta,mu,gamma,size)
%
%   1.1.  Input parameters
%
%   o  alpha : real positive scalar between 0 and 2.
%      This parameter is often referred to as the characteristic exponent.
%
%   o  beta : real scalar between -1 and +1.
%      This parameter is often referred to as the skewness parameter.
%
%   o  mu : real scalar
%      This parameter is often referred to as the location parameter.
%      It is equal to the expectation when alpha is greater than 1.
%
%   o  gamma : real positive scalar.
%      This parameter is often referred to as the scale parameter.
%      It is equal to the standard deviation over two squared when alpha
%      equal 2.
%
%   o  size : integer positive scalar.
%      size of the simulated sample.
%
%   1.2.  Output parameters
%
%   o  proc : real vector [size,1]
%      corresponding to the stable random process.
%
%   o  inc : real vector [size,1]
%      corresponding to the increments of the simulated process.
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

