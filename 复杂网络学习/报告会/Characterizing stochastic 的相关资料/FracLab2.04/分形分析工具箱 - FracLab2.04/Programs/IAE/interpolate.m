function yi = interpolate(samples, xi)
% interpolates a hyper-surface at the points specified by xi (query) to produce yi (result)
% the hyper-surface is made of a number of samples (database)
%	dim(samples)= NxM , dim(xi)= (N-1)xL


dim = size(samples,1);

samples = samples';
xd = samples(:,1:1:dim-1);
yd = samples(:,dim);

xi = xi';

yi = griddatan(xd,yd,xi,'linear');