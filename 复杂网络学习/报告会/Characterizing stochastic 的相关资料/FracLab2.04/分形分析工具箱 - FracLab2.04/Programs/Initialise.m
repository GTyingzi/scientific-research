function X = Initialise(samplingftn)

% function X = Initialise(samplingftn)
%
% returns a randomly chosen initial state for an EBP process
%
% samplingftn is a function handle for a function that samples from 
% the offspring sampling distribution n*p(n)/mu
%
% X = (kappa(0,0,0), S(0,0,1), Z(0,1,1), alpha(0,0,1))
%
% types are 0+ 0- 1+ 1- -1+ -1-, labelled 1 2 3 4 5 6
%
% Owen Jones 6 July 2003

X = [1 0 0 0];
%X(3) = feval(samplingftn);
X(3) = eval(samplingftn);
X(2) = ceil(rand*X(3));
if X(2) == X(3)
    if rand < 0.5, X(4) = 3; else X(4) = 6; end
elseif mod(X(2),2) == 1
    if rand < 0.5, X(4) = 1; else X(4) = 2; end
else
    if rand < 0.5, X(4) = 4; else X(4) = 5; end
end
