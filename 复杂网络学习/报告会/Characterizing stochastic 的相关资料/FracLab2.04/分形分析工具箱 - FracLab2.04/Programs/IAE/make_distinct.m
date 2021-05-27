function [x,y] = make_distinct(x,y)
% function to make a data abscissae distinct
% y = f(x)


dummy = [1:1:length(x)];

[unique_vals,unique_pos] = unique(x);
dummy(unique_pos) = [];

not_unique = unique(x(dummy));

for i=1:1:length(not_unique)
	y(x == not_unique(i)) = mean(y(x == not_unique(i)));
end

% now reduce the data
[x,pos] = unique(x);
y = y(pos);

