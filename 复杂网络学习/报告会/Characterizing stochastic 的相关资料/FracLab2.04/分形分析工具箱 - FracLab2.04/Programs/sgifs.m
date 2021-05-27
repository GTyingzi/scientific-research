%   sgifs
%   Semi Generalized IFS generation
%   Khalid Daoudi
%   June 6th 1997
%
%   This routine generates stochastical Semi-Generalized Iterated Func-
%   tions Systems (SGIFS) attractors.
%
%   1.  Usage
%
%   [x, y, Ci]=sgifs(Interp_pts, coefs, nbr_iter,law_type,var)
%
%   1.1.  Input parameters
%
%   o  Interp_pts : Real matrix [n,2]
%      Contains the interpolation points in the format : abscissa-
%      ordinate.
%
%   o  coefs : Real vector
%      Contains the fundamental contractions ratios.
%
%   o  nbr_iter : Integer
%      Number of iterations wanted in the generation process of the SGIFS
%      attractor.
%
%   o  law_type : Character string
%      Specifies the type of law desired. You have the choice between
%      'uniform' and
%
%   o  var : Real scalar
%      Rules the variance decrease across scales. At each scale j, the
%      variance would be 1/pow(j,var).
%
%   1.2.  Output parameters
%
%   o  x : Real vector
%      Contains the abscissa of the attractor graph.
%
%   o  y : Real vector
%      Contains the ordinates of the attractor graph.
%
%   o  Ci : Real vector
%      Contains all the coefficients of the so generated GIFS.
%
%   2.  See also:
%
%   fif, alphagifs and prescrib
%
%   3.  Example:
%
%   I = [0 0
%   1 0];
%   coefs = [.3 -.9];
%
%   [x,y,Ci] = sgifs(I,coefs,10,'uniform',1);
%   plot(x,y)
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

