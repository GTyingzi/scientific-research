function pc = ciplot(Ci,j1,j2,cmax)
%   ciplot
%   Khalid Daoudi
%   June 6th 1997
%
%   Plots the GIFS coefficients (troncated if desired) at different
%   scales.
%
%   1.  Usage
%
%   pc=ciplot(Ci,[M0,j1,j2,cmax])
%
%   1.1.  Input parameters
%
%   o  Ci : Real matrix
%      Contains the GIFS coefficients (obtained using wave2gifs)
%
%   o  j1 : Real scalar
%      Intger specifying the first scale you want in the plot (the finnest
%      scale is 1).  It must belong to {1,...,log2(lenght(signal))}
%
%   o  j1 : Real scalar
%      Intger specifying the last scale you want in the plot (the finnest
%      scale is 1).  It must belong to {1,...,log2(lenght(signal))}
%
%   o  cmax :  Real scalar
%      If specified, all the Ci's whose absolute value belong is greater
%      the cmax will be replaced by cmax (keeping their signe) in the
%      plot.
%
%   1.2.  Output parameters
%
%   o  pc : Real scalar
%      Percentage of clipped Ci's
%
%   2.  See also:
%
%   plot, wave2gifs.
%
%   3.  Example:
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

N = length(Ci) ;
J = Ci(N) ;
j0 = Ci(N-1)-1 ;
if  nargin == 1
	j1 = 1 ;
	j2 = j0 ;
end	
if  nargin == 2
	j2 = j0 ;
end

J1 = min(J-j1,J-j2) ;
J2 = max(J-j1,J-j2) ;
couleurs = 'ymcrgbk';
i = 1 ;
if nargin == 4
for j=J1:J2,
	p = 2^j;
	t=(1:2^(J2-j):2^J2);
	Ci_j = Ci(p-1:2*p-2) ;
	[C,pc] = clip(Ci_j,cmax) ;
	if i > 7
		i = 1 ;
	end 
	plot(t,C,couleurs(i))
	hold on
	i = i+1 ;
end
hold off
end

if nargin < 4
for j=J1:J2,
	p = 2^j;
	t=(1:2^(J2-j):2^J2);  
	Ci_j = Ci(p-1:2*p-2) ;
	if i > 7
		i = 1 ;
	end 
	plot(t,Ci_j,couleurs(i))
	hold on
	i = i+1 ;
end
hold off
pc = 0;
end
	
