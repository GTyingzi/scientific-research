%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAL/MATLAB-SCRIPTS/reynitqdemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: reynitqdemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 20:26:43 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 23:01:03 1999
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% Description : 
%                
%                
%                
%------------------------------------------------------------------------------


% Pre-multifractal binomial 1d measure synthesis
mu_n=binom(.1,'meas',10);

% Partition function: z(a,q) on 1d measure with default input arguments and
% all output arguments
[zaq,a,q]=mdzq1d(mu_n);
plot(log(a),log(zaq));

% Reyni mass exponents: t(q) with custom input arguments and
% all ouput arguments
[tq,Dq]=reynitq(zaq,q,a,'wls');
plot(q,tq);

% Just to see that it doesn't look very good
[alpha,f_alpha]=linearlt(q,tq);
plot(alpha,f_alpha);