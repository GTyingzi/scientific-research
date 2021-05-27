%   bbch
%   beneath-beyond concave hull
%   Christophe Canus
%   March 10, 1998
%
%   This C_LAB routine determines the concave hull of a function graph
%   using the beneath-beyond algorithm.
%
%   1.  Usage
%
%   [rx,ru_x]=bbch(x,u_x)
%
%   1.1.  Input parameters
%
%   o  x : real vector [1,N] or [N,1]
%      Contains the abscissa.
%
%   o  u_x : real vector [1,N] or [N,1]
%      Contains the function to be regularized.
%
%   1.2.  Output parameters
%
%   o  rx : real vector [1,M]
%      Contains the abscissa of the regularized function.
%
%   o  ru_x : real vector [1,M]
%      Contains the regularized function.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   The abscissa x and the function u_x  to be regularized must be of the
%   same size [1,N] or [N,1].
%
%   The abscissa rx and the concave regularized function ru_x are of the
%   same size [1,M] with M<=N.
%
%   2.2.  Algorithm details
%
%   Standard beneath-beyond algorithm.
%
%   3.  Examples
%
%   3.1.  Matlab
%
%   ______________________________________________________________________
%   h=.3;beta=3;
%   N=1000;
%   % chirp singularity (h,beta)
%   x=linspace(0.,1.,N);
%   u_x=abs(x).^h.*sin(abs(x).^(-beta));
%   plot(x,u_x);
%   hold on;
%   [rx,ru_x]=bbch(x,u_x);
%   plot(rx,ru_x,'rd');
%   plot(x,abs(x).^h,'k');
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
%   None
%
%   5.  See Also
%
%   linearlt (C_LAB routine).
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

