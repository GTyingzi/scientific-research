function result = image_gray_correlation(imgnum)
global mydata;

data1 = double(rgb2gray(mydata.images.image(imgnum).CData));
data2 = double(rgb2gray(mydata.images.image(1).CData));

result = corr2(data1,data2);

