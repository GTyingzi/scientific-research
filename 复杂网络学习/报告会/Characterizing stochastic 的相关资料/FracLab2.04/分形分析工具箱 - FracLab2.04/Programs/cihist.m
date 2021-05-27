function [x,y,z] = cihist(Ci,nbclas,cmax)
%   cihist
%   Khalid Daoudi
%   June 6th 1997
%
%   Plots the normalized histogram of GIFS coefficients (troncated if
%   desired) and the Gaussian distribution that fits at best the GIFS
%   coefficients one.
%
%   1.  Usage
%
%   [x,y,z] = cihist(Ci,[nbclass,cmax])
%
%   1.1.  Input parameters
%
%   o  Ci : Real matrix
%      Contains the GIFS coefficients (obtained using wave2gifs)
%
%   o  nbclass : Real scalar
%      Intger specifying the classes used in the samples values
%      subdivision (nbclass=100 by default)
%
%   o  cmax :  Real scalar
%      If specified, only the Ci's whose absolute values are samller the
%      cmax will be considered
%
%   1.2.  Output parameters
%
%   o  x : Real vector
%      Contains the bins centers
%
%   o  y : Real vector
%      Contains the the normalized number of Ci's elements in each
%      container
%
%   o  z : Real vector
%      Contains the the normalized number of Gaussian's elements in each
%      container
%
%   2.  See also:
%
%   hist, wave2gifs.
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

C=Ci;
if nargin == 1
	nbclas = 100;
end 
if nargin == 3
	I=find(abs(Ci)<cmax) ;
	C = Ci(I) ;
end

N=length(C);
moy=mean(C);
var=sum((C-moy).^2)./(N-1);
[n,x]=hist(C,nbclas);
y=n./(sum(n)*(x(2)-x(1)));
Gauss=exp(-((x-moy).^2)./(2*var))./sqrt((2*pi*var));
z=Gauss./(sum(Gauss)*(x(2)-x(1)));
bar(x,y);
hold on;
plot(x,z,'W-');
hold off;
%keyboard ;

