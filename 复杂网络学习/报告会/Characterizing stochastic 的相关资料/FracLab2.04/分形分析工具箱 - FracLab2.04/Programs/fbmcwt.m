function [x] = fbmcwt(N,H,fmin,fmax,nvoices,wl_length,randseed) 
%   fbmcwt
%   Continuous wavelet based synthesis of a fBm
%   Paulo Goncalves
%   June 30rd 1997
%
%   Generates a 1/f Gaussian process from a continuous wavelet transform
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x] = fbmcwt(N,H,[fmin,fmax,nvoices,wl_length,randseed]) ;
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
%   o   fmin  : real in ]0,0.5[
%      Lower frequency bound for synthesis
%
%   o   fmax  : real in ]0,0.5]
%      Upper frequency bound for synthesis (fmax > fmin)
%
%   o   nvoices  : integer
%      Number of synthesized voices between  fmin  and  fmax
%
%   o   wl_length  : integer
%       wl_length  > 0 : real Morlet of length  2*wl_length+1  at fmax
%       wl_length  = 0 : real mexican hat wavelet
%
%   o   seed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   x  : real vector  [1,N]
%      Time samples of the 1/f Gaussian process
%
%   2.  See also:
%
%   fbmfwt, fbmlevinson
%
%   3.  Examples
%
%   % Continuous Wavelet synthesis of a 1/f process
%     N = 1024 ; H = 0.8 ;
%     Smin = 2^(-8) ; Smax = 2^(-1) ; Nscale = 128 ; WaveLength = 8 ;
%     t = linspace(0,1,N) ;
%     [x] = fbmcwt(N,H,Smin,Smax,Nscale,WaveLength) ;
%     clf ;
%     plot(t,x) ; title ('Wavelet based 1/f process')
%     xlabel ('time')
%   % Regularized Dimension Estimation
%     [dim,H] = regdim(x,0,128,10,500,'gauss',0,1,1);
%
%   ______________________________________________________________________
%
%   [x] = fbmcwt(1024,0.8,2^(-8),2^(-1),64,8) ;
%   [wt,scale,f] = contwt(x,2^(-8),2^(-1),64,8) ;
%   [HofT] = cwttrack(wt,scale,0,1,1,8,1,1) ;
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

switch nargin
  
  case 2
    
    fmin = 2^(-round(log2(N))) ;
    fmax = 2^(-1) ;
    nvoices = 4 * round(log2(N)) ;
    wl_length = 8 ;
    
  case 3
    
    fmax = 2^(-1) ;
    nvoices = 4 * round(log2(N)) ;
    wl_length = 8 ;
    
  case 4
    
    nvoices = 4 * round(log2(N)) ;
    wl_length = 8 ;
    
  case 5
    
    wl_length = 8 ;
         
end

if exist('randseed') ;
  
  randn('seed',randseed) ;
  
end

xinit = randn(1,N) ;

[wtxinit,scale,freq] = contwt(xinit,fmin,fmax,nvoices,wl_length) ;

weigth = exp((H + 1/2) * log(freq./freq(nvoices))) ;
weigth = weigth(ones(1,N),:)' ;

wtx = wtxinit ./ weigth ;

[x] = icontwt(wtx,freq,wl_length) ;

x = x(:) ;
