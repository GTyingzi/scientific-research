function [alpha,f_alpha,logpart,tau] = cwtspec(wt,scale,Q,FindMax,ChooseReg)
%   cwtspec
%   Continuous L1 wavelet based Legendre spectrum
%   Paulo Goncalves
%   June 6th 1997
%
%   Estimates the multifractal Legendre spectrum of a 1-D signal from the
%   wavelet coefficients of a L1 continuous decomposition
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [alpha,f_alpha,logpart] = cwtspec(wt,scale,Q[,FindMax,ChooseReg])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  wt : Real or complex matrix [N_scale,N]
%      Wavelet coefficients of a continuous wavelet transform (output of
%      cwt)
%
%   o  scale : real vector  [1,N_scale]
%      Analyzed scale vector
%
%   o  Q :  real vector [1,N_Q]
%      Exponents of the partition function
%
%   o  FindMax : 0/1 flag.
%      FindMax = 0 : estimates the Legendre spectrum from all coefficients
%      FindMax = 1 : estimates the Legendre spectrum from the local Maxima
%      coefficients of the wavelet transform
%      Default value is FindMax = 1
%
%   o  ChooseReg : 0/1 flag or integer vector [1,N_reg], (N_reg <=
%      N_scale) ChooseReg = 0 : full scale range regression
%      ChooseReg = 1 : asks online the scale indices setting the range for
%      the linear regression of the partition function.
%      ChooseReg = [n1 ... nN_reg] : scale indices for the linear
%      regression of the partition function.
%
%   1.2.  Output parameters
%
%   o  alpha : Real vector [1,N_alpha], N_alpha <= N_Q
%      Singularity support of the multifractal Legendre spectrum
%
%   o  f_alpha : real vector [1,N_alpha]
%      Multifractal Legendre spectrum
%
%   o  logpart : real matrix [N_scale,N_Q]
%      Log-partition function
%
%   o  tau : real vector [1,N_Q]
%      Regression function
%
%   2.  See also:
%
%   cwt1D, contwtspec, contwt, dwtspec
%
%   3.  Examples
%
%   % signal synthesis
%   N = 256 ; H = 0.7 ; Q = linspace(-10,10,41) ;
%   [x] = fbmlevinson(N,H) ;
%   % Continuous Wavelet transform (L1 normalization)
%   [wt,scale] = cwt1D(x,2^(-6),2^(-1),16,8) ;
%   % Legendre Spectrum estimation
%   [alpha,f_alpha,logpart,tau] = cwtspec(wt,scale,Q,1,1) ;
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
  case 3, FindMax = 1 ; ChooseReg = 0 ;
  case 4, ChooseReg = 0 ;
end

nscale = length(scale) ;

if FindMax == 1 
  maxmap = findWTLM(wt,scale) ;
elseif FindMax == 0
  maxmap = ones(size(wt)) ;
end

% matrix reshape of the wavelet coefficients

detail = abs(wt.') ; 
maxmap = maxmap.' ;
logscale = log2(scale(:)) ;

% computation of the partition function and the mass function

for nq = 1:length(Q)
  for j=1:nscale
    max_idx = find(maxmap(:,j) == 1) ;
    DetPowQ = detail(max_idx,j).^Q(nq) ;
    logpart(j,nq) = log2(mean(DetPowQ)) ;
  end
end

if ChooseReg == 1

  figure('Tag','graph_reg')
  
  reg = 1:nscale ;
  reg_log = reg ;
  
%  axes('position',[0.1 0.7 0.8 0.2]) ;     
%  plot(logscale(2:nscale),diff(logpart(:,Q>=0)), ...
%       logscale(2:nscale),diff(logpart(:,Q>=0)),'o'), axis tight
%  title('Increments \Delta log_2(S_n(q))'), xlabel('log_{2}(scale)'),
%  axes('position',[0.1 0.1 0.8 0.5]) ; 
%  plot(logscale,logpart,logscale,logpart,'o'), axis tight
%  ylabel('Partition function log_2(S_n(q))'), xlabel('log_{2}(scale)')

  while ~isempty(reg_log)   
    
    subplot(121) ;
    plot(logscale,logpart,logscale,logpart,'+'), axis tight
    ylabel('Partition function log_2(S_n(q))'), xlabel('log_{2}(scale)')
    
    reg_log = fracginput(2) ; 
    
    if ~isempty(reg_log)
      reg = find(min(reg_log(1,1),reg_log(2,1)) <= logscale & ...
	  logscale <= max(reg_log(1,1),reg_log(2,1))) ;
     end

    for nq = 1:length(Q) 
      slope = polyfit(logscale(reg),logpart(reg,nq),1) ;
      tau(nq) = slope(1) - 1 - Q(nq)/2 ;
    end

    % computation of the Legendre spectrum

    [f_alpha,alpha] = flt(Q,tau) ;
    subplot(222) 
    plot(alpha,f_alpha) ; title('spectrum') ;
    xlabel('\alpha'),ylabel('f_{\alpha}')
    subplot(224)
    plot(Q,tau) : title('\tau(q)') ; xlabel('q') ;
    
  end
 
elseif ChooseReg == 0
  reg = 1:nscale ;
elseif length(ChooseReg) > 1
  reg = ChooseReg ;
end

for nq = 1:length(Q) 
  slope = polyfit(logscale(reg),logpart(reg,nq),1) ;
  tau(nq) = slope(1) - 1 ;
end

% computation of the Legendre spectrum

[f_alpha,alpha] = flt(Q,tau) ;


