function [x,wt,wti,wtl] = lacunary(N,n,a,f1,TossChoice) ;
%   lacunary
%   Lacunary sequence synthesis using a discrete wavelet trans-
%   form
%   Paulo Goncalves
%   October 7rd 1998
%
%   Discrete wavelet based synthesis of a lacunary time serie
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [x,wt,wti,wtl] = lacunary(N,n,a,f1,TossChoice) ;
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   N  : Positive integer
%      Sample size of the lacunary sequence
%
%   o   n  :  Real in [0,1]
%      Lacunarity coefficient
%
%   o   a  : Real in [0,1]
%      Holder (or regularity) exponent
%
%   o   f1  : real vector.
%      Analyzing QMF (default value is  Q = MakeQMF('daubechies',2) )
%
%   o   TossChoice  : boolean
%      Mode for the random lacunary positions selection
%      (0) without feedback (default value)
%      (1) with feedback
%
%   1.2.  Output parameters
%
%   o   x  : real vector  [1,N]
%      Time samples of the lacunary time serie
%
%   o   wt  : real vector
%      Contains the wavelet generating coefficients
%
%   o   wti  : real vector
%      Wavelet coefficients indices
%
%   o   wtl  : real vector
%      Wavelet coefficients lengths
%
%   2.  See also:
%
%   fBmfwt, FWT, MakeQMF
%
%   3.  Examples
%
%   % Generation of the Wavelet filter coefficients (Daubechies of regularity 2)
%     f1 = MakeQMF('daubechies',4) ;
%   % Wavelet synthesis of the lacunary time serie
%     N = 1024 ; a = 0.8 ; n = 0.9 ; TossChoice = 0 ;
%     t = linspace(0,1,N) ;
%     [x] = lacunary(N,n,a,f1,TossChoice) ;
%     clf ; subplot(211)
%     plot(t,x) ; title ('Lacunary sequence')
%     xlabel ('time')
%   % Continuous wavelet decomposition of the process
%     Smin = 2^(-6) ; Smax = 2^(-1) ; Nscale = 64 ; WaveLength = 8 ;
%     [w,scale,f] = contwtmir(x,Smin,Smax,Nscale,WaveLength) ;
%     subplot(212) ;
%     viewmat(abs(w),[0 1 12 0]) ;
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
  
  case {1,2}
    
    error('Not enough input arguments.')
  
  case 3
    
    f1 = MakeQMF('daubechies',2) ; 
    TossChoice = 0 ;
    
  case 4
    
    TossChoice = 0 ;
    
end

J = round(log2(N)) ;
N0 = 2^(J) ;
v = zeros(1,N0) ;
[wt,wti,wtl] = FWT(v,J,f1) ;

for j = 1 : J
  
  ncoef = round(2^((J-j)*n)) ;
  
  if TossChoice 
  
    % determination aleatoire des positions lacunaires avec remise
    
    Pos = floor (rand(1,ncoef) .* wtl(j)) ;
  
  else
    
    % determination aleatoire des positions lacunaires sans remise
    
    if ncoef <= 2^(J-j-1) % selection des ncoef coefficients non nuls
      
      Pos = floor (rand(1,ncoef) .* wtl(j)) ;
      [PosSort,PosIdx] = sort(Pos) ;
      ii = find(diff(PosSort) == 0) ;
      Multi = ~isempty(ii) ;
      
      while Multi
	
	Pos(PosIdx(ii+1)) = floor (rand(size(ii)) .* wtl(j)) ;
	[PosSort,PosIdx] = sort(Pos) ;
	ii = find(diff(PosSort) == 0) ;
	Multi = ~isempty(ii) ;
	
      end
          
    elseif ncoef > 2^(J-j-1) % selection des (2^(J-j)-ncoef) coefficients nuls     
      PosZero = floor (rand(1,2^(J-j)-ncoef) .* wtl(j)) ;
      [PosZeroSort,PosZeroIdx] = sort(PosZero) ;
      ii = find(diff(PosZeroSort) == 0) ;
      Multi = ~isempty(ii) ;
      
      while Multi
	
	PosZero(PosZeroIdx(ii+1)) = floor (rand(size(ii)) .* wtl(j)) ;
	[PosZeroSort,PosZeroIdx] = sort(PosZero) ;
	ii = find(diff(PosZeroSort) == 0) ;
	Multi = ~isempty(ii) ;
	
      end
             
      Pos = ones(1,2^(J-j)) ;
      Pos(PosZero+1) = zeros(size(PosZero)) ;
      Pos = find(Pos) - 1 ;
      
    end
      
  end
  
  wt(wti(j) + Pos) = ones(1,ncoef) .* 2^(a*j) ; 
  
  % for a L-Infty normalization:
  
  wt(wti(j) + Pos) = wt(wti(j) + Pos) .* 2^(j/2) ; 
    
end

x = IWT(wt) ;




