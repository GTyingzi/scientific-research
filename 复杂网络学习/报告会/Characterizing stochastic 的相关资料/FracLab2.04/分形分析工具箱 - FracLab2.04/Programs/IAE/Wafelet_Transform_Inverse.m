% --- Do Inverse DWT Transformation
function mat2D = Wafelet_Transform_Inverse(data)

mat2D = IWT2D(data.wt, data.filter);
% cut dimension to original size
% oversize results from WT which produces dimensions of 2^ceil(log(Old_Dimension)/log(2))
mat2D	= mat2D(1:1:data.size_x, 1:1:data.size_y);
mat2D = round(mat2D);
