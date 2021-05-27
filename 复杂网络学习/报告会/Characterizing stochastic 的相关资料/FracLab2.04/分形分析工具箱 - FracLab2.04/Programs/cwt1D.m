%   cwt
%   Continuous Wavelet Transform
%   Bertrand Guiheneuf
%   12 February 1997
%
%   This routine computes the continuous wavelet transform of a real sig-
%   nal. Two wavelets are available: the Mexican Hat or the Morlet
%   Wavelet.
%
%   1.  Usage
%
%   [wt,scales,freqs]=cwt(sig,fmin,fmax,nbscales,[wvlt_length])
%
%   1.1.  Input parameters
%
%   o  sig : real vector [1,n] or [n,1]
%      Contains the signal to be decomposed.
%
%   o  fmin : real positive scalar
%      Lowest frequency of the wavelet analysis
%
%   o  fmax : real positive scalar
%      Highest frequency of the wavelet analysis
%
%   o  nbscales : integer positive scalar
%      Number of scales to compute between the lowest and the highest
%      frequencies.
%
%   o  wvlt_length : real positive scalar (optionnal)
%      If equal to 0 or not specified, the wavelet is the Mexican Hat and
%      its length is automaticaly choosen. Otherwise, Morlet's wavelet is
%      used and it's length at scale 1 is given by wvlt_length
%
%   1.2.  Output parameters
%
%   o  wt : complex matrix [nbscales,n]
%      Wavelet transform. The first line is the finer scale ( scale 1 ).
%      It is real if the Mexican Hat has been used, complex otherwise.
%
%   o  scales : real vector [1,nbscales]
%      Scale corresponding to each line of the wavelet transform.
%
%   o  freqs : real vector [1,nbscales]
%      Frequency corresponding to each line of the wavelet transform.
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

