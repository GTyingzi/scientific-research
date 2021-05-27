function [xsample, X, randstate] = Simulate(X, x2, n, offspringftn, samplingftn, randstate)

% function [xsample, X] = Simulate(X, x2, n, offspringftn, samplingftn)
%
% simulates an EBP process
%
% X in is the current state of the process at step 1 (levels 0 to nmax)
% x2 is the current position of the process at start of step 2 (end of step 1)
% n is the number of additional steps required
% offspringftn is a function handle for a function that samples from 
% the offspring distribution p(n)
% samplingftn is a function handle for a function that samples from 
% the offspring sampling distribution n*p(n)/mu
% X out is the state of the process at step n+1
% xsample is the position of the process at steps 1, ..., n+1
%
% randstate is an optional parameter for setting the state of the random number generator
%
% offspringftn and samplingftn are functions that take no parameters
% and return a value in the set {2, 4, 6, ...}
%
% row m+1 of X in is (kappa(0,m,1), S(0,m,1), Z(0,m+1,1), alpha(0,m,1))
% row m+1 of X out is (kappa(0,m,n+1), S(0,m,n+1), Z(0,m+1,n+1), alpha(0,m,n+1))
%
% types are 0+ 0- 1+ 1- -1+ -1-, labelled 1 2 3 4 5 6
%
% Owen Jones 6 July 2003

if nargin == 6
    rand('state', randstate)
end

xsample = zeros(n+1,1);
xsample(1) = x2;

for k = 1:n
	X = Expand(X, samplingftn);
	X = Increment(X, 0, offspringftn);
    if (X(1,4) == 1) | (X(1,4) == 3) | (X(1,4) == 5) 
        xsample(k+1) = xsample(k) + 1;
    else
        xsample(k+1) = xsample(k) - 1;
    end
end

randstate = rand('state');