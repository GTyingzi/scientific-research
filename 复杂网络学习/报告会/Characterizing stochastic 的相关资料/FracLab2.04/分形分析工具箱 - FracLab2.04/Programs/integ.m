function som = integ(y,x) 
%   integ
%   Approximate 1-D integral
%   Paulo Goncalves
%   June 6th 1997
%
%   Approximate 1-D integral. integ(y,x) approximates the integral of y
%   with respect to the variable x
%
%   1.  Usage
%
%   ______________________________________________________________________
%   SOM = integ(y[,x])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  y : real valued vector or matrix [ry,cy]
%      Vector or matrix to be integrated. For matrices, integ(Y) computes
%      the integral of each column of Y
%
%   o  x :  row-vector [ry,1]
%      Integration path of y. Default value is (1:cy)
%
%   1.2.  Output parameters
%
%   o  SOM : real valued vector [1,cy]
%      sum approximating the integral of y w.r.t the integration path x
%
%   2.  See also:
%
%   integ2d
%
%   3.  Examples
%
%   % Synthesis of a Normal p.d.f.
%     clf,
%     sigma = 1 ; N = 100 ;
%     x = logspace(log10(1e-4),log10(4),N/2) ;
%     x = [ -fliplr(x) x ] ;
%     y = 1/sqrt(2*pi) * exp( -(x.^2)./2 ) ;
%     subplot(211)
%     plot(x,y) , grid
%     title('Normal Probability Density Function f(x)')
%   % Calculus of the distribution function by integration of the p.d.f.
%     for n = 1:N
%       PartialSom(n) = integ( y(1:n),x(1:n) ) ;
%     end
%     subplot(212)
%     plot(x,PartialSom,x,PartialSom,'+r') , grid ,
%     title('Normal Distribution function : \int_{-\infty}^{x} f(u) du')
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

if size(y,1) == 1 ;
  y = y(:) ;
end
[my,ny] = size(y) ;

if nargin == 1 
  x = (1:my) ;
end

if length(x) ~= my
  error('X and Y must have same size')
end
x = x(:).' ;

dy = y(1:my-1,:) + y(2:my,:) ;
dx = (x(2:my)-x(1:my-1))/2 ;
som = dx*dy ;




