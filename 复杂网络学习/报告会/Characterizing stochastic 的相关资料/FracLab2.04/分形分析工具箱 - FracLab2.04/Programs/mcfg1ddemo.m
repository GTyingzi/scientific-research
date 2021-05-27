%------------------------------------------------------------------------------
%                                                                              
%                                    FracLab
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% File path        : /a/user/canus/MYFRACLAB/MFAG/MATLAB-SCRIPTS/mcfg1ddemo.m
% File type        : Matlab source file
% Revision         : $Revision: 1.1.1.1 $
% RCS status       : $Id: mcfg1ddemo.m,v 1.1.1.1 2000/07/10 10:05:44 raynal Exp $
% Created by       : (Fractales Project INRIA) Christophe Canus
% Creation date    : Mon Feb  8 20:38:40 1999
% Last edited by   : (Fractales Project INRIA) Christophe Canus
% Last edition date: Mon Feb  8 20:38:51 1999
%                                                                              
%------------------------------------------------------------------------------
%                                                                              
% Description : 
%                
%                
%                
%------------------------------------------------------------------------------


% synthesis of pre-multifractal binomial measure: mu_n
% resolution of the pre-multifractal measure
n=10; 
% parameter of the binomial measure
p_0=.4; 
% synthesis of the pre-multifractal beiscovitch 1d measure 
mu_n=binom(p_0,'meas',n);  
% continuous large deviation spectrum estimation: fgc_alpha  
%  minimum size, maximum size & # of scales
S_min=1;S_max=8;J=4;
% # of hoelder exponents, precision vector
N=200;epsilon=zeros(1,N); 
% estimate the continuous large deviation spectrum
[alpha,fgc_alpha,pc_alpha,epsilon_star]=mcfg1d(mu_n,[S_min,S_max,J],'dec','cent',N,epsilon,'hkern','maxdev','gau','suppdf'); 
% plot the continuous large deviation spectrum
plot(alpha,fgc_alpha); 
title('Continuous Large Deviation spectrum');  
xlabel('\alpha');
ylabel('f_{g,\eta}^{c,\epsilon}(\alpha)');
