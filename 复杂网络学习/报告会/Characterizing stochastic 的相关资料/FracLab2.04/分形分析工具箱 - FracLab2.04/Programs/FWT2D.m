function [wt,wti,wtl,N]=FWT2D(varargin)

%   FWT2D
%   2D Forward Disrete Wavelet Transform
%   Bertrand Guiheneuf
%   01 June 1997
%
%   This routine computes discrete wavelet transforms of a 2D real signal.
%   Two transforms are possible : Orthogonal and Biorthogonal
%
%   1.  Usage
%
%   [wt,index,length]=FWT2D(Input,NbIter,f1,[f2])
%
%   1.1.  Input parameters
%
%   o  Input : real matrix [m,n]
%      Contains the signal to be decomposed.
%
%   o  NbIter : real positive scalar
%      Number of decomposition Levels
%
%   o  f1 : Analysis filter
%
%   o  f2 : real unidimensional matrix [m,n]
%      Synthesis filter
%
%   1.2.  Output parameters
%
%   o  wt : real matrix
%      Wavelet transform. Contains all the datas of the decomposition.
%
%   o  index : real matrix [NbIter,4]
%      Contains the indexes (in wt) of the projection of the signal on the
%      multiresolution subspaces
%
%   o  length : real matrix [NbIter,2]
%      Contains the dimensions of each projection
%
%   2.  Examples
%
%   a=rand(256,256);
%   q=MakeQMF('daubechies',4);
%   wt,wti,wtl = FWT2D(a,3,q);
%   V=WT2Dext(wt,1,2);
%   viewmat(V);
%
%   Then to suppress the Lowest Frequency component and then
%   reconstruction:
%
%   index=0;
%   for i=1:wtl(3,1),
%   for j=1:wtl(3,2),
%   wt(wti(3,4)+index)=0;
%   end;
%   end;
%   result=IWT2D(wt);
%
%   3.  See Also
%
%   IWT2D, MakeQMF, MakeCQF, WT2Dext, WT2DVisu, WT2DStruct
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



global N
[x,y]=size(varargin{1});
nx=log2(x);
ny=log2(y);
N=[x,y];

if nx==floor(log2(x)) & ny==floor(log2(y));
   in1=varargin{1};
   n1=min(nx,ny);
elseif nx==floor(log2(x))
   in1=zeros(x,2^(floor(log2(y))+1));
   in1(1:x,1:y)=varargin{1}(1:x,1:y);
   n1=min(x,floor(ny)+1);
elseif  ny==floor(log2(y));
   in1=zeros(2^(floor(log2(x))+1),y);
   in1(1:x,1:y)=varargin{1}(1:x,1:y);
   n1=min(floor(nx)+1,y);
else 
   in1=zeros(2^(floor(log2(x))+1),2^(floor(log2(y))+1));
   in1(1:x,1:y)=varargin{1}(1:x,1:y);
   n1=min(floor(nx)+1,floor(ny)+1);
end 



if nargin==4
   [wt,wti,wtl]= DWT2D(in1,varargin{2},varargin{3},varargin{4});
end 

if nargin==3
   [wt,wti,wtl]= DWT2D(in1,varargin{2},varargin{3});
end

if nargin==2
   [wt,wti,wtl]= DWT2D(in1,varargin{2});
end

if nargin==1
   [wt,wti,wtl]= DWT2D(in1);
end