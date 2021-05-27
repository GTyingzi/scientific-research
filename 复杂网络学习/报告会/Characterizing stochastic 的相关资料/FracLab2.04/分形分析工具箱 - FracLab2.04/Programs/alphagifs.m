%   alphagifs
%   Holder function estimation using IFS
%   Khalid Daoudi
%   June 6th 1997
%
%   Estimates the pointwise Holder exponents of a 1-D real signal using
%   the GIFS method.
%
%   1.  Usage
%
%   [Alpha, Ci]=alphagifs(sig, limtype)
%
%   1.1.  Input parameters
%
%   o  sig : Real vector [1,n] or [n,1]
%      Contains the signal to be analysed.
%
%   o  limtype : Character string
%      Specifies the type of limit you want to use. You have the choice
%      between "slope" and "cesaro".
%
%   1.2.  Output parameters
%
%   o  Alpha : Real vector
%      Contains the estimated Holder function of the signal.
%
%   o  Ci : Real matrix
%      Contains the GIFS coefficients obtained using the Schauder basis.
%
%   2.  See also:
%
%   gifs and prescalpha
%
%   3.  Example:
%
%    Synthesis of an fbm with exponent H=0.7 (of size 1024 samples) :
%
%   x = fmblevinson(1024,0.7) ;
%
%    Estimation of The Holder function :
%
%   Alpha = alphagifs(x,'slope');
%   plot(Alpha)
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

