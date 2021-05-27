function [u,s,x,y] = flt(x,y,ccv) ;
%   flt
%   Fast Legendre transform
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes the Legendre transform of y  y^*(s) = sup_{x in X}[s.x -
%   y(x)]
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [u,s] = flt(x,y[,ccv])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  x : real valued vector [1,N]
%      samples support of the function y
%
%   o  y :  real valued vector [1,N]
%      samples of function y = y(x)
%
%   o  ccv : optional argument to choose between convex (ccv = 0) and
%      concave (ccv = 1) envelope.  Default value is ccv = 1 (concave)
%
%   1.2.  Output parameters
%
%   o  u : real valued vector [1,M]
%      transform of input y. Note that, since u stems from the envelope of
%      y, in general M <= N.
%
%   o  s : real valued vector [1,M]
%      Variable of the Legendre transform of y.
%
%   2.  See also:
%
%   3.  Examples
%
%   % Partition function synthesis (corresponding to binomial measures)
%     m0 = .55 ; m1 = 1 - m0 ;
%     m2 = .95 ; m3 = 1 - m2 ;
%     q = linspace(-20,20,201) ;
%     tau1 = - log2(exp(q.*log(m0)) + exp(q.*log(m1))) ;
%     tau2 = - log2(exp(q.*log(m2)) + exp(q.*log(m3))) ;
%     tau3 = min(tau1 , tau2) ;
%   % Legendre Transforms (yielding to Legendre spectra)
%     [u1,s1] = flt(q,tau1) ;
%     [u2,s2] = flt(q,tau2) ;
%     [u3,s3] = flt(q,tau3) ;
%   % Vizualisation
%     clf ,
%     subplot(211)
%     plot(q,tau1,'g',q,tau2,'b',q,tau3,'--r') ; grid ;
%     title('Partition functions') , xlabel('q') , ylabel('\tau(q)')
%     legend('\tau_1(q)','\tau_2(q)','\tau_3(q)') ;
%     subplot(212)
%     plot(s1,u1,'g',s2,u2,'b',s3,u3,'--r') ; grid ;
%     title('Legendre transforms of the Partition functions')
%     xlabel('\alpha') , ylabel('\tau^*(\alpha)')
%     legend('\tau_1^*(\alpha)','\tau_2^*(\alpha)','\tau_3^*(\alpha)') ;
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

[x,I] = sort(x) ;
y = y(I) ;
x0 = x ; y0 = y ;

if exist('ccv') == 0
  ccv = 1 ;            % ccv = 1 : CONCAVE
end
y = (-2*ccv+1)*y ;

Pdiff = -1 ;
while ~all(Pdiff >= 0)
  P = [] ; O = [] ;
  Nx = length(x) ;
  for i = 1:Nx-1
    p = polyfit([x(i+1) x(i)],[y(i+1) y(i)],1) ; 
    P(i) = p(1) ;
    O(i) = p(2) ;
  end,
  Pdiff = diff(P) ;
  II = find(Pdiff >= 0) ;
  x = x([1 II+1 Nx]) ;
  y = y([1 II+1 Nx]) ;
end
y = (1 - 2*ccv)*y ;
u = (2*ccv - 1)*O ;
s = (1 - 2*ccv)*P ;








