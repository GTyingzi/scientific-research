function [x,y] =  prescrib(Int,function1,Iter)
%   prescrib
%   Generation of signals with prescribed Holder function
%   Khalid Daoudi
%   June 6th 1997
%
%   Using the GIFS method, this routine generates a continous function
%   with prescribed Holder function, while interpolating a set of point.
%
%   1.  Usage
%
%   [x,y]=prescrib(Interp_pts, Holder_funct, nbr_iter)
%
%   1.1.  Input parameters
%
%   o  Interp_pts : Real matrix [n,2]
%      Contains the interpolation points in the format : abscissa-
%      ordinate.
%
%   o  Holder_funct : Character string
%      Specifies the Holder function you want to prescribe. It must have
%      the form of compositions of matlab functions of variable t
%      ('2*sqrt(1-t)' for instance). The use of the variable t is crucial.
%      For shake of simplicity, this variable t is supposed to vary in
%      [0,1].
%
%   o  nbr_iter : integer
%      Number of iteration wanted in the generation process of the GIFS
%      attractor.
%
%   1.2.  Output parameters
%
%   o  x : Real vector
%      Contains the abscissa of the attractor graph.
%
%   o  y : Real vector
%      Contains the ordinates of the attractor graph.
%
%   2.  See also:
%
%   gifs and alphagifs
%
%   3.  Example:
%
%   I = [0 0
%   1 0];
%
%   [x,y] = prescrib(I,'abs(sin(3*pi*t))',10);
%   plot(x,y)
%    [x,y] is the graph of a continuous function F which interpolates
%   {(0,0); (0.5 1); (1,0)} and such that the Holder exponent
%   of F, at each point t, is abs(sin(3*pi*t)).
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

if nargin==2
	Iter=10;
end
p=1;
for j=1:Iter-1,
	for k=0:2^j-1,
		t = k*2^(-j) ;
		coefs(p) = eval(function1) ;
		p=p+1 ;
	end
end
[x,y] = prescalpha(Int,coefs,Iter);
