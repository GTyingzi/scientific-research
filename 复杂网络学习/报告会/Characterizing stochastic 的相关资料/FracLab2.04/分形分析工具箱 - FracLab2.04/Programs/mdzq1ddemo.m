%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAL/MATLAB-SCRIPTS/mdzq1ddemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: mdzq1ddemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 20:12:33 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 22:47:47 1999
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% Description : 
%                
%                
%                
%------------------------------------------------------------------------------

% pre-multifractal binomial 1d measure synthesis
mu_n=binom(.1,'meas',10);

% partition function: z(a,q) on 1d measure with default input arguments and
% all output arguments
[zaq,a,q]=mdzq1d(mu_n);
plot(log(a),log(zaq));
