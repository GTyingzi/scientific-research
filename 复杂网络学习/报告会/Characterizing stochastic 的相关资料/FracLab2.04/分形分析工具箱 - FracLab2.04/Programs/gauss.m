function g = gauss(n,a,k)
%   gauss
%   Gaussian window
%   Paulo Goncalves
%   June 6th 1997
%
%   Returns a Gaussian window
%
%   1.  Usage
%
%   ______________________________________________________________________
%   Win = gauss(N[,A])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  N :  Positive integer
%      Number of points defining the time support of the window
%
%   o  A : Real positive scalar
%      Attenuation in dB at the end of the window (10^(-A)). Default value
%      is A = 2.
%
%   1.2.  Output parameters
%
%   o  Win : real vector [1,N]
%      Gaussian window in time.
%
%   2.  See also:
%
%   mexhat, Frac_morlet
%
%   3.  Examples
%
%   % Gaussian windows synthesis
%   t = linspace(-1,1,128) ;
%   ExpDecay = logspace(log10(0.1),log10(100),10)
%   Win = [] ;
%   for s = ExpDecay
%     Win = [Win gauss(128,s)'] ;
%   end
%   % Vizualisation - Matlab
%   StD = sqrt((2*ExpDecay*log(10)).^(-1)) ;
%   plot(t,Win) ; title('Gaussian windows with different Standard Deviations')
%   legend(num2str(StD(:)))
%
%   ______________________________________________________________________
%   t = linspace(-1,1,128) ;
%   Win1 = gauss(128,2) ;
%   Win2 = gauss(128,5) ;
%   ______________________________________________________________________
%
%    Vizualisation - Matlab
%
%   ______________________________________________________________________
%   plot(t,win1,'b',t,win2,'r') ;
%   legend('Gaussian window 1','Gaussian window 2')
%   ______________________________________________________________________
%
%    Vizualisation - Scilab
%
%   ______________________________________________________________________
%   plot2d([t(:) t(:)],[Win1(:) Win2(:)],[17 19])
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

if nargin == 1
  a = 2 ;
  k = 0 ;
end

if nargin == 2
  k = 0 ;
end

t=-(n-1)/2:(n-1)/2;
c=(a*log(10)/((n-1)/2)^2);
if k==0
  g =exp(-c*t.^2);
else
  g = polyval(polyGauss(k,c),t).* exp(-c*t.^2);
end

function p=polyGauss(k,c)

if k==1
  p=[-2*c,0];
  return;
end

p=[0,0,polyder(polyGauss(k-1,c))]-2*c*[polyGauss(k-1,c),0];




