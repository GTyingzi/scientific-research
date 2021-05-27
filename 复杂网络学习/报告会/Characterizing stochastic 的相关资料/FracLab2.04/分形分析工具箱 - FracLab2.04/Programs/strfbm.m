function Y = strfbm(x,y,H)
%   strfbm
%   Structure Function of a Brownian Field
%   B. Pesquet-Popescu (ENS-Cachan)
%   February 20th 1998
%
%   Creates the structure function of an isotropic fBm
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [Y] = strfbm(x,y,H)
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   x  : Real vector [1,N]
%      vertical coordinate
%
%   o   y  : Real scalar [1,M]
%      horizontal coordinate
%
%   o   H  : Real in [0,1]
%      Hurst parameter
%
%   1.2.  Output parameters
%
%   o   Y  : Matrix  [N,M]
%      Matrix containing the values of the structure function
%
%   2.  See also:
%
%   synth2
%
%   3.  Example:
%
%   4.  Examples
%
%   % creation of the coordinates system : 128 x 128
%   x = 1:128 ;
%   y = 1:128 ;
%   % Computation of the structure functions of an isotropic fBm field
%   [Y] = strfbm(x,y,0.8) ;
%   % Visualization of the structure functions (logarithmic dynamic - pseudo color)
%   clf ;
%   viewmat(abs(Y),x,y,[1 1 12 0]) ;
%
%   ______________________________________________________________________
%   ______________________________________________________________________
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

Y = (x.^2 + y.^2).^H;
