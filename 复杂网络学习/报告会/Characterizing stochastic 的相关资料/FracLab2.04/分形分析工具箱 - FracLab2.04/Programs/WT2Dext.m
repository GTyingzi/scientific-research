function V=WT2Dext(wt,Sc,Num)
%   WT2Dext
%   Extract a Projection from a 2D WT
%   Bertrand Guiheneuf
%   01 June 1997
%
%   This routine extracts a projection from the wavelet transform of a 2D
%   matrix.
%
%   1.  Usage
%
%   [V]=WT2Dext(wt, Scale, Num)
%
%   1.1.  Input parameter
%
%   o  wt : real unidimensional matrix [m,n]
%      Contains the wavelet transform (obtained with FWT2D).
%
%   o  w Scale : real scalar Contains the scale level of the projection to
%      extract.
%
%   o  w Num : real scalar Contains the number of the output to extract in
%      level Scale (between 1 and 4)
%
%   1.2.  Output parameter
%
%   o  V : real matrix [m,n]
%      Contains the  matrix to be visualized directly
%
%   2.  See Also
%
%   FWT2D, IWT2D, WT2DVisu,
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

	[wti, wtl]=WT2DStruct(wt);
	V=zeros(wtl(Sc,1), wtl(Sc,2));
 	index=0;
	for i=0:(wtl(Sc,1)-1);
		for j=0:(wtl(Sc,2)-1);
			V(i+1,j+1)=wt(wti(Sc,Num)+index);
			index = index+1;
		end;
	end;
