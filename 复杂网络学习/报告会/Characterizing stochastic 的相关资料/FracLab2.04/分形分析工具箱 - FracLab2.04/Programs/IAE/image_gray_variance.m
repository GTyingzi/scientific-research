function result = image_gray_variance(imgnum)
global mydata;

data = double(rgb2gray(mydata.images.image(imgnum).CData));


data = reshape(data,1,[]);

result = var(data,1);

