function result = image_difference_from_master(imgnum)
global mydata;

result = image_difference(mydata.images.image(imgnum).CData,mydata.images.image(9).CData);


function d = image_difference(image1,image2)

image1 = double(image1);
image2 = double(image2);


d = (	sum(abs(reshape(image1(:,:,1),1,[])-reshape(image2(:,:,1),1,[]))) + ...
			sum(abs(reshape(image1(:,:,2),1,[])-reshape(image2(:,:,2),1,[]))) + ...
			sum(abs(reshape(image1(:,:,3),1,[])-reshape(image2(:,:,3),1,[]))) )/(size(image1,1)*size(image1,2)*size(image1,3));