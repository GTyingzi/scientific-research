function [x,wtx,wtxinit] = fbmfwt(N,H,noctaves,q,randseed) 
%   fbmfwt
%   Discrete wavelet based synthesis of a fBm
%   Paulo Goncalves
%   June 30rd 1997
%
%   Generates a 1/f Gaussian process from a discrete wavelet transform
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x] = fbmfwt(N,H,[noctave,Q,randseed]) ;
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
%   o   noctave  : integer
%      Maximum resolution level (should not exceeed log2(N))
%
%   o   Q  : real vector.
%      Analyzing QMF (e.g.  Q = MakeQMF('daubechies',4) )
%
%   o   randseed  : real scalar
%      Random seed generator
%
%   1.2.  Output parameters
%
%   o   x  : real vector  [1,N]
%      Time samples of the 1/f Gaussian process
%
%   2.  See also:
%
%   fbmlevinson, synth2, FWT, MakeQMF
%
%   3.  Examples
%
%   % Generation of the Wavelet filter coefficients (Daubechies or regularity 2)
%     Q = MakeQMF('daubechies',4) ;
%   % Wavelet synthesis of a 1/f process
%     N = 1024 ; H = 0.8 ; ScaleDepth = 10 ;
%     t = linspace(0,1,N) ;
%     [x] = fbmfwt(N,H,ScaleDepth,Q) ;
%     clf ; subplot(211)
%     plot(t,x) ; title ('Wavelet based 1/f process')
%     xlabel ('time')
%   % Continuous wavelet decomposition of the process
%     Smin = 2^(-6) ; Smax = 2^(-1) ; Nscale = 64 ; WaveLength = 8 ;
%     [wt,scale,f] = contwtmir(x,Smin,Smax,Nscale,WaveLength) ;
%     subplot(212) ;
%     viewmat(abs(wt),[0 1 12 0]) ;
%   % Long Range Dependance Estimation
%     WichT = 0 ; FindMax = 0 ; ChooseReg = 1 ;
%     [Hest] = cwttrack(wt,scale,WichT,FindMax,ChooseReg)
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
    
    noctaves = floor(log2(N)) ;
    q = MakeQMF('daubechies',4) ;
    
  case 3
    
    q = MakeQMF('daubechies',4) ;
    
end

if exist('randseed') ;
  
  randn('seed',randseed) ;
  
end

xinit = randn(1,N) ;

[wtxinit,wti,wtl,siz] = FWT(xinit,noctaves,q) ;
scale = exp((0:noctaves-1) * log(2)) ;
wtx = wtxinit ;

for j = 1 : noctaves
  
  wtx(wti(j):wti(j)+wtl(j)-1)  = wtx(wti(j):wti(j)+wtl(j)-1).*(scale(j).^(H+1/2)) ;

end

[x] = IWT(wtx) ;

x = x(:) ;
x=x(1:siz);
