function [wt,a,f,scalo,wavescaled] = contwt(x,fmin,fmax,N,wave);
%   contwt
%   Continuous L2 wavelet transform
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes a continuous wavelet transform of a 1-D signal (real or com-
%   plex). The scale operator is unitary with respect to the L2 norm.  Two
%   closed form wavelets are available: the Mexican Hat or the Morlet
%   Wavelet (real or analytic). For arbitrary analyzing wavelets, numeri-
%   cal approximation is achieved using a Fast Mellin Transform.
%
%   1.  Usage
%
%   [wt,scale,f,scalo,wavescaled]=contwt(x,[fmin,fmax,N,wvlt_length])
%
%   1.1.  Input parameters
%
%   o  x : Real or complex vector [1,nt] or [nt,1]
%      Time samples of the signal to be analyzed.
%
%   o  fmin : real scalar in  [0,0.5]
%      Lower frequency bound of the analysis. When not specified, this
%      parameter forces the program to interactive mode.
%
%   o  fmax :  real scalar [0,0.5] and fmax >
%      Upper frequency bound of the analysis. When not specified, this
%      parameter forces the program to interactive mode.
%
%   o  N : positive integer.
%      number of analyzing voices.  When not specified, this parameter
%      forces the program to interactive mode.
%
%   o  wvlt_length  : scalar or vector
%      specifies the analyzing wavelet:
%      0: Mexican hat wavelet (real)
%      Positive real integer: real Morlet wavelet of size 2*wvlt_length+1)
%      at finest scale 1
%      Positive imaginary integer: analytic Morlet wavelet of size
%      2*wvlt_length+1) at finest scale 1
%      Real valued vector: waveform samples of an arbitrary bandpass
%      function.
%
%   1.2.  Output parameters
%
%   o  wt : Real or complex matrix [N,nt]
%      coefficients of the wavelet transform.
%
%   o  scale : real vector [1,N]
%      analyzed scales
%
%   o  f : real vector [1,N]
%      analyzed frequencies
%
%   o  scalo : real positive valued matrix [N,nt]
%      Scalogram coefficients (squared magnitude of the wavelet
%      coefficients  wt )
%
%   o  wavescaled : Scalar or real valued matrix [length(wavelet at
%      coarser scale)+1,N]
%
%      Dilated versions of the analyzing wavelet
%
%   2.  See also:
%
%   icontwt, contwtmir and cwt1D
%
%   3.  Examples
%
%   % signal synthesis
%   x = Frac_morlet(0.1,128) ;
%   % Wavelet transform using an analytic Morlet wavelet
%   [wtMorlet,scale,f,scaloMorlet] = contwt(x,0.01,0.5,128,8*i) ;
%   clf ; subplot(211) ;
%   viewmat(abs(wtMorlet),[0 1 24 0]) ;
%   title('Morlet Wavelet Transform')
%   xlabel('time') ; ylabel('frequency') ;
%   % Compared with a wavelet transform using a Mexican hat wavelet
%   [wtMex,scale,f,scaloMex] = contwt(x,0.01,0.5,128,0) ;
%   subplot(212) ;
%   viewmat(abs(wtMex),[0 1 24 0]) ;
%   title('Mexican hat Wavelet Transform') ;
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

[xr,xc] = size(x) ;
if xr ~= 1 & xc ~= 1
  error('1-D signals only')
elseif xc == 1
  x = x.' ;
end

% DEFAULT VALUES

nt = size(x,2) ;
if exist('wave') == 0 
  wave = 0 ;
end

if nargin == 1
  XTF = fft(fftshift(x)) ;
  sp = (abs(XTF(1:nt/2))).^2 ;
  f = linspace(0,0.5,nt/2+1) ; f = f(1:nt/2) ;
  plot(f,sp) ; grid ;
  xlabel('frequency');
  title('Analyzed Signal Spectrum') ;
  fmin = input('lower frequency bound = ') ;
  fmax = input('upper frequency bound = ') ;
  N = input('Frequency samples = ') ;
  fmin_s = num2str(fmin) ; fmax_s = num2str(fmax) ; 
  N_s = num2str(N) ;
  disp(['frequency runs from ',fmin_s,' to ',fmax_s,' over ',N_s,' points']) ;
end
if nargin == 4 | nargin == 5
  if fmin >= fmax
    error('fmax must be greater than fmin') ;
  end
end

f = logspace(log10(fmax),log10(fmin),N) ;
a = logspace(log10(1),log10(fmax/fmin),N) ; amax = max(a) ;

if length(wave) == 1
  if abs(wave) > 0
    nh0 = abs(wave) ;
    for ptr = 1:N
      nha = round(nh0 * a(ptr)) ; 
      ha = conj(Frac_morlet(f(ptr),nha,~isreal(wave))) ;
      detail = conv(x,ha) ;
      wt(ptr,1:nt) = detail(nha+1:nha+nt) ;
    end
  elseif wave == 0
    for ptr = 1:N
      ha = mexhat(f(ptr)) ; nha = (length(ha)-1)/2 ;
      detail = conv(x,ha) ;
      wt(ptr,:) = detail(nha+1:nha+nt) ;
    end  
  end
  wavescaled = wave ;
elseif length(wave) > 1 
  wavef = fft(wave) ; nwave = length(wave) ; 
  f0 = find(abs(wavef(1:nwave/2)) == max(abs(wavef(1:nwave/2)))) ;
  f0 = mean((f0-1).*(1/nwave)) ;
  disp(['mother wavelet centered at f0 = ',num2str(f0)]) ;
  f = logspace(log10(fmax),log10(fmin),N) ;
  a = logspace(log10(f0/fmax),log10(f0/fmin),N) ; amax = max(a) ;
  B = 0.99 ; R = B/((1.001)/2) ; 
  nscale = max(128,round((B*nwave*(1+2/R)*log((1+R/2)/(1-R/2)))/2)) ;
  [wavescaled] = Frac_dilate(wave,a,0.001,0.5,nscale) ;
  wavescaled = real(wavescaled) ;
  for ptr = 1:N
    ha = wavescaled(2:wavescaled(1,ptr),ptr) ; 
    firstindice = (wavescaled(1,ptr)-rem(wavescaled(1,ptr),2))/2 ; 
    detail = conv(x,ha) ;
    detail = detail(firstindice+1:firstindice+nt) ;
    wt(ptr,1:nt) = detail(:).' ;
  end
end

if nargout >= 4
  scalo = real(wt.*conj(wt)) ;
end

