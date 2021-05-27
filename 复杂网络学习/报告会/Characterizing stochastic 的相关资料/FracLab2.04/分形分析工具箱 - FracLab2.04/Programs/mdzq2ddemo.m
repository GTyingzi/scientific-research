%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAL/MATLAB-SCRIPTS/mdzq2ddemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: mdzq2ddemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 22:44:11 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 22:49:56 1999
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% Description : 
%                
%                
%                
%------------------------------------------------------------------------------

% Pre-multifractal multinomial 2d measure synthesis
mu_n=multim2d(2,2,[.1 .3; .2 .4],'meas',6);

% Partition function: z(a,q) on 2d measure with default input arguments and
% all output arguments
[zaq,a,q]=mdzq2d(mu_n);
plot(log(a),log(zaq));


