function [HofT,whichT] = cwttrack_all(wt,scale,FindMax,ChooseReg,radius,DeepScale,dT,varargin)
%   cwttrack_all
%   Continuous L2 wavelet based Holder function estimation
%   Paulo Goncalves
%   June 21th 1997
%
%   Estimates the Holder function of a signal from its continuous wavelet
%   transform (L2 contwt).  cwttrack_all  merely runs cwttrack as many
%   times as there are time samples to be analyzed
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [HofT,whichT] = cwttrack_all(wt,scale,FindMax,ChooseReg,radius,DeepScale,dT)
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  wt : Real or complex matrix [N_scale,N]
%      Wavelet coefficients of a continuous wavelet transform (output of
%      contwt)
%
%   o  scale : real vector  [1,N_scale]
%      Analyzed scale vector
%
%   o  whichT :  Integer
%      whichT, when non zero specifies the time position on the signal
%      where to estimate the local Holder exponent.
%      When whichT is zero, the global scaling exponent (or LRD exponent)
%      is estimated.
%
%   o  FindMax : 0/1 flag.
%      FindMax = 0 : estimates the Holder exponents (local or global) from
%      all coefficients of the wavelet transform
%      FindMax = 1 : estimates the Holder exponents (local or global) from
%      the local Maxima coefficients of the wavelet transform
%      Default value is FindMax = 1
%
%   o  ChooseReg : 0/1 flag or integer vector [1,N_reg], (N_reg <=
%      N_scale) ChooseReg = 0 : full scale range regression
%      ChooseReg = 1 : scale range is choosed by the user, clicking with
%      the mouse on a regression graph.
%      ChooseReg = [n1 ... nN_reg] : imposes the scale indices for the
%      linear regression of the wavelet coefficients versus scale in a
%      log-log plot
%      Default value is  ChooseReg  = 0
%
%   o  radius : Positive integer.
%      The local maxima line search is restricted to some neighbourhood of
%      the analyzed point. Basically, this region is defined by the cone
%      of influence of the wavelet.  radius  allows to modulate the width
%      of the cone.
%      Default value is  cone  = 8 .
%
%   o  DeepScale : strictly positive integer.
%      DeepScale tells the maxima line procedure how depth in scale to
%      scan from step to step.
%      Default value is  DeepScale  = 1
%
%   o  dT 01 Integer.
%      Sampling period for the Holder function estimate
%
%   1.2.  Output parameters
%
%   o  HofT : Real scalar.
%      Local or global Holder exponent estimated
%
%   o  whichT  Integer vector Time sampling vector
%
%   2.  See also:
%
%   cwttrack
%
%   3.  Examples
%
%   % Generalized Weierstrass function synthesis
%     N = 512 ;               % number of points
%     H = 'abs(sin(8*t))' ;   % Holder trajectory
%     l = 2 ;                 % Lambda (geometric progression)
%     tmax = 1 ;              % time extent (0 < t < tmax)
%     RandFlag = 0 ;          % deterministic version
%     t = linspace(0,1,N) ;
%     [x,Ht] = GeneWei(N,H,l,tmax,RandFlag) ;
%     clf ; subplot(211)
%     plot(t,Ht) ;
%     hold on
%     subplot(212)
%     plot(t,x) ;
%     title ('Generalized Weierstrass Function') ; xlabel ('time')
%   % Wavelet transform (L2 normalization)
%     [wt,scale] = contwtmir(x,2^(-6),2^(-2),64,12*i) ;
%   % Local Holder estimation
%     StepT = 16 ;
%     [HtEst,WhichT] = cwttrack_all(wt,scale,0,0,8,1,StepT) ;
%     subplot(211) ;
%     stem(t(1:StepT:N),HtEst) ;
%     hold off ;
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


% function [HofT,whichT] = cwttrack_all(wt,scale,FindMax,ChooseReg,radius,DeepScale,dT)
%
% 	Estimates the Holder function of a signal from its continuous 
%	wavelet transform (L2 contwt). cwttrack_all merely runs cwttrack for each
%	time sample of the analyzed signal
%	See cwttrack for Input/Output parameter description
%	
% 	Extra Input parameter
%
%		dT	Integer
%			time sample width for the holder function estimate 
%			(dT = 1 corresponds to all time samples of the signal)
%		     
%	Extra Output parameter
%
%		whichT	Integer vector
%			time samples corresponding to each estimated value of 
%			output vector HofT : HofT(wichT)
%

nt = size(wt,2) ;
whichT = 1 : dT : nt ;
HofT =  zeros(1,size(whichT,2)) ;

for jT = 1 : length(whichT) 

  HofT(jT) = cwttrack(wt,scale,whichT(jT),FindMax,ChooseReg,radius,DeepScale,0,varargin{:}) ;

end








