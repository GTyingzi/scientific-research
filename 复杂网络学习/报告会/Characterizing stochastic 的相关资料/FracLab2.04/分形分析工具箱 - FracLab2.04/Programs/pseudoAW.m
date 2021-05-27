function [tfr,a,f,wt] = pseudoAW(x,K,wave,smooth,fmin,fmax,N);
%   pseudoAW
%   Pseudo affine Wigner distribution
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes a  Pseudo Affine Wigner Distributions  of a 1-D signal (real
%   or complex).
%
%   1.  Usage
%
%   [tfr,scale,f,wt] = pseudoAW(x,K,[wave,smooth,fmin,fmax,N]);
%
%   1.1.  Input parameters
%
%   o  x : Real or complex vector [1,nt] or [nt,1]
%      Time samples of the signal to be analyzed.
%
%   o  K : real scalar
%      Parameter of the pseudo affine Wigner distributions.
%      K = -1  : pseudo Unterberger
%      K = 0   : pseudo Bertrand
%      K = 1/2 : pseudo D-Flandrin
%      K = 2   : pseudo affine Wigner-Ville, etc ...
%
%   o  wvlt_length  : positive integer
%      specifies the analyzing wavelet:
%      0: Mexican hat wavelet (real)
%      Positive real integer: real Morlet wavelet of size 2*wvlt_length+1)
%      at finest scale 1
%      Positive imaginary integer: analytic Morlet wavelet of size
%      2*wvlt_length+1) at finest scale 1
%      Default value is the Mexican hat wavelet ( wvlt_length  = 0 )
%
%   o   smooth  : positive integer
%      half length of the time smoothing window. SMOOTH = 0 corresponds to
%      the Pseudo affine Wigner distribution with no time-smoothing.
%      Default value is mooth = 0.
%
%   o  fmin : real in  [0,0.5]
%      Lower frequency bound of the analysis. When not specified, this
%      parameter forces the program to interactive mode.
%
%   o  fmax :  real in  [0,0.5] and fmax >
%      Upper frequency bound of the analysis. When not specified, this
%      parameter forces the program to interactive mode.
%
%   o  N : positive integer.
%      number of analyzing voices.  When not specified, this parameter
%      forces the program to interactive mode.
%
%   1.2.  Output parameters
%
%   o  tfr : Real matrix [N,nt]
%      time-frequency distribution
%
%   o  scale : real vector [1,N]
%      analyzed scales
%
%   o  f : real vector [1,N]
%      analyzed frequencies
%
%   o  wt : real or complex matrix [N,nt]
%      matrix of the wavelet coefficients (intermediate step)
%
%   2.  See also:
%
%   contwt, cwt1D and lambdak
%
%   3.  Examples
%
%   % signal synthesis
%   x = Frac_morlet(0.35,32)+Frac_morlet(0.1,32) ;
%   % K = -1: pseudo affine Wigner distribution with no time smoothing
%   [tfr,scale,f,wt] = pseudoAW(x,-1,12*i,0,0.01,0.5,128) ;
%   clf ; subplot(211) ;
%   viewmat(abs(tfr),1:length(x),f) ;
%   title('Pseudo affine Wigner distribution ; k = -1')
%   xlabel('time') ; ylabel('frequency') ;
%   % K = -1 time smoothed pseudo affine Wigner distribution
%   [tfr,scale,f,wt] = pseudoAW(x,-1,12*i,3,0.01,0.5,128) ;
%   subplot(212) ;
%   viewmat(abs(tfr),1:length(x),f) ;
%   title('time smoothed pseudo affine Wigner distribution ; k = -1') ;
%   xlabel('time') ; ylabel('frequency') ;
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
  error('at least two input parameters required') ;
case 2
  wave = 0 ;
  smooth = 0 ;
  nargfixed = 4 ;
case 3
  smooth = 0 ;
  nargfixed = 4 ;
case {4,5,6}
  nargfixed = 4 ;
case 7
  nargfixed = 7 ;
end

[xr,xc] = size(x) ;
if xr ~= 1 & xc ~= 1
  error('1-D signals only')
elseif xc == 1
  x = x.' ;
end
nt = size(x,2) ; 

if nargfixed  == 4
  XTF = fft(fftshift(x)) ;
  sp = (abs(XTF(1:nt/2))).^2 ;
  f = linspace(0,0.5,nt/2+1) ; f = f(1:nt/2) ;
  plot(f,sp) ; grid ;
  xlabel('frequency');
  title('Analyzed Signal Spectrum') ;
  fmin = input('lower frequency bound = ') ;
  fmax = input('upper frequency bound = ') ;
  N = input('Frequency samples = ') ;
end

if length(wave) > 1, 
  error('Morlet or Mexican hat wavelet only') ; 
elseif wave == 0 , 
  tsupport = (length(mexhat(fmax))-1)/2 ; 
elseif abs(wave) > 0 , 
  tsupport = abs(wave) ; 
end

Qte = fmax/fmin;
umax = log(Qte) ;
Teq = tsupport/(fmax*umax);  
if Teq<2*tsupport
  M0 = round((2*tsupport^2)/Teq-tsupport) ; 
  MU = tsupport+M0 ; 
elseif Teq>=2*tsupport
  MU = tsupport ; 
end

k = 1:N ; q = (fmax/fmin)^(1/(N-1));
a = (exp((k-1).*log(q)))  ;     % a is an increasing scale vector.
geo_f(k) = fmin*a ;             % geo_f is a geometrical increasing
                                % frequency vector.
				
% Wavelet computation

[wt] = contwt(x,geo_f(1),geo_f(N),N,wave) ;
wtnonorm = zeros(size(wt)) ;

for ptr = 1:N, 
  wtnonorm(ptr,:) = wt(ptr,:).*sqrt(a(ptr)) ; 
end ;

% Pseudo Affine Wigner distribution computation

tfr=zeros(size(wt));
umin = -umax ;
u=linspace(umin,umax,2*MU+1) ; u(MU+1) = 0;
k = 1:2*N;
beta(k) = -1/(2*log(q))+(k-1)./(2*N*log(q));
for m = 1:2*MU+1
  l1(m,:) = exp(-(2*i*pi*beta).*log(lambdak(u(m),K)));
end 

% NEW DETERMINATION OF G(T) (cf. pp.148 notebook Rice)

a_t = 3 ;            	% (attenuation of 10^(-a_t) at t = tmax)
sigma_t = smooth*fmax/sqrt(2*a_t*log(10)) ;
a_u = 2 * pi^2 * sigma_t^2 * umax^2 / log(10) ;
if sigma_t 
  sigma_u = 1/(2 * pi * sigma_t) ;
else
  sigma_u = inf ;
end
G = gauss(2*MU+1,a_u) ; G = G(1:2*MU) ;
if sigma_u < umax/MU
  fenh = findobj('Tag','Fig_gui_fl_pseudoaw') ;
  if isempty(fenh)
    disp('maximum time-smoothing corresponding to the scalogram reached ') ;
  end
end

G = G(ones(1,N),:)' ;

for ti = 1:nt      
  S = zeros(1,2*N) ; 
  S(N:-1:1) =  wtnonorm(:,ti) ; 
  S(N+1:2*N) = zeros(1,N) ;
  Mellin = fftshift(ifft(S)) ;
  waf = zeros(2*MU,N) ; 
  MX1 = l1.*Mellin(ones(1,2*MU+1),:) ;
  X1 = fft(MX1.') ; X1 = X1(1:N,:).' ;
  waf = real(X1(1:2*MU,:).*conj(X1(2*MU+1:-1:2,:)).*G) ;
  tfr(N:-1:1,ti) = (sum(waf).*geo_f).';      
end;

f = flipud(sort(geo_f(:))) ;





