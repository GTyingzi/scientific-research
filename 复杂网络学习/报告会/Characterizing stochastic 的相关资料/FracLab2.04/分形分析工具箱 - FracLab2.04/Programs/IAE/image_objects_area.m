function val = image_objects_area(imgnum)
global mydata;

matrix= im2bw(mydata.images.image(imgnum).CData,0.5);

val = bwarea(matrix)/(size(matrix,1)*size(matrix,2));

