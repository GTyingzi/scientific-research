function [x] = icontwt(wt,f,wave)
%   icontwt
%   Inverse Continuous L2 wavelet transform
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes the inverse continuous wavelet transform: reconstructs a 1-D
%   signal from its wavelet coefficients. The scale operator is unitary
%   with respect to the L2 norm.
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x_back]=icontwt(wt,f,wl_length)
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  wt :  Real or complex matrix [N,nt]
%      coefficient of the wavelet transform
%
%   o  f : real vector of size [N,1] or [1,N] which elements are in
%      /[0,0.5], in decreasing order.
%
%   o  wl_length  : scalar or matrix
%      specifies the reconstruction wavelet:
%      0: Mexican hat wavelet (real)
%      Positive real integer: real Morlet wavelet of size 2*wl_length+1)
%      at finest scale 1
%      Positive imaginary integer: analytic Morlet wavelet of size
%      2*wl_length+1) at finest scale 1
%      Real valued matrix with  N  columns: each column contains a dilated
%      versions of an arbitrary synthesis wavelet.
%
%   1.2.  Output parameters
%
%   o  x_back : Real or complex vector [1,nt]
%      Reconstructed signal.
%
%   2.  Description
%
%   2.1.  Parameters
%
%   o  wt : coefficient of the wavelet transform.  X-coordinated
%      corresponds to time (uniformly sampled), Y-coordinates correspond
%      to frequency (or scale) voices (geometrically sampled between  fmax
%      (resp. 1) and fmin (resp.  fmax / fmin ). First row of wt
%      corresponds to the highest analyzed frequency (finest scale).
%      Usually, wt is the output matrix wt of  contwt .
%
%   o  scale : analyzed scales (geometrically sampled between 1 and  fmax
%      /fmin. Usually, scale is the output vector scale of  contwt .
%
%   o  wl_length  : specifies the synthesis wavelet:
%      0: Mexican hat wavelet (real). The size of the wavelet is
%      automatically fixed by the analyzing frequency
%      Positive real integer: real Morlet wavelet of size 2*wl_length+1)
%      at finest scale (1)
%      Positive imaginary integer: analytic Morlet wavelet of size
%      2*|wl_length|+1) at finest scale 1. The corresponding wavelet
%      transform is then complex. May be usefull for event detection
%      purposes.
%      Real valued matrix: usually, for reconstruction wl_length is the
%      output matrix wavescaled from contwt.
%
%   2.2.  Algorithm details
%
%   The reconstruction algorithm Inverse Wavelet Transform , proceeds by
%   convolving the wavelet coefficients (obtained from contwt  ) by the
%   synthesis wavelet. As we deal with continuous wavelet decomposition,
%   the analyzing wavelet and its dual for reconstruction are the same
%   (continuous basis). This operation is iterated at each analyzed scale
%   j  yielding  N corresponding band-passed signal versions. The
%   reconstructed signal is the scale weighting sum of these  N  vectors.
%
%   3.  See also:
%
%   contwt, contwtmir
%
%   4.  Examples
%
%   % signal synthesis
%   x = Frac_morlet(0.1,128) ;
%   t = -128:128 ;
%   % Wavelet transform using a Morlet wavelet
%   [wtMorlet,scale,f,scaloMorlet] = contwt(x,0.01,0.5,128,8) ;
%   clf ; subplot(211) ;
%   viewmat(abs(wtMorlet),[0 1 24 0]) ;
%   title('Morlet Wavelet Transform')
%   xlabel('time') ; ylabel('frequency') ;
%   % exact Reconstruction with the same synthesis wavelet
%   [x_back1] = icontwt(wtMorlet,f,8) ;
%   % Reconstruction with  a different (Mexican hat) synthesis wavelet
%   [x_back2] = icontwt(wtMorlet,f,0) ;
%   subplot(212) ;
%   plot([t(:) t(:) t(:)],[x(:) x_back1(:) x_back2(:)])
%   legend('original','exact reconstruction','hybrid reconstruction')
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

[N,nt] = size(wt) ;
fmin = min(f) ; fmax = max(f) ;
a = logspace(log10(1),log10(fmax/fmin),N) ; amax = max(a) ;

if length(wave) == 1
  if abs(wave) > 0
    nh0 = abs(wave) ;
    for ptr = 1:N
      nha = round(nh0 * a(ptr)) ; 
      ha = fliplr(Frac_morlet(f(ptr),nha,~isreal(wave))) ;
      detail = conv(wt(ptr,:),ha) ;
      resol(ptr,:) = detail(nha+1:nha+nt)./(a(ptr)^2) ;
    end
  elseif wave == 0
    for ptr = 1:N
      ha = fliplr(mexhat(f(ptr))) ;
      nha = (length(ha)-1)/2 ;
      detail = conv(wt(ptr,:),ha) ;
      resol(ptr,:) = detail(nha+1:nha+nt)./(a(ptr)^2) ;
    end  
  end
elseif length(wave) > 1 
  for ptr = 1:N
    ha = fliplr(wave(2:wave(1,ptr)+1,ptr).') ; 
    firstindice = (wave(1,ptr)-rem(wave(1,ptr),2))/2 ;
    detail = conv(wt(ptr,:),ha) ;
    resol(ptr,:) = detail(firstindice+1:firstindice+nt)./(a(ptr)^2) ;
  end
end

x = integ(resol,a) ;







