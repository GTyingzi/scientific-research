%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/FRACLAB-WKSP/FRACLAB/MFAL/MATLAB-SCRIPTS/mdfl1ddemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: mdfl1ddemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Sun May 16 16:10:39 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Sun May 16 16:23:38 1999
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

% Discrete Legendre spectrum: f(alpha) on 1d measure with default input arguments and
% all output arguments
[alpha,f_alpha,zaq,a,tq,q]=mdfl1d(mu_n);
% plot outputs
plot(log(a),log(zaq));
plot(q,tq);
plot(alpha,f_alpha,'o');

% Discrete Legendre spectrum: f(alpha) on 1d function with custom input arguments and
% two output arguments
[alpha,f_alpha]=mdfl1d(mu_n,[-5:.1:+5],[10 1 512],'linpart','pls');
% plot outputs
plot(alpha,f_alpha,'r');

