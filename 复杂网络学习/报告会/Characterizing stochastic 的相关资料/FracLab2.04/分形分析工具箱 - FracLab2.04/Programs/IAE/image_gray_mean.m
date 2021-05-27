function result = image_gray_mean(imgnum)
global mydata;

data = double(rgb2gray(mydata.images.image(imgnum).CData));


result = mean2(data);

