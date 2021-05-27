%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAM/MATLAB-SCRIPTS/bbchdemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: bbchdemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 20:38:07 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 20:38:12 1999
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% Description : 
%                
%                
%                
%------------------------------------------------------------------------------


h=.3;beta=3;
N=1000;
% chirp singularity (h,beta)
x=linspace(0.,1.,N);
u_x=abs(x).^h.*sin(abs(x).^(-beta));
plot(x,u_x);
hold on;
[rx,ru_x]=bbch(x,u_x);
plot(rx,ru_x,'rd');
plot(x,abs(x).^h,'k');
