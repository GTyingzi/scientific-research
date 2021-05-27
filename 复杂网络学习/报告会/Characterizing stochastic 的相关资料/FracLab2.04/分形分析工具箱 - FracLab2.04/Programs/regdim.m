function [dim,handlefig,a,L,Kreg,R,regX]=regdim(x, sigma, voices, Nmin, Nmax, kernel, reg, graphs, varargin)
%   regdim
%   Estimate the regularization dimension of a 1d or 2d sample.
%   Francois Roueff
%   March 5th 1998
%
%   Computes the regularization dimension of the graph of a 1d or 2d sam-
%   pled function.  Two kernels are available: the Gaussian or the Rectan-
%   gle.
%
%   1.  Usage
%
%   o  Matlab :
%      [dim,
%      handlefig]=regdim(x,sigma,voices,Nmin,Nmax,kernel,mirror,reg,graphs)
%
%   o  Scilab :
%      dim = regdim(x,sigma,voices,Nmin,Nmax,kernel,mirror,reg,graphs)
%
%   1.1.  Input parameters
%
%   o  x : 1d: Real vector [1,nt] or [nt,1] 2d: Real matrix [nt,pt]
%      Time samples of the signal to be analyzed.
%
%   o  sigma : Real positive number
%      Standard Deviation of the noise. Its default value is null
%      (noisefree)
%
%   o  voices : Positive integer.
%      number of analyzing voices.  When not specified, this parameter is
%      set to 128.
%
%   o  Nmin : Integer in  [2,nt/3]
%      Lower scale bound (lower length) of the analysing kernel. When not
%      specified, this parameter is set to 2.
%
%   o  Nmax : Integer in  [Nmin,2nt/3]
%      Upper scale bound (upper length) of the analysing kernel. When not
%      specified, this parameter is set to nt/3.
%
%   o  kernel  : String
%      specifies the analyzing kernel:
%      "gauss": Gaussian kernel (default)
%      "rect": Rectangle kernel
%
%   o  mirror : Boolean
%
%      specifies wether the signal is to be mirrorized for the analyse
%      (default: 0).
%
%   o  reg : Boolean
%
%      specifies wether the regression is to be done by the user or
%      automatically (default: 0).
%
%   o  graphs : Boolean:
%
%      for one dimensional signals, it specifies wether the regularized
%      graphs have to be displayed (default: 0). In two dimensional
%      sugnals and for matlab only, all the regularized samples contours
%      are plotted on a same figure.
%   1.2.  Output parameters
%
%   o  dim : Real
%      Estimated regularization dimension.
%
%   o  handlefig (for Matlab only): Integer vector
%      Handles of the figures opened during the procedure.
%
%   2.  See also:
%
%   cwttrack, cwtspec.
%
%   3.  Examples
%
%   %%Signals synthesis
%   x = GeneWei(1024,0.6,2,1.0,0);
%   z = GeneWei(200,0.6,2,1.0,0);
%   y = GeneWei(200,0.4,3,1.0,0);
%   w = z'*y;
%   %% Signals plot
%   figure(1);
%   plot(x);
%   figure(2);
%   mesh(w);
%   %% Dimensions of the 1d- and 2d-graph with a regression by hand
%   [dim1,H1] = regdim(x,0,64,6,250,'gauss',0,1,1);
%   [dim2,H2] = regdim(w,0,25,10,50,'gauss',0,1);
%   %% Close the figures
%   close(H2);
%   close(H1);
%   close(2);
%   close(1);
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

global alpha
alpha=3;

regX=[];
R=[];
  
narg = nargin ;

if narg<9
  varargin{1}='ls';
end
if narg <8
  graphs = 0;
end
if narg <7
  reg = 0;
end
if narg <6
  kernel = 'gauss';
end

if min(size(x))>1 
  N=min(size(x));
  if narg <4
    Nmin= 5;
  end
  if narg <3
    voices= 16;
  end
  if narg <5
    Nmax= min(max(floor(N/3),Nmin+voices(1)+1),N-1);
  end
  if narg <2
    sigma= 0;
  end
  [dim,handlefig,a,L,Kreg,R,regX]=dimR2D(x,sigma,voices,Nmin,Nmax,kernel,reg,graphs,varargin{:});
  return
end
 
N=length(x);
 
if narg <4
  Nmin= 5;
end
if narg <3
  voices= 128;
end
if narg <5
  Nmax= min(max(floor(N/2),Nmin+voices(1)+1),N-1);
end
if narg <2
  sigma= 0;
end
 
handlefig=[];
  
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vector of kernel sizes: iv
%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(voices)==1
  jmax=voices;
  iv=round(logspace(log10(Nmin),log10(Nmax),jmax));
else
  iv=round(voices);
end
imax=max(iv);
K=find(diff(iv));
iv=[iv(K),imax];
jmax=length(iv);

%%%%%%%%%%%%%%%%%%%%%%%%%%
% prolongation by a constant
%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(x,2)==1
  x=x';
end

x=[x(1)*ones(1,floor(imax/2)),x,x(length(x))*ones(1,floor(imax/2))];
	
%%%%%%%%%%%%%%%%%%
%a:scale
%%%%%%%%%%%%%%%%%
a=[];
L=[];
Lnoisy=[];
R=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot regularized graphs if wanted %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z=[];
if graphs
  for j=1:jmax
    eval(['[z1,a(j)]=' kernel 'conv(x,iv(j));']);
    z1=z1(floor(iv(j)/2)+1+floor(imax/2):N+floor(iv(j)/2)+floor(imax/2));
    z=[z;z1];
  end
  figure
  handlefig=[handlefig gcf];
  plot(z')
  regX=z';
end

for j=1:jmax
  i=round(iv(j));
  eval(['[z1prim,a(j)]=' kernel 'primconv(x,iv(j));']);
  z1prim=z1prim(floor(iv(j)/2)+1+floor(imax/2):N+floor(iv(j)/2)+floor(imax/2));
  dl=abs(z1prim);
  if isempty(dl)
    break;
  end
  if sigma>0
    Lnoisy(j)=mean(dl);
    %%%%%%%%%%%%%
    % signal/noise component rate
    %%%%%%%%%%%%
    s=sigma/sqrt(sqrt(2*pi)*a(j)^3);
    dln=2*s/sqrt(pi).*exp(-(dl.^2)./s^2);
    dlsb=dl-dln;
    R(j)=mean(dln)/Lnoisy(j);
    %%%%%%%%%
    %Corrected unbiased lengths
    %%%%%%%%%
    c=ones(1,i)./i;
    dlsbm=conv(dlsb,c);
    dlsbm=dlsbm(floor(i/2)+1:floor(i/2)+length(dlsb));
    dlsbc=s*sqrt(2)*invfonc(dlsbm./(s*sqrt(2)));
    L(j)=mean(dlsbc);
  else
    L(j)=mean(dl)+N^(-2);
  end
end
[dim, newhfig, Kreg]=reg_dimR(a,L,Lnoisy,R,reg,sigma,handlefig,1,varargin{:});
handlefig=newhfig;



function [dim,handlefig,a,L,Kreg,R,regX]=dimR2D(x,sigma,voices,Nmin,Nmax,kernel,reg,graphs,varargin)

handlefig=[];

[N,P]=size(x);
	
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vector of kernel sizes: iv
%%%%%%%%%%%%%%%%%%%%%%%%%%
if length(voices)==1
  jmax=voices;
  iv=round(logspace(log10(Nmin),log10(Nmax),jmax));
else
  iv=round(voices);
end
imax=max(iv);
K=find(diff(iv));
iv=[iv(K),imax];
jmax=length(iv);

%%%%%%%%%%%%%%%%%%%%%%%%%%
% prolongation by a constant
%%%%%%%%%%%%%%%%%%%%%%%%%%
x=[x(:,ones(1,floor(imax/2))),x,x(:,ones(1,floor(imax/2))*N)];
x=[x(ones(1,floor(imax/2)),:);x;x(ones(1,floor(imax/2))*P,:)];

%%%%%%%%%%%%%%%%%%
%a:scale
%%%%%%%%%%%%%%%%%
a=[];
L=[];
Lnoisy=[];
R=[];regX=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot regularized graphs if wanted %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if graphs
  regX=cell(jmax,1);
  figure
  handlefig=[handlefig gcf];
  hold on
  for j=1:jmax
    eval(['[z1,a(j)]=' kernel '2dconv(x,iv(j));']);
    z1=z1(floor(iv(j)/2)+1+floor(imax/2):N+floor(iv(j)/2)+floor(imax/2),...
	floor(iv(j)/2)+1+floor(imax/2):P+floor(iv(j)/2)+floor(imax/2));
    regX{j}=z1;
    contour(z1);
  end
  hold off
end

for j=1:jmax
  ii=round(iv(j));
  eval(['[dzx,dzy,a(j)]=' kernel '2dprimconv(x,iv(j));']);
  dzx=dzx(floor(iv(j)/2)+1+floor(imax/2):N+floor(iv(j)/2)+floor(imax/2),...
	floor(iv(j)/2)+1+floor(imax/2):P+floor(iv(j)/2)+floor(imax/2));
  dzy=dzy(floor(iv(j)/2)+1+floor(imax/2):N+floor(iv(j)/2)+floor(imax/2),...
	floor(iv(j)/2)+1+floor(imax/2):P+floor(iv(j)/2)+floor(imax/2));
  dlx=abs(dzx);
  dly=abs(dzy);
  dl=dlx+dly;
  if isempty(dl)
    break;
  end
  if sigma >0
    Lnoisy(j)=mean(mean(dl));
    eval(['[dz,a(j)]=' kernel '2dconv1(dzx,dzy,iv(j));']);
    dl=abs(dz);
    LRT=mean(mean(dl));
    %%%%%%%%%%%%%
    % signal/noise component rate
    %%%%%%%%%%%%
    s=sigma/sqrt(sqrt(2*pi)*a(j)^3);
    dln=2*s/sqrt(pi).*exp(-(dl.^2)./s^2);
    %dlnx=2*s/sqrt(pi).*exp(-(dlx.^2)./s^2);
    %dlny=2*s/sqrt(pi).*exp(-(dly.^2)./s^2);
    %dln=dlnx+dlny;
    %dlsbx=dlx-dlnx;
    %dlsby=dly-dlny;
    dlsb=dl-dln;
    R(j)=mean(mean(dln))/LRT;
    %%%%%%%%%
    %Corrected unbiased lengths
    %%%%%%%%%
    %c=ones(1,ii)./ii;
    %dlsbmx=conv2(1,c,dlsbx);
    %dlsbmx=dlsbmx(ii:size(dlsbx,1),ii:size(dlsbx,2));
    %dlsbcx=s*sqrt(2)*invfonc(dlsbmx./(s*sqrt(2)));
    %dlsbmy=conv2(c,1,dlsby);
    %dlsbmy=dlsbmy(ii:size(dlsby,1),ii:size(dlsby,2));
    %dlsbcy=s*sqrt(2)*invfonc(dlsbmy./(s*sqrt(2)));
    %L(j)=mean(mean(dlsbcx))+mean(mean(dlsbcy));
    L(j)=mean(mean(dlsb))*Lnoisy(j)/LRT;
  else
    L(j)=mean(mean(dl))+max([N,P])^(-2);
  end
end

[dim, newhfig, Kreg]=reg_dimR(a,L,Lnoisy,R,reg,sigma,handlefig,2,varargin{:});
handlefig=newhfig;


function g = gauss2d(n,a)

% GAUSS2D      GAUSS2D(N,A) returns the NxN-point Gauss 2d-window.
%            a corresponds to an attenuation of 10^(-a) at the end of the 
%            Gauss window
% Input:     -N number of points in one direction
%            -a dB attenuation. Default value is a = 2.
% Output:    -g time samples of the Gauss window
%
% Example:
%
% See also:
%

if nargin == 1
  a = 2 ;
end

t=(-(n-1)/2:(n-1)/2);
tt=flipud(t');
t2=t(ones(1,n),:)+i*tt(:,ones(1,n));
g = exp(-(a*log(10)/((n-1)/2)^2)*abs(t2).^2);




function [z,a]=gauss2dconv(x,iv);
global alpha;
i=round(iv);
y=gauss2d(i,alpha);
a=(iv-1.0)/(2.0*sqrt(alpha*log(10)));
z=conv2(x,y);
Norm=(a*sqrt(pi))^2;
%Norm=sum(sum(y));
z=z/Norm;
function [z,a]=gauss2dconv1(x,y,iv);
global alpha;
ii=round(iv);
g=gauss(ii,alpha);
a=(ii-1.0)/(2.0*sqrt(alpha*log(10)));
zx=conv2(g,1,x);
zx=zx(floor(ii/2)+1:floor(ii/2)+size(x,1),:);
zy=conv2(1,g,y);
zy=zy(:,floor(ii/2)+1:floor(ii/2)+size(x,2));
z=zx+zy;
Norm=a*sqrt(pi);
%Norm=a/sum(sum(abs(gx)));
%Norm=sum(sum(gauss2d(ii,alpha)));
z=z/Norm;
function [gx,gy]=gauss2dprim(n,alpha)

% GAUSS2DPRIM      GAUSS2DPRIM(N,A) returns the derivative of
%                  NxN-point Gauss 2d-window.
%            a corresponds to an attenuation of 10^(-a) at the end of the 
%            Gauss window
% Input:     -N number of points in one direction
%            -a dB attenuation. Default value is a = 2.
% Output:    -g time samples of the derivative of Gauss window
%
% Example:
%
% See also:
%

if nargin == 1
  alpha = 2 ;
end

a=(n-1)/(2.0*sqrt(alpha*log(10)));

t=(-(n-1)/2:(n-1)/2);
tt=flipud(t');
t2=t(ones(1,n),:)+i*tt(:,ones(1,n));

gx=-2.0*t(ones(1,n),:)./(a^2).*exp(-abs(t2).^2 ./ a^2);
gy=2.0*tt(:,ones(1,n))./(a^2).*exp(-abs(t2).^2 ./ a^2);




function [zx,zy,a]=gauss2dprimconv(x,iv);
global alpha;
ii=round(iv);
gx=gauss(ii,alpha,1);
a=(ii-1.0)/(2.0*sqrt(alpha*log(10)));
zx=conv2(1,gx,x);
zy=conv2(gx,1,x);
Norm=a*sqrt(pi);
%Norm=a/sum(sum(abs(gx)));
%Norm=sum(sum(gauss2d(ii,alpha)));
zx=zx/Norm;
zy=zy/Norm;
function [z,a]=gaussconv(x,iv);
global alpha;
i=round(iv);
y=gauss(i,alpha);
a=(iv-1.0)/(2.0*sqrt(alpha*log(10)));
y=y./(a*sqrt(pi));
z=conv(x,y);
function [z,a]=gaussprimconv(x,iv);
global alpha;
i=round(iv);
yprim=gauss(i,alpha,1);
a=(i-1.0)/(2.0*sqrt(alpha*log(10)));
yprim=yprim./(a*sqrt(pi));
z=conv(x,yprim);
function z=invfonc(x)

z=(sign(x).*sqrt(sqrt(pi)/2*abs(x))+x.^4.*(x+exp(-x.^2)/sqrt(pi).*sign(x)))./(x.^4+1);
function [z,a]=rect2dconv(x,iv);
i=round(iv);
a=(iv-1.0);
y=ones(i,i);
y=y;
z=conv2(x,y);
Norm=iv^2;
z=z/Norm;
function [z,a]=rect2dconv1(x,y,iv);
ii=round(iv);
g=ones(1,ii);
a=(iv-1.0);
zx=conv2(g,1,x);
zx=zx(floor(ii/2)+1:floor(ii/2)+size(x,1),:);
zy=conv2(1,g,y);
zy=zy(:,floor(ii/2)+1:floor(ii/2)+size(x,2));
z=zx+zy;
Norm=iv;
z=z/Norm;
function [zx,zy,a]=rect2dprimconv(x,iv);
[n,p]=size(x);
j=round(iv);
a=(iv-1.0);
zx=[x,zeros(n,j-1)]-[zeros(n,j-1),x];

zy=[zeros(j-1,p);x]-[x;zeros(j-1,p)];

Norm=iv;
zx=zx/Norm;
zy=zy/Norm;
function [z,a]=rectconv(x,iv);
i=round(iv);
a=(iv-1.0);
y=ones(1,i);
y=y./iv;
z=conv(x,y);
function [z,a]=rectprimconv(x,iv);
i=round(iv);
a=(i-1.0);
z=[x,zeros(1,i-1)]-[zeros(1,i-1),x];
z=z/iv;

function [dim, newhfig,Kreg]=reg_dimR(a,L,Lnoisy,R,reg,sigma,hfig,d,varargin);

handlefig=hfig;
  
I=find(L>0);
if length(I)<2
  disp('Choose a wider range or more voices: could not make any regression.')
  dim=NaN;
  newhfig=handlefig;
  return;
end
la=log(a(I));
lL=log(L(I));

if sigma>0
  J=find((R(I)>0)&(R(I)<0.5));
  if length(J)<2
    warning('The regression is done in an area where the noise prevalence ratio is upper than 0.5 (log10(NPR) > -0.3)');
    J=[length(I)-1,length(I)];
  end
  Kreg=J;
else
  Kreg=[1:length(la)];
end

if length(Kreg)<3
  varargin=cell(1,1);
  varargin{1}='ls';
end;

switch varargin{1}
  case  'wls'  
    RegWeight = varargin{2}(Kreg)./sum(varargin{2}(Kreg)) ;
    [a_hat]=monolr(la(Kreg),lL(Kreg),varargin{1},RegWeight);
  case  'linf'
     %[a_hat,b_hat]=regression3(la(Kreg),lL(Kreg));
     [a_hat,b_hat]=regression_elimination(la(Kreg),lL(Kreg),'linf');
  case  'lsup'
     %[a_hat,b_hat]=regression4(la(Kreg),lL(Kreg));
     [a_hat,b_hat]=regression_elimination(la(Kreg),lL(Kreg),'lsup');
  otherwise
    [a_hat]=monolr(la(Kreg),lL(Kreg),varargin{:});
end

dim=d-a_hat(1);

if reg
	[dim,handlefig]=fl_regression(la(Kreg),lL(Kreg),[num2str(d) '-a_hat'],'RegularizationDimension',reg,varargin{:});
end

newhfig=handlefig;

% if reg
%   if sigma>0
%     J=find(R>0);
%     figure
%     set(gcf,'Units','normalized','Position',[0.232 0.200 0.660 0.75])
%     handlefig=[handlefig gcf];
%     subplot(2,1,1)
%     plot(log(a(J)),log10(R(J)),'k')
%     title('Noise Prevalence Ratio')
%     xlabel('Log(scale)');
%     ylabel('Log10(NPR)');
%     gridreturn
%     
%   else
%     figure
%     set(gcf,'Units','normalized','Position',[0.232 0.200 0.660 0.75])
%     handlefig=[handlefig gcf];
%     subplot(2,1,1)
%     diffL=diff(lL);
%     diffa=diff(la);
%     newa=la(2:length(la));
%     J=find(diffa);
%     dLdarate=diffL(J)./diffa(J);
%     newa=newa(J);
%     plot(newa,dLdarate,'ko');
%     title('Increments \Delta log(L)');
%     xlabel('Log(scale)');
%     ylabel('\Delta Log(L)');
%     grid;
%  end
%  b = uicontrol('Parent',gcf,...
% 	'Units','normalized', ...
% 	'FontUnits','pixels', ...
% 	'FontSize',12, ...
% 	'FontWeight','bold', ...
%    'ForegroundColor',[0.9 0 0],...
%    'Position',[0.68 0.02 0.25 0.03], ...
% 	'String','Press return to end', ...
% 	'Style','text', ...
%    'Tag','info');
% 
%   X=[min(la(Kreg)),max(la(Kreg))];
%   while length(X)==2
%     subplot(2,1,2)
%     if sigma>0
%       J=find(R>0);
%       plot(la,lL,'*r',log(a(J)),log(Lnoisy(J)),'ko')
%       xlabel('Log(scale)');
%       ylabel('Log(L)');
%       grid
%     else
%       plot(la,lL,'ok')
%       xlabel('Log(scale)');
%       ylabel('Log(L)');
%       grid
%     end
%     Kreg=find((la>=min(X))&la<=max(X));
%     if length(Kreg)<2
%       title('Choose a wider regression range')
%       dim=NaN;
%     else
%       if length(Kreg)<3
% 	varargin=cell(1,1);
% 	varargin{1}='ls';
%       end;
%       switch varargin{1}
% 	case  'wls'  
% 	  RegWeight = varargin{2}(Kreg)./sum(varargin{2}(Kreg)) ;
%      [a_hat,b_hat]=monolr(la(Kreg),lL(Kreg),varargin{1},RegWeight);
%    case  'linf'
%       %[a_hat,b_hat]=regression3(la(Kreg),lL(Kreg));
%       [a_hat,b_hat]=regression_elimination(la(Kreg),lL(Kreg),'linf');
%    case  'lsup'
%       %[a_hat,b_hat]=regression4(la(Kreg),lL(Kreg));
%       [a_hat,b_hat]=regression_elimination(la(Kreg),lL(Kreg),'lsup');
% 	otherwise
% 	  [a_hat,b_hat]=monolr(la(Kreg),lL(Kreg),varargin{:});
%       end
%       hold on;plot(la(Kreg),polyval([a_hat(1),b_hat(1)],la(Kreg)),'r');hold off;
%       dim=d-a_hat(1); 
%       title(['Estimated Regularization Dimension = ',num2str(dim)]);
%     end
%     [X Y]=fracginput(2);
%   end
% end
% newhfig=handlefig;