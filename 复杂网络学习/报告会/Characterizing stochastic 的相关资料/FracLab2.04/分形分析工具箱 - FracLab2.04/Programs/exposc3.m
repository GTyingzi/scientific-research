function [H, H_osc, a, regab, logosc] = exposc3(x,base,rmin,rmax,RegParam,timeinstant)
%   exposc3
%   Pointwise Holder exponent based on oscillation method
%   Olivier Barrière
%   January 2006
%
%   Estimates the the Holder function of a 1-D signal using the oscillation method
%
%   1.  Usage
%
%   ______________________________________________________________________
%   H = exposc3(x,base,rmin,rmax,RegParam[,timeinstant])
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  x : Real vector [1,N]
%      1-D signal
%
%   o  Base :  Real in [0,infinity]
%      Base size of the oscillation neighboorhoods : from base^rmin to base^rmin
%
%   o  rmin :  Positive integer
%      Minimum value of rho for the oscillation neighboorhoods  : from base^rmin to base^rmin
%
%   o  rmax :  Positive integer
%      Maximum value of rho for the oscillation neighboorhoods  : from base^rmin to base^rmin
%
%   o  RegParam :  String
%      Type of the regression {'ls', 'linf' ...}
%
%   o  timeinstant :  Positive integer in [1,N]
%      If provided, the Holder exponent is only computed at this time
%      else, the whole Holder function is estimated
%
%   
%
%   1.2.  Output parameters
%
%   o  H : Real vector [1,N]
%      Estimator of the Holder function
%
%
%   2.  See also:
%
%   estimGQV1DH, DWTestim_all
%
%   3.  Examples
%
%   % signal synthesis
%   N=1024; t=linspace(0,1,N); Ht=eval('0.5+0.3*sin(4*pi*t)');
%   mBm0=mBmQuantifKrigeage(N,10,Ht,1,1);
%   %estimation
%   H = exposc3(mBm0,2.1,1,10,'ls');

%typical parameters :
%base=2.1
%rmin=1 to 3, rmax=7 to 10

nb_zones = 10;

if nargin<5
    RegParam={'ls'};
end
if nargin<6
    timeinstant = 0;
end

n = length(x);
if timeinstant ~= 0
	 for rho = rmin:rmax
			ray(rho-rmin+1) = (base^rho)/n;
			larg(rho-rmin+1) = 1+2*round(base^rho);
			i = timeinstant;
			osc(rho-rmin+1) = max(x(max(1,i-round(base^rho)):min(n,i+round(base^rho))))-min(x(max(1,i-round(base^rho)):min(n,i+round(base^rho))));
	end
	
	H=fl_regression(log(larg),log(osc),'a_hat','PointwiseHolderExponentOscillations',2,RegParam{:});

else
	osc = zeros(n,rmax-rmin+1);
	
	h_waitbar = fl_waitbar('init');
	
	for rho = rmin:rmax
			fl_waitbar('view',h_waitbar,rho/2,rmax-rmin+1);
			ray(rho-rmin+1) = (base^rho)/n;
			larg(rho-rmin+1) = 1+2*round(base^rho);
			for i = 1:n
					osc(i,rho-rmin+1) = max(x(max(1,i-round(base^rho)):min(n,i+round(base^rho))))-min(x(max(1,i-round(base^rho)):min(n,i+round(base^rho))));
			end
	end
	
	%regab=linspace(rmin,rmax,rmax-rmin+1),
	%larg
  osc(osc==0)=exp(1); %pour ne pas avoir de log(0) => régularité =1...
	regab = log(larg);
	logosc = log(osc);
	logray = log(ray);
	for i=1:length(logray)
			H_osc(:,i) = logosc(:,i)/logray(i);
	end
	H_osc_mean = nanmean(H_osc,2);


	a = zeros(1,n);
	for i = 1:n
	   fl_waitbar('view',h_waitbar,1/2*n+i/2, n);
	   %a1 = polyfit(regab,logosc(i,:),1);%newnewreg(regab,logosc(i,:),'linf',0,0,0);
	   %a(1,i) = a1(1);
	   a(1,i) = fl_monolr(regab,logosc(i,:),RegParam{:});
	end
	
	%large = (((n/3)/2)^(1/rmax))/base;
	large= 1;
	elarg = 1+2*round((large*base)^rmax);
	%H = zeros(1,n);
	
	%for i=1:n
	%	v_large(1) = max(1,i-round((large*base)^rmax));
	%	v_large(2) = min(n,i+round((large*base)^rmax));
	%	
	%	moy_a = nanmean(a(v_large(1):v_large(2)));
	%	moy_H_osc_mean = nanmean(H_osc_mean(v_large(1):v_large(2)));
	%
	%	H(i)=H_osc_mean(i)-moy_H_osc_mean+moy_a;
	%end
	
	%v_large(1,1) = 1;
	%v_large(2,1) = min(n,1+round((large*base)^rmax));
	%
	%sum_a(1) = nansum(a(v_large(1,1):v_large(2,1)));
	%moy_a(1) = sum_a(1)/(v_large(2,1)-v_large(1,1)+1-sum(isnan(a(v_large(2,1):v_large(1,1)+1))));
	%sum_H_osc_mean(1) = nansum(H_osc_mean(v_large(1,1):v_large(2,1)));
	%moy_H_osc_mean(1) = sum_H_osc_mean(1)/(v_large(2,1)-v_large(1,1)+1-sum(isnan(H_osc_mean(v_large(2,1):v_large(1,1)+1))));
	%
	%for i=2:n
	%	fl_waitbar('view',h_waitbar,2/3*(n-1)+i/3, n-1);
	%	
	%	v_large(1,2) = max(1,i-round((large*base)^rmax));
	%	v_large(2,2) = min(n,i+round((large*base)^rmax));
	%
	%	sum_a(i) = sum_a(i-1)+nansum(a(v_large(2,1)+1:v_large(2,2)))-nansum(a(v_large(1,1):v_large(1,2)-1));
	%	moy_a(i) = sum_a(i)/(v_large(2,1)-v_large(1,1)+1-sum(isnan(a(v_large(2,1):v_large(1,1)+1))));
	%	sum_H_osc_mean(i) = sum_H_osc_mean(i-1)+nansum(H_osc_mean(v_large(2,1)+1:v_large(2,2)))-nansum(H_osc_mean(v_large(1,1):v_large(1,2)-1));
	%	moy_H_osc_mean(i) = sum_H_osc_mean(i)/(v_large(2,1)-v_large(1,1)+1-sum(isnan(H_osc_mean(v_large(2,1):v_large(1,1)+1))));
	%	
	%	v_large(1,1) = v_large(1,2);
	%	v_large(2,1) = v_large(2,2);
	%	
	%end		
	
  moy_H_osc_mean = fl_tendance(H_osc_mean,nb_zones)';
  moy_a = fl_tendance(a,nb_zones)';
	
  H=H_osc_mean-moy_H_osc_mean+moy_a;

	fl_waitbar('close',h_waitbar);
end
