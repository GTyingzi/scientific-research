function [N] = WT2DSize(WT)
% Returns the size of the signal used for the decomposition 
%
% See also  WT2DStruct, WT2DNbScales, FWT2D, IWT2D
%
% Bertrand Guiheneuf 1997

	N = [ WT(1) , WT(2) ];
