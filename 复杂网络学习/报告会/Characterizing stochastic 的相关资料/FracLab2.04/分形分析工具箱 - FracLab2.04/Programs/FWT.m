function [wt,wti,wtl,N]=FWT(varargin)
%   FWT
%   1D Forward Discrete Wavelet Transform
%   Bertrand Guiheneuf
%   01 June 1997
%
%   This routine computes discrete wavelet transforms of a 1D real signal.
%   Two transforms are possible : Orthogonal and Biorthogonal
%
%   1.  Usage
%
%   [wt,index,length]=FWT(Input,NbIter,f1,[f2])
%
%   1.1.  Input parameters
%
%   o  Input : real matrix [1,n] or [n,1]
%      Contains the signal to be decomposed.
%
%   o  NbIter : real positive scalar
%      Number of decomposition Levels to compute
%
%   o  f1 : Analysis filter
%
%   o  f2 : real unidimensional matrix [m,n]
%      Synthesis filter. Useful only for biorthogonal transforms. If not
%      precised, the filter f1 is used for the synthesis.
%
%   1.2.  Output parameters
%
%   o  wt : real matrix
%      Wavelet transform. Contains the wavelet coefficients plus other
%      informations.
%
%   o  index : real matrix [1,NbIter+1]
%      Contains the indexes (in wt) of the projection of the signal on the
%      multiresolution subspaces
%
%   o  length : real matrix [1,NbIter+1]
%      Contains the dimension of each projection
%
%   2.  Examples
%
%   a=rand(1,250);
%   q=MakeQMF('daubechies',4);
%   wt,wti,wtl = FWT(a,6,q);
%   M=WTMultires(wt);
%   plot(M(2,:));
%
%   Then to suppress the Lowest Frequency component and then
%   reconstruction:
%
%   for i=1:wtl(6),
%   wt(wti(6)+i-1)=0;
%   end;
%   result=IWT(wt);
%
%   3.  See Also
%
%   IWT, MakeQMF, MakeCQF, WTStruct, WTNbScales, WTMultires
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
% concerning the use of the Software (e-mail : FracLab@inria.fr)
% 
% This file is part of FracLab, a Fractal Analysis Software
global N
N=length(varargin{1});
n=log2(N);

if n==floor(log2(N));
   in1=varargin{1};
   n1=n;
else
   in1=zeros(1,2^(floor(log2(N))+1));
   in1(1:length(varargin{1}))=varargin{1}(1:length(varargin{1}));
   n1=floor(log2(length(varargin{1})))+1;
end 

% [wt0,wti0,wtl0]= DWT1D(varargin{1},varargin{2},varargin{3});
% k=length(wt0);


if nargin==4
   [wt,wti,wtl]= DWT1D(in1,varargin{2},varargin{3},varargin{4});
end 

if nargin==3
   [wt,wti,wtl]= DWT1D(in1,varargin{2},varargin{3});
end

if nargin==2
   [wt,wti,wtl]= DWT1D(in1,varargin{2});
end

if nargin==1
   [wt,wti,wtl]= DWT1D(in1);
end
