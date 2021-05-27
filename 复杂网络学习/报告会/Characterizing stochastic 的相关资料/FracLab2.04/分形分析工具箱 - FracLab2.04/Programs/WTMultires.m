function [Multires]=WTMultires(WT)
%   WTMultires
%   Construct a 1D Multiresolution Representation
%   Bertrand Guiheneuf
%   01 June 1997
%
%   This routine constructs a matrix that shows the projections of the
%   signal on each multiresolution subspace
%
%   1.  Usage
%
%   [V]=WTMultires(wt)
%
%   1.1.  Input parameter
%
%   o  wt : real unidimensional matrix
%      Contains the wavelet transform (obtained with FWT).
%
%   1.2.  Output parameter
%
%   o  V : real matrix [Nbiter,n]
%      Contains the projections on the Multiresolution. Each line is a
%      projection on a subspace different "low-pass" space Vj
%
%   2.  See Also
%
%   FWT, IWT, WTStruct,
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

	NbSc = WTNbScales(WT);
	SignalSize = WTOrigSize(WT);
	Multires = zeros(NbSc, SignalSize);

	for Sc=1:NbSc,
		a=zeros(1,Sc-1);
		b=zeros(1,NbSc-Sc+2)+1;
		c = [a b];
		WT2 = WTMultScales(WT,c);
		Multires(Sc,:) = IWT(WT2);
	end,
   %%%%%%%%%%%%%%%%%%%%
   %[x,y]=size(Multires);
   %log2y=floor(log2(y));
   %y2=2^log2y;
   %Multires=Multires(:,1:y2);
   
