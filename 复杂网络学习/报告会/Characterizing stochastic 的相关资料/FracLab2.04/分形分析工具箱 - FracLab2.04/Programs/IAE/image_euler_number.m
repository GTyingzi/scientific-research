function val = image_euler_number(imgnum)
global mydata;

matrix= 1-im2bw(mydata.images.image(imgnum).CData,0.5);

val = bweuler(matrix,8);

