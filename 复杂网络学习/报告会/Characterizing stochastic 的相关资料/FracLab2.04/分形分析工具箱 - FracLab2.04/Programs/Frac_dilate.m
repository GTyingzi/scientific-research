function [sscaled,mellin,beta] = Frac_dilate(s,a,fmin,fmax,N) ;
%   Frac_dilate
%   Dilation of a signal
%   Paulo Goncalves
%   June 6th 1997
%
%   Computes dilated/compressed version of a signal using Fast Mellin
%   transform.
%
%   1.  Usage
%
%   [sscaled,mellin,beta] = Frac_dilate(s,a,[fmin,fmax,N])
%
%   1.1.  Input parameters
%
%   o  s : real vector [1,nt] or [nt,1]
%      Time samples of the signal to be scaled.
%
%   o  a : real strictly positive vector [1,N_scale]
%      Dilation/compression factors. a < 1 corresponds to compression in
%      time
%
%   o  fmin : real scalar in [0,0.5]
%      Lower frequency bound of the signal (necessary for the intermediate
%      computation of the Mellin transform)
%
%   o  fmax :  real scalar [0,0.5] and fmax >
%      Upper frequency bound of the  signal (necessary for the
%      intermediate computation of the Mellin transform)
%
%   o  N : positive integer.
%      number of Mellin samples.
%
%   1.2.  Output parameters
%
%   o  sscaled : Real matrix with N_scale columns
%      Each column j (for j = 1 .. N_scale) contains the
%      dilated/compressed version of s by scale a(j). First element of
%      each column gives the effective time support for each scaled
%      version of s.
%
%   o  mellin : complex vector [1,N]
%      Mellin transform of s.
%
%   o  beta : real vector [1,N]
%      Variable of the Mellin transform mellin.
%
%   2.  See also:
%
%   dmt, idmt
%
%   3.  Examples
%
%   % Signal synthesis
%   x = Frac_morlet(0.1,32) ;
%   % Dilation by factors 0.6 , 1.2 and 1.8
%   [sscaled,mellin,beta] = Frac_dilate(x,[0.6 1.2 1.8],2^(-8),2^(-1),256) ;
%   [Npts,Nscales] = size(sscaled) ; Npts = Npts-1 ;
%   T = ones(Npts,Nscales).*NaN ;
%   for j = 1 : Nscales
%    supT = (sscaled(1,j)-1)/2 ;
%    T(1:2*supT+1,j) = (-supT:supT)' ;
%   end
%   subplot(211) ;
%   plot([-32:32],x) ; title('Original signal (a = 1)') ;
%   subplot(212)
%   plot(T,sscaled(2:Npts+1,:)) ;
%   legend('a = 0.6','a = 1.2','a = 1.8') ;
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

M = length(s) ;
if rem(M,2) == 0
  figh = findobj('Tag','Fig_gui_fl_dilate') ;
  if isempty(figh)
    disp('--- WARNING --- length of signal to be scaled must be a odd number')
    disp('                S zero-padded to the nearest odd length') ;
  elseif ~isempty(figh)
    fl_error('--- WARNING --- length of signal to be scaled must be a odd number. S zero-padded to the nearest odd length') ;
  end
  s = [s(:);0] ;
  M = M+1 ;
end
T = M-1;
if nargin == 2
  
  s = fftshift(s) ; STF = fft(s) ; s = fftshift(s);
  sp = (abs(STF(1:round(M/2)))).^2;
  f = linspace(0,0.5,round(M/2)+1) ; f = f(1:round(M/2));
    figure('Tag','graph_spectrum') ;
    freq_lim = [0.01 ; 0.5] ; % Initialization
    loglog(f,sp) ;  grid ;
    xlabel('frequency');
    title('Analyzed Signal Spectrum');
    while ~isempty(freq_lim) 
      
      fmin = min(freq_lim(:,1)) ;
      fmax = min(0.5,max(freq_lim(:,1))) ;
      B = fmax-fmin ; R = B/((fmin+fmax)/2) ;
      Nmin = (B*T*(1+2/R)*log((1+R/2)/(1-R/2)));
      str = ['Number of frequency samples [ N > ',num2str(ceil(Nmin)),' ]'] ;
      title(str) ;
      freq_lim = fracginput(2) ;
      
    end;
    
    N = 2^(ceil(log2(Nmin))) ;
    fenh = findobj('Tag','graph_spectrum') ;
    close(fenh) ;
end

[mellin,beta] = dmt(s,fmin,fmax,N) ;

for na = 1 : length(a)
  phase =  exp((-i*2*pi*beta+1/2)*log(a(na))) ;
  mellin_a = phase.*mellin ;
  nta = 2*round((a(na)*M-1)/2) + 1 ;
  sscaled(1,na) = nta ;
  sscaled(2:nta+1,na) = idmt(mellin_a,beta,nta) ;
end




