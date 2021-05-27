% --- Do DWT Transformation
function result = Wafelet_Transform(mat2D,scales,filter)
% mat2D 	2dim.Image Data
% scales 	number of scales to calculate
% filter 	Wafelet which should be used

[wt,wti,wtl] = FWT2D(double(mat2D), scales, filter);

result = struct('wt',wt, 'size_x',size(mat2D,1), 'size_y',size(mat2D,2), 'wti',wti, 'wtl',wtl, 'scales', size(wti,1), 'filter',filter);
