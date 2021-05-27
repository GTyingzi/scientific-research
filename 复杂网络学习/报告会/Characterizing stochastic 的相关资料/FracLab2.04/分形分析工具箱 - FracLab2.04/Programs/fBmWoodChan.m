function fBm=fBmWoodChan(n,h,tmax,sigma,seed) 
%   fbmWoodChan
%   Wood and Chan synthesis of a fractional Brownian motion
%   Olivier Barrière
%   January 2006
%
%   Generates a Fractional Brownian Motion (fBm) using Wood and Chan
%   circulant matrix
%
%   1.  Usage
%
%   ______________________________________________________________________
%   fBm=fBmWoodChan(n,h[,tmax[,sigma[,seed]]]) 
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   N  : Positive integer
%      Sample size of the fBm
%
%   o   H  : Real in [0,1]
%      Holder exponent
%
%   o   seed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   fBm  : real vector  [1,N]
%      Time samples of the fBm
%
%
%   2.  See also:
%
%   fbmlevinson, mBmQuantifKrigeage
%
%   3.  Examples
%
%   % Synthesis of a fractional Brownian Motion with Holder exponent H
%   N = 1024 ; H = 0.8 ;
%   t = linspace(0,1,N) ;
%   clf ;
%   [x] = fBmWoodChan(N,H) ;
%   plot(t,x) ;
%   title ('Fractional Brownian Motion - H = 0.8') ;
%   xlabel ('time') ;

% ------------------------------------------------------------------------
%
% References : 
%
%       1 - Wood and Chan (1994)
%       2 - Phd Thesis Coeurjolly (2000), Appendix A p.132 
%
% ------------------------------------------------------------------------

switch nargin
  case 2
    tmax = 1 ; 
    sigma = 1 ;
    seed = rand(1) * 1e6 ;
  case 3
    sigma = 1 ;
    seed = rand(1) * 1e6 ;
  case 4
    seed = rand(1) * 1e6 ;
end


% --------------------------------------------------------
% Construction of the first line of the circulant matrix C
% --------------------------------------------------------
m=2^(fix(log(n-1)/log(2)+1));
eigC=lineC(n,h,sigma,tmax,m);
% ----------------------------------------------
% research of the power of two (<2^18) such that
% C is definite positive
% ----------------------------------------------
eigC=fft(eigC);
while ((eigC<=0) & (m<2^17))
m=2*m;
eigC=lineC(n,h,sigma,tmax,m);
eigC=fft(eigC);
end
% -----------------------------------------------
% simulation of W=(Q)^t Z, where Z leads N(0,I_m)
% and	(Q)_{jk} = m^(-1/2) exp(-2i pi jk/m)
% -----------------------------------------------
randn('seed',seed);
ar=randn(m/2+1,1);
ai=randn(m/2+1,1);
ar(1)= sqrt(2) * ar(1);
ar(m/2+1)= sqrt(2) * ar(m/2+1);
ai(1)=0;
ai(m/2+1)=0;
ar=[ar(1:m/2+1); ar( m/2:-1:2 )];
aic=-ai;
ai=[ai(1:m/2+1); aic(m/2:-1:2)];
W=ar + i*ai;
% -------------------------
% reconstruction of the fGn
% -------------------------
W=sqrt(eigC').* W;
fGn=fft(W);
fGn=fGn/sqrt(2*m);
fGn=real(fGn);
fGn=fGn(1:n);
fBm=0.5*cumsum(fGn);
