% --- Merge [NxM] color channels into one [NxMx3] image
function result = Merge_RGB(red, green, blue)
% red		color channel red
% green	color channel green
% blue	color channel blue

RGB = [];
RGB(:,:,1) = red;
RGB(:,:,2) = green;
RGB(:,:,3) = blue;

result = uint8(RGB);