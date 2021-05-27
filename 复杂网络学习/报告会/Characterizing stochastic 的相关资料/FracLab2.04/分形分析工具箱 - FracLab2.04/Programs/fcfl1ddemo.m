%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAL/MATLAB-SCRIPTS/fcfl1ddemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: fcfl1ddemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 22:09:16 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 22:36:00 1999
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% Description : 
%                
%                
%                
%------------------------------------------------------------------------------

% Fractional Brownian motion synthesis
fbm=fbmlevinson(256,.6);

% Continuous legendre spectrum: f(alpha) on 1d function with default input arguments and
% all output arguments
[alpha,f_alpha,zaq,a,tq,q]=fcfl1d(fbm);
% plot outputs
plot(log(a),log(zaq));
plot(q,tq);
plot(alpha,f_alpha);

% Continuous legendre spectrum: f(alpha) on 1d function with custom input arguments and
% two output arguments
[alpha,f_alpha]=fcfl1d(fbm,[-5:.1:+5],[10 1 128],'lin','l2','lapls');
% plot outputs
plot(alpha,f_alpha);
