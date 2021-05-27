function X = Increment(X, n, offspringftn)

% function X = Increment(X, n, offspringftn)
%
% increments the state of an EBP process
%
% X in is the current state of the process at step k (levels 0 to nmax)
% n is the level being incremented
% offspringftn is a function handle for a function that samples from 
% the offspring distribution p(n)
% X out is the state of the process at step k+1
%
% row n+1 of X in is (kappa(0,n,k), S(0,n,k), Z(0,n+1,k), alpha(0,n,k))
% row n+1 of X out is (kappa(0,n,k+1), S(0,n,k+1), Z(0,n+1,k+1), alpha(0,n,k+1))
%
% types are 0+ 0- 1+ 1- -1+ -1-, labelled 1 2 3 4 5 6
%
% Owen Jones 6 July 2003

if (n > 0) & ~(X(n,2) == X(n,3))
    error('X is not at end of level n crossing')
end

if X(n+1,2) == X(n+1,3)
    X = Increment(X, n+1, offspringftn);
    X(n+1,2) = 1;
    X(n+1,3) = eval(offspringftn);
else
    X(n+1,2) = X(n+1,2) + 1;
end

X(n+1,1) = X(n+1,1) + 1;

nmax = size(X,1) - 1;
if n == nmax
    if X(n+1,2) == X(n+1,3)
        if X(n+1,4) == 1, X(n+1,4) = 3; else X(n+1,4) = 6; end
    elseif mod(X(n+1,2),2) == 1
        if rand < 0.5, X(n+1,4) = 1; else X(n+1,4) = 2; end
    else
        if X(n+1,4) == 1, X(n+1,4) = 4; else X(n+1,4) = 5; end
    end
else
    if X(n+1,2) == X(n+1,3)
        if (X(n+2,4) == 1) | (X(n+2,4) == 3) | (X(n+2,4) == 5), X(n+1,4) = 3; else X(n+1,4) = 6; end
    elseif X(n+1,2) == X(n+1,3) - 1
        if (X(n+2,4) == 1) | (X(n+2,4) == 3) | (X(n+2,4) == 5), X(n+1,4) = 1; else X(n+1,4) = 2; end
    elseif mod(X(n+1,2),2) == 1
        if rand < 0.5, X(n+1,4) = 1; else X(n+1,4) = 2; end
    else
        if X(n+1,4) == 1, X(n+1,4) = 4; else X(n+1,4) = 5; end
    end
end
       
        
    