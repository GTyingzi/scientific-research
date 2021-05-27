function [x,Ht,Fi,kmax] = GeneWei(N,ht,l,tmax,randflag,kmax)
%   GeneWei
%   Generalized Weierstrass function
%   Paulo Goncalves
%   June 6th 1997
%
%   Generates a Generalized Weierstrass function
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x,Ht]=GeneWei(N,ht,lambda,tmax,randflag)
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   N  : Positive integer
%      Sample size of the synthesized signal
%
%   o   ht  : Real vector or character string
%       ht : real vector of size [1,N]: each element prescribes the local
%      Holder regularity of the function. All elements of  ht  must be in
%      the interval [0,1].
%       ht : character string : contains the analytic expression of the
%      Holder trajectory
%
%   o   lambda  : positive real
%      Geometric progression of the Weierstrass function. Default value is
%      lambda = 2.
%
%   o  tmax  : positive real
%      Time support of the Weierstrass function. Default value is tmax =
%      1.
%
%   o   randflag  : flag 0/1
%       flag  = 0 : deterministic Weierstrass function
%       flag  = 1 : random Weierstrass process
%      Default value is randflag = 0
%
%   1.2.  Output parameters
%
%   o   x  : real vector  [1,N]
%      Time samples of the Weierstrass function
%
%   o   Fj  : real vector [1,N]
%      Holder trajectory of the Weierstrass function
%
%   2.  See also:
%
%   3.  Examples
%
%   % Generalized Weierstrass function synthesis
%     N = 1024 ;              % number of points
%     H = 'abs(sin(8*t))' ;   % Holder trajectory
%     l = 2 ;                 % Lambda (geometric progression)
%     tmax = 1 ;              % time extent (0 < t < tmax)
%     RandFlag = 0 ;          % deterministic version
%     t = linspace(0,1,N) ;
%     [x,Ht] = GeneWei(N,H,l,tmax,RandFlag) ;
%     clf ; subplot(211)
%     plot(t,Ht) ;
%     title ('time')
%     subplot(212)
%     plot(t,x) ;
%     title ('Generalized Weierstrass Function') ; xlabel ('time')
%
%   % IFS-based Holder function estimation
%
%     Hest = alphagifs(x,'cesaro');
%     subplot(211) ;
%     hold on ; plot(t,Hest,'r') ; hold off
%     legend('Theoretical H(t)','Estimated H(t)') ;
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

switch nargin
case 1
  error('At least two input parameters required')
case 2
  l = 2 ;
  tmax = 1 ;
  randflag = 0 ;
  kmax = floor(log(N/(2*tmax))/log(l)) ;
case 3
  tmax = 1 ;
  randflag = 0 ;
  kmax = floor(log(N/(2*tmax))/log(l)) ;
case 4
  randflag = 0 ;
  kmax = floor(log(N/(2*tmax))/log(l)) ;
case 5
  kmax = floor(log(N/(2*tmax))/log(l)) ;
end
                                    
if randflag ~= 0 & randflag ~= 1
  error('unknown option for randflag')
end ;

x=zeros(1,N);
C = randn(1,kmax+1) * randflag + ones(1,kmax+1) * (1-randflag) ;
A=rand(1,kmax+1)*2*pi * randflag ;

if length(ht) == 1
  s = 2 - ones(1,N) * ht ;
elseif length(ht) > 1 & length(ht) ~= N
  t = linspace(0,tmax,N) ;
  s = 2 - eval(ht) ;
elseif length(ht) == N
  s = 2 - ht ;
end

Fi = zeros(1,kmax+1) ;

% WEIERSTRASS COMPUTATION

for k=0:kmax
   y=C(k+1)*exp(log(l)*(s-2)*k).*(sin(2*pi*l^k*tmax/N*(0:N-1)+A(k+1)));
   Fi(k+1) = l^k ;
   x(1:N)=x(1:N)+y;
end
Ht = 2-s ;

x = x(:) ;

