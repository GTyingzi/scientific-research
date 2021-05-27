function [alpha,f_alpha,logpart,tau] = dwtspec(wt,Q,ChooseReg,varargin)
%   dwtspec
%   Discrete wavelet based Legendre spectrum
%   Paulo Goncalves
%   June 6th 1997
%
%   Estimates the multifractal Legendre spectrum of a 1-D signal from the
%   wavelet coefficients of a discrete decomposition
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [alpha,f_alpha,logpart] = dwtspec(wt,Q[,ChooseReg])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  wt : Real vector [1,N]
%      Wavelet coefficients of a discrete wavelet transform (output of
%      FWT)
%
%   o  Q :  real vector [1,N_Q]
%      Exponents of the partition function
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
%   cwtspec, FWT, WTStruct, MakeQMF, flt, iflt
%
%   3.  Examples
%
%   % signal synthesis
%   N = 256 ; H = 0.7 ; Q = linspace(-10,10,41) ;
%   [x] = fbmlevinson(N,H) ;
%   % Discrete Wavelet transform
%   qmf = MakeQMF('daubechies',2) ;
%   [wt] = FWT(x,log2(N),qmf) ;
%   % Legendre Spectrum estimation
%   [alpha,f_alpha,logpart,tau] = dwtspec(wt,Q,1) ;
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
  case 2, ChooseReg = 0 ;
end

if isempty(varargin)
   varargin{1} = 'ls' ;
end


[sc_idx,sc_lg] = WTStruct(wt) ;

nscale = length(sc_idx)-1 ;
logscale = 1:nscale ;
wt = abs(wt) ;

% matrix reshape of the wavelet coefficients

detail = cell(1,nscale) ;
for j=1:nscale
  detail{j} = wt(sc_idx(j):sc_idx(j)+sc_lg(j)-1).' ; 
end

% computation of the partition function and the mass function

for nq = 1:length(Q)
  for j=1:nscale
     logpart(j,nq) = log2(sum((detail{j}).^Q(nq))) ;
  end
end
if ChooseReg == 1
  
  if isempty(findobj('Tag','graph_reg'))
    figure('Tag','graph_reg')
  else
    figh = findobj('Tag','graph_reg') ; 
    figure(figh) ; %clf
  end
 
  sth=findobj('Tag','StaticText_error');
  set(sth,'String','Press return to end !');
 %b = uicontrol('Parent',gcf,...
%	'FontUnits','pixels', ...
%	'FontSize',12, ...
%	'Units','normalized', ...
%	'FontWeight','bold', ...
%   'ForegroundColor',[0.9 0 0],...
%   'Position',[0.68 0.02 0.25 0.03], ...
%	'String','Press return to end', ...
%	'Style','text', ...
%   'Tag','info');
 
  reg = 1:nscale ;
  reg_log = reg ;
  
  while ~isempty(reg_log)     
    
    figh = findobj('Tag','graph_reg') ;
    figure(figh) ;
    subplot(121) ;
    plot(logscale,logpart,logscale,logpart,'+') , axis tight
    ylabel('Partition function log_2(S_n(q))'), xlabel('log_{2}(scale)')
    
    reg_log = fracginput(2) ; 
    if ~isempty(reg_log)
      reg = find(min(reg_log(1,1),reg_log(2,1)) <= logscale & ...
	  logscale <= max(reg_log(1,1),reg_log(2,1))) ;
    end
    
    for nq = 1:length(Q) 
%      slope = polyfit(reg(:),logpart(reg,nq),1) ;
      
    switch varargin{1}
      case 'ls'
	slope = polyfit(reg(:),logpart(reg,nq),1) ;
      case 'wls'  
	RegWeight = varargin{2}(reg)./sum(varargin{2}(reg)) ;
	slope = monolr(reg(:),logpart(reg,nq),varargin{1},RegWeight) ;

      case {'pls'}
	slope = monolr(reg(:),logpart(reg,nq),varargin{:}) ;

      case {'ml','lapls'}
	slope = monolr(reg(:),logpart(reg,nq),varargin{:}) ;
   
      case {'linf','lsup'}
	slope = regression_elimination(reg(:),logpart(reg,nq),varargin{:}) ;  
    end
      
      
      tau(nq) = slope(1)-Q(nq)/2 ;
    end
    
    % computation of the Legendre spectrum
    
    [f_alpha,alpha] = flt(Q,tau) ;
    subplot(222) 
    plot(alpha,f_alpha) ; title('spectrum') ;
    subplot(224)
    plot(Q,tau) : title('\tau(q)') ; xlabel('q') ;
    
  end

elseif ChooseReg == 0
  reg = 1:nscale ;
elseif length(ChooseReg) > 1
  reg = ChooseReg ;
end

%%%%%
  FigFRAC= findobj ('Tag','FRACLAB Toolbox');
  sth=findobj(FigFRAC,'Tag','StaticText_error');
  set(sth,'String','');
%%%%%
for nq = 1:length(Q) 
  %  slope = polyfit(reg(:),logpart(reg,nq),1) ;
  
  switch varargin{1}
    case 'ls'
      slope = polyfit(reg(:),logpart(reg,nq),1) ;
    case 'wls'  
      RegWeight = varargin{2}(reg)./sum(varargin{2}(reg)) ;
      slope = monolr(reg(:),logpart(reg,nq),varargin{1},RegWeight) ;
      
    case {'pls'}
      slope = monolr(reg(:),logpart(reg,nq),varargin{:}) ;
      
    case {'ml','lapls'}
      slope = monolr(reg(:),logpart(reg,nq),varargin{:}) ;
      
    case {'linf','lsup'}
	slope = regression_elimination(reg(:),logpart(reg,nq),varargin{:}) ;  
  end
  
  tau(nq) = slope(1)-Q(nq)/2 ;
end

% computation of the Legendre spectrum

[f_alpha,alpha] = flt(Q,tau) ;





