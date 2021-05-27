%   multim1d
%   multinomial 1d measure synthesis
%   Christophe Canus
%   July 5th 1997
%
%   This  C_LAB routine   synthesizes  a large range of   pre-multifractal
%   measures  related  to  the    multinomial  1d  measure (deterministic,
%   shuffled, pertubated) and    computes  linked  theoretical   functions
%   (partition   sum   function, Reyni   exponents  function,  generalized
%   dimensions, multifractal spectrum).
%
%   1.  Usage
%
%   [varargout,[optvarargout]]=multim1d(b,p,str,varargin,[optvarargin])
%
%   1.1.  Input parameters
%
%   o  b : strictly positive real (integer) scalar
%      Contains the base of the multinomial.
%
%   o  p : strictly positive real vector [1,b]
%      Contains the weights of the multinomial.
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
%   b=3;
%   p=[.1 .3 .6];
%   n=8;
%   % synthesizes a pre-multifractal multinomial 1d measure
%   [mu_n,I_n]=multim1d(b,p,'meas',n);
%   plot(I_n,mu_n);
%
%   % synthesizes the cdf of a pre-multifractal shuffled multinomial 1d measure
%   F_n=multim1d(b,p,'shufcdf',n);
%   plot(I_n,F_n);
%
%   e=.09;
%   % synthesizes the pdf of a pre-multifractal pertubated multinomial 1d measure
%   p_n=multim1d(b,p,'pertpdf',n,e);
%   plot(I_n,p_n);
%
%   vn=[1:1:8];
%   q=[-5:.1:+5];
%   % computes the partition sum function of a multinomial 1d measure
%   znq=multim1d(b,p,'part',vn,q);
%   plot(-vn*log(2),log(znq));
%
%   % computes the Reyni exponents function of a multinomial 1d measure
%   tq=multim1d(b,p,'Reyni',q);
%   plot(q,tq);
%
%   N=200;
%   % computes the multifractal spectrum of a multinomial 1d measure
%   [alpha,f_alpha]=multim1d(b,p,'spec',N);
%   plot(alpha,f_alpha);
%   ______________________________________________________________________
%
%   2.2.  Scilab
%
%   ______________________________________________________________________
%
%   b=3;
%   p=[.1 .3 .6];
%   n=8;
%   // synthesizes a pre-multifractal multinomial 1d measure
%   [mu_n,I_n]=multim1d(b,p,'meas',n);
%   plot(I_n,mu_n);
%
%   // synthesizes the cdf of a pre-multifractal shuffled multinomial 1d measure
%   F_n=multim1d(b,p,'shufcdf',n);
%   plot(I_n,F_n);
%
%   e=.09;
%   // synthesizes the pdf of a pre-multifractal pertubated multinomial 1d measure
%   p_n=multim1d(b,p,'pertpdf',n,e);
%   plot(I_n,p_n);
%   xbasc();
%
%   vn=[1:1:8];
%   q=[-5:.1:+5];
%   // computes the partition sum function of a multinomial 1d measure
%   znq=multim1d(b,p,'part',vn,q);
%   mn=zeros(max(size(q)),max(size(vn)));
%   for i=1:max(size(q))
%      mn(i,:)=-vn*log(2);
%   end
%   plot2d(mn',log(znq'));
%
%   // computes the Reyni exponents function of a multinomial 1d measure
%   tq=multim1d(b,p,'Reyni',q);
%   plot(q,tq);
%
%   N=200;
%   // computes the multifractal spectrum of a multinomial 1d measure
%   [alpha,f_alpha]=multim1d(b,p,'spec',N);
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
%   binom, sbinom, multim2d, smultim1d, smultim2d (C_LAB routines).
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

