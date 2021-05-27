function visures(sig,sigsynt,marks)
%   visures
%   Khalid Daoudi
%   June 6th 1997
%
%   Plots the the original signal and the synthetic one with the segmenta-
%   tion marks.
%
%   1.  Usage
%
%   h = visures(sig,sigsynt,marks)
%
%   1.1.  Input parameters
%
%   o  sig : Real matrix
%      Contains the original signal
%
%   o  sigsynt : Real matrix
%      Contains the synthetic signal
%
%   o  marks : Real vector
%      Contains the segmentation marks.
%
%   1.2.  Output parameters
%
%   o  h : Real scalar
%      A handle to a figure object
%
%   2.  See also:
%
%   hist, wave2gifs.
%
%   3.  Example:
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

M = sigsynt(marks) ;
N = length(sig);
%sizesig = size(sig);
%if(sizesig(1) ~= 1)
%	sig=sig';
%end
t = (1:N);
figure('Tag','graph_segment')
% figure;
plot(t,sig,'b',t,sigsynt,'g',marks,M,'r+');
	
