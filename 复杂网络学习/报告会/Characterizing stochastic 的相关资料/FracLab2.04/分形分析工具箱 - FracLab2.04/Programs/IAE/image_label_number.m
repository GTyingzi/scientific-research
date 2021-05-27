function result = image_label_number(imgnum)
global mydata;

data = 1-im2bw(mydata.images.image(imgnum).CData,0.5);

[L,result] = bwlabel(data,8);
result = result/(size(data,1)*size(data,2));
