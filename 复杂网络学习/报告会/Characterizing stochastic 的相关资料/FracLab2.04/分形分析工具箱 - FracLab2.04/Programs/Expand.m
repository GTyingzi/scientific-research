function X = Expand(X, samplingftn)

% function X = Expand(X, samplingftn)
%
% adds new levels to the state of an EBP process
%
% X in is the current state of the process at step k (levels 0 to nmax)
% samplingftn is a function handle for a function that samples from 
% the offspring sampling distribution n*p(n)/mu
% X out is the expanded state of the process at step k (nmax may have increased)
%
% row n+1 of X is (kappa(0,n,k), S(0,n,k), Z(0,n+1,k), alpha(0,n,k))
% row nmax+1 of X out satisfies S(0,nmax,k) < Z(0,nmax+1,k)
%
% types are 0+ 0- 1+ 1- -1+ -1-, labelled 1 2 3 4 5 6
%
% Owen Jones 6 July 2003

nmax = size(X,1) - 1;
while X(nmax+1,2) == X(nmax+1,3)
    nmax = nmax + 1;
    X = [X; 1 0 0 0];
    X(nmax+1,3) = eval(samplingftn);
    X(nmax+1,2) = ceil(rand*X(nmax+1,3));
    if X(nmax,4) == 3
        if X(nmax+1,2) == X(nmax+1,3)
            X(nmax+1,4) = 3;
        elseif mod(X(nmax+1,2),2) == 1
            X(nmax+1,4) = 1;
        else
            X(nmax+1,4) = 5;
        end
    else
        if X(nmax+1,2) == X(nmax+1,3)
            X(nmax+1,4) = 6;
        elseif mod(X(nmax+1,2),2) == 1
            X(nmax+1,4) = 2;
        else
            X(nmax+1,4) = 4;
        end
    end
end
