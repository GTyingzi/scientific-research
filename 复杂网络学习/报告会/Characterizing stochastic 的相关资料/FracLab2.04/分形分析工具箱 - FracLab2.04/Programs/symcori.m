function Ss = symcori(S)
%   symcori
%   Symmetrization of a periodic 2D correlation field
%   B. Pesquet-Popescu (ENS-Cachan)
%   February 20th 1998
%
%   Symmetrization of a periodic 2D correlation field
%
%   1.  Usage
%
%   ______________________________________________________________________
%   Ss = symcori(S) ;
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o   S  : Matrix [N/2+1 , N]
%      Periodic 2D correlation field S(1:N/2+1,1:N) of a complex 2D NxN
%      field. Values of S(1,N/2+2:N) may be arbitrary.
%
%   1.2.  Output parameters
%
%   o   Ss  :  Matrix [N , N]
%      Symetrized correlation field
%
%   2.  See also:
%
%   synth2, strfbm
%
%   3.  Example:
%
%   4.  Examples
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

N = size(S,2);
if size(S,1) ~= N/2+1
   error('Incorrect dimensions of original field')
end

Ss = S;
% Checking for the symmetries in the original field
ind = N/2+1:N-1;
Ss(1,ind+1) = (conj(Ss(1,N-ind+1))+Ss(1,ind+1))/2;
Ss(1,N-ind+1) = conj(Ss(1,ind+1));
Ss(N/2+1,ind+1) = (conj(Ss(N/2+1,N-ind+1))+Ss(N/2+1,ind+1))/2;
Ss(N/2+1,N-ind+1) = conj(Ss(N/2+1,ind+1));

% Symmetrization
Ss(ind+1,1) = conj(S(N-ind+1,1));
ind2 = 1:N-1;
Ss(ind+1,ind2+1) = conj(S(N-ind+1,N-ind2+1));

