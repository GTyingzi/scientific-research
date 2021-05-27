%   binom
%   binomial measure synthesis
%   Christophe Canus
%   July 5th 1997
%
%   This C_LAB routine synthesizes a large range of pre-multifractal mea-
%   sures related to the binomial measure paradigm (deterministic, shuf-
%   fled, pertubated, and mixing of two binomials: lumping and sum) and
%   computes linked theoretical functions (partition sum function, Reyni
%   exponents function, generalized dimensions, multifractal spectrum).
%
%   1.  Usage
%
%   [varargout,[optvarargout]]=binom(p0,str,varargin,[optvarargin])
%
%   1.1.  Input parameters
%
%   o  p0 : strictly positive real scalar
%      Contains the weight of the binomial.
%
%   o  str : string
%      Contains the type of ouput.
%
%   o  varargin : variable input argument
%      Contains the variable input argument.
%
%   o  optvarargin : optional variable input arguments
%      Contains optional variable input arguments.
%
%   1.2.  Output parameters
%
%   o  varargout : variable output argument
%      Contains the variable output argument.
%
%   o  optvarargout : optional variable output argument
%      Contains an optional variable output argument.
%
%   2.  Examples
%
%   2.1.  Matlab
%
%   ______________________________________________________________________
%
%   p0=.2;
%   n=10;
%   % synthesizes a pre-multifractal binomial measure
%   [mu_n,I_n]=binom(p0,'meas',n);
%   plot(I_n,mu_n);
%
%   % synthesizes the cdf of a pre-multifractal shuffled binomial measure
%   F_n=binom(p0,'shufcdf',n);
%   plot(I_n,F_n);
%
%   e=.19;
%   % synthesizes the pdf of a pre-multifractal pertubated binomial measure
%   p_n=binom(p0,'pertpdf',n,e);
%   plot(I_n,p_n);
%
%   vn=[1:1:8];
%   q=[-5:.1:+5];
%   % computes the partition sum function of a binomial measure
%   znq=binom(p0,'part',vn,q);
%   plot(-vn*log(2),log(znq));
%
%   % computes the Reyni exponents function of a binomial measure
%   tq=binom(p0,'Reyni',q);
%   plot(q,tq);
%
%   N=200;
%   q0=.4;
%   % computes the multifractal spectrum of the lumping of two binomial measures
%   [alpha,f_alpha]=binom(p0,'lumpspec',N,q0);
%   plot(alpha,f_alpha);
%   ______________________________________________________________________
%
%   2.2.  Scilab
%
%   ______________________________________________________________________
%
%   p0=.2;
%   n=10;
%   // synthesizes a pre-multifractal binomial measure
%   [mu_n,I_n]=binom(p0,'meas',n);
%   plot(I_n,mu_n);
%
%   // synthesizes the cdf of a pre-multifractal shuffled binomial measure
%   F_n=binom(p0,'shufcdf',n);
%   plot(I_n,F_n);
%
%   e=.19;
%   // synthesizes the pdf of a pre-multifractal pertubated binomial measure
%   p_n=binom(p0,'pertpdf',n,e);
%   plot(I_n,p_n);
%   xbasc();
%
%   vn=[1:1:8];
%   q=[-5:.1:+5];
%   // computes the partition sum function of a binomial measure
%   znq=binom(p0,'part',vn,q);
%   mn=zeros(max(size(q)),max(size(vn)));
%   for i=1:max(size(q))
%      mn(i,:)=-vn*log(2);
%   end
%   plot2d(mn',log(znq'));
%
%   // computes the Reyni exponents function of a binomial measure
%   tq=binom(p0,'Reyni',q);
%   plot(q,tq);
%
%   N=200;
%   q0=.4;
%   // computes the multifractal spectrum of the lumping of two binomial measures
%   [alpha,f_alpha]=binom(p0,'lumpspec',N,q0);
%   plot(alpha,f_alpha);
%   ______________________________________________________________________
%
%   3.  References
%
%   "Multifractal Measures", Carl J. G. Evertsz and Benoit B. MandelBrot.
%   In Chaos and Fractals, New Frontiers of Science, Appendix B. Edited by
%   Peitgen, Juergens and Saupe, Springer Verlag, 1992 pages 921-953.
%
%   "A class of Multinomial Multifractal Measures with negative (latent)
%   values for the "Dimension" f(alpha)", Benoit B. MandelBrot. In
%   Fractals' Physical Origins and Properties, Proceeding of the Erice
%   Meeting, 1988. Edited by L. Pietronero, Plenum Press, New York, 1989
%   pages 3-29.
%
%   4.  See also
%
%   sbinom, multim1d, multim2d, smultim1d, smultim2d (C_LAB routines).
%
%   MFAS_measures, MFAS_dimensions, MFAS_spectra (Matlab and/or Scilab
%   demo scripts).
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

