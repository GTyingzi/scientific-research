%   linearlt
%   linear time legendre transform
%   Christophe Canus
%   March 10, 1998
%
%   This C_LAB routine the Legendre transform of a function using the lin-
%   ear time Legendre transform algorithm.
%
%   1.  Usage
%
%   [s,u_star_s]=linearlt(x,u_x)
%
%   1.1.  Input parameters
%
%   o  x : real vector [1,N] or [N,1]
%      Contains the abscissa.
%
%   o  y : real vector [1,N] or [N,1]
%      Contains the function to be transformed.
%
%   1.2.  Output parameters
%
%   o  s : real vector [1,M]
%      Contains the abscissa of the regularized function.
%
%   o  u_star_s : real vector [1,M]
%      Contains the Legendre conjugate function.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   The abscissa x and the function u_x  to be transformed must be of the
%   same size [1,N] or [N,1].
%
%   The abscissa s and the Legendre conjugate function u_star_s are of the
%   same size [1,M] with M<=N.
%
%   2.2.  Algorithm details
%
%   The linear time Legendre transform algorithm is based on  the use of a
%   concave regularization before slopes' computation.
%
%   3.  Examples
%
%   3.1.  Matlab
%
%   ______________________________________________________________________
%   x=linspace(-5.,5.,1024);
%   u_x=-1+log(6+x);
%   plot(x,u_x);
%   % looks like a Reyni exponents function, isn't it ?
%   [s,u_star_s]=linearlt(x,u_x);
%   plot(s,u_star_s);
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
%   None.
%
%   5.  See Also
%
%   bbch (C_LAB routine).
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

