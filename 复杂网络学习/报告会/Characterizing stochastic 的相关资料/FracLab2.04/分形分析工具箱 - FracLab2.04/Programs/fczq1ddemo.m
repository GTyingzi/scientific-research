%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAL/MATLAB-SCRIPTS/fczq1ddemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: fczq1ddemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 20:11:51 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 22:36:15 1999
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

% partition function: z(a,q) estimation with default input arguments and
% all output arguments
[zaq,a,q]=fczq1d(fbm);
% plot outputs
plot(log(a),log(zaq));

% partition function: z(a,q) estimation with custom input arguments and 
% two output arguments
[zaq,a]=fczq1d(fbm,[-5:.1:+5],[10 1 128],'lin','l2');
% plot outputs
plot(log(a),log(zaq));