function [sigsynt,Cinew,marks,lambdais,count] = wsamod(sig,seuil,nbscales,filter,param,cmin,cmax) 
%   wsamod
%   Weakly Self Affine Functions : analysis and synthesis
%   Khalid Daoudi
%   June 6th 1997
%
%   Peforms the analysis and synthesis of a 1-D real signal using WSA
%   functions.
%
%   1.  Usage
%
%   [sigsynt,lambdais] = wsamod(sig,[epsilon,NbIter,wavename,waveparam])
%
%   1.1.  Input parameters
%
%   o  sig : Real matrix
%      Contains the original signal
%
%   o  epsilon : Real scalar
%      Specifies the maximal error desied on the Ci's approximation.
%
%   o  NbIter : real positive scalar
%      Number of decomposition Levels to compute
%
%   o  wavename : characters string
%      Wavelet name (Daubechies or Coiflet).
%
%   o  waveparam :
%      Parameter of the chosen wavelet.
%
%   1.2.  Output parameters
%
%   o  sigsynt : Real matrix
%      Contains the synthetic signal
%
%   o  L : Real matrix
%      Containing the lambda_i's. The first two columns contain resp.  the
%      left and the right lambda_i's corresponding to the the first
%      segmented part of the signal and so on.
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

N = length(sig) ;
J = floor(log(N)/log(2));
test = 2^J;
if(N > (test + test/2))
	for n=N+1:2*test,
		sig(n) = 0 ;
	end
	N =2*test;
elseif (N>test)
	sig = sig(1:test);
	N = test ;
end
if nargin == 1
	seuil = 10 ;
	nbscales = floor(log(N)/log(2) -1) ;
	filter = 'daubechies' ;
	param = 4 ;
	cmin = 0.1 ;
	cmax = 1;
end
if nargin == 2
	nbscales = log(N)/log(2) -1 ;
	filter = 'daubechies' ;	
	param = 4 ;
	cmin = 0.1 ;
	cmax = 1;
end
if nargin == 3
	filter = 'daubechies' ;	
	param = 4 ;
	cmin = 0.1 ;
	cmax = 1;
end
if nargin == 4
	param = 4 ;
	cmin = 0.1 ;
	cmax = 1;
end
if nargin == 5
	cmin = 0.1 ;
	cmax = 1;
end
if nargin == 6
	cmax = 1;
end

qmf=MakeQMF(filter, param);
[wt,sc_idx,sc_lg] = FWT(sig, nbscales,qmf);
[Ci Ci_idx Ci_lg] = wave2gifs(wt,sc_idx,sc_lg,2,0,2) ;
[Ci_new1,M1,L1] = gifseg(Ci,.501,cmax,seuil) ;
[Ci_new2,M2,L2] = gifseg(Ci_new1,cmin,.5,seuil) ;
[Ci_new3,M3,L3,count] = gifseg(Ci_new2,cmin,cmax,seuil) ;
wt_new = gifs2wave(Ci_new3,wt,sc_idx,sc_lg) ;
sigsynt = IWT(wt_new) ;
lambdais = L3 ;
L = lambda(lambdais);
marks = M3 ;
Cinew = Ci_new3 ;
visures(sig,sigsynt,marks) ;
