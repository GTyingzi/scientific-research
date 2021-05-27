function [V]=WT2DVisu(wt)
%   WT2DVisu
%   Visualise a 2D Multiresolution
%   Bertrand Guiheneuf
%   01 June 1997
%
%   This routine constructs a matrix that shows all the wavelet coeffi-
%   cients of a 2D matrix.
%
%   1.  Usage
%
%   [V]=WT2DVisu(wt)
%
%   1.1.  Input parameter
%
%   o  wt : real unidimensional matrix [m,n]
%      Contains the wavelet transform (obtained with FWT2D).
%
%   1.2.  Output parameter
%
%   o  V : real matrix [m,n]
%      Contains a matrix to be visualized directly
%
%   2.  See Also
%
%   FWT2D, IWT2D, WT2Dext,
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

NbScales = WT2DNbScales(wt);
[wti, wtl] = WT2DStruct(wt);

TotalWidth = 0;
TotalHeight = 0;

bigger = max(max(abs(wt(wti(1,1):(wti(NbScales,4)-1)))));

for Sc=1:NbScales;
  TotalHeight = TotalHeight + wtl(Sc,1); 
  TotalWidth = TotalWidth +wtl(Sc,2); 
end;
TotalHeight = TotalHeight + wtl(NbScales,1);
TotalWidth = TotalWidth +wtl(NbScales,2);
	      
V=zeros(TotalHeight,TotalWidth);

m=TotalHeight;
n=TotalWidth;

%wti,wtl,NbScales,
long=length(wt);
%(wti(1,NbScales-1):wti(1,NbScales)-1);%c(1)={[wt(wti(n,1):wti(n,n-nn))]};
%wti(1,1):wti(1,2)
[x,y]=size(wti);%wti,wtl,floor((sqrt(long-wti(1)+1))/2^(NbScales)),-wti(x,y)+length(wt)
[xl,yl]=size(wtl);
%V(1:floor((sqrt(long-wti(1)+1))/2^(NbScales)) , 1:floor((sqrt(long-wti(1)+1))/2^(NbScales))) = reshape(abs(wt(wti(x,y):length(wt))), floor((sqrt(long-wti(1)+1))/2^(NbScales)),floor((sqrt(long-wti(1)+1))/2^(NbScales)));
V(1:wtl(xl,1) , 1:wtl(xl,2)) = reshape(abs(wt(wti(x,y):length(wt))),wtl(xl,1),wtl(xl,2) );
for Sc=1:NbScales;
  
  h=wtl(Sc,1);
  w=wtl(Sc,2);
  sz=h*w;
  
  m=m-h;
  n=n-w;
  
  
  V(m:(m+h-1) , 1:(1+w-1)) = reshape(abs(wt(wti(Sc,1) : ...
      (wti(Sc,1)+sz-1) )), h,w);
  V(m:(m+h-1) , n:(n+w-1)) = reshape(abs(wt(wti(Sc,2) : ...
      (wti(Sc,2)+sz-1) )), h,w);
  V(1:(1+h-1) , n:(n+w-1)) = reshape(abs(wt(wti(Sc,3) : ...
      (wti(Sc,3)+sz-1) )), h,w);
  
  
  %index=0;
  %for i=0:(wtl(Sc,1)-1);
  %for j=0:(wtl(Sc,2)-1);
  
  %V(n+i,1+j) = wt(wti(Sc,1)+index);
  %V(n+i,n+j) = wt(wti(Sc,2)+index);
  %V(1+i,n+j) = wt(wti(Sc,3)+index);
  %index=index+1;
  %end;
  %end;
  
end;

%index=0;
%Sc=NbScales;
%for i=0:(wtl(Sc,1)-1);
%for j=0:(wtl(Sc,2)-1);

%V(1+i,1+j) = wt(wti(Sc,4)+index);
%index=index+1;
%end;
%end;
%V

