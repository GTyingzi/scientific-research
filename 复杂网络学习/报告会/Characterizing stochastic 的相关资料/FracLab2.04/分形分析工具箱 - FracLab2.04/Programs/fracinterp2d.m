function [out]=fracinterp2d(in,debut,fin,lambda,type_ond,alpha,siz1)


in2=in;

[x1,y1]=size(in);
nx=log2(x1);
ny=log2(y1);
N=[x1,y1];


h = fl_waitbar('init');

if nx==floor(log2(x1)) & ny==floor(log2(y1));
   in1=in;
   x=x1;y=y1;
elseif nx==floor(log2(x1))
   in1=zeros(x1,2^(floor(log2(y1))+1));
   in1(1:x1,1:y1)=in(1:x1,1:y1);
   [x,y]=size(in1);
elseif  ny==floor(log2(y1));
   in1=zeros(2^(floor(log2(x1))+1),y1);
   in1(1:x1,1:y1)=in(1:x1,1:y1);
   [x,y]=size(in1);
else 
   in1=zeros(2^(floor(log2(x1))+1),2^(floor(log2(y1))+1));
   in1(1:x1,1:y1)=in(1:x1,1:y1);
   [x,y]=size(in1);
end 


in=in1;

% for i=1:288
%    ligne=fracinterpsansaff(left(i,1:256),2,8,1,'Triangle',1,0);
%    tul(i,:)=ligne;
% end
% figure;imagesc(tul);
% figure;imagesc(left(:,1:256))


croix1=zeros(2*x,2*y);

for i=1:x
   fl_waitbar('view',h,x,i/2);
   ligne=fracinterp(in(i,1:y),debut,fin,1,type_ond,alpha,siz1,0);
   %tul1(i,:)=ligne;
   croix1(2*i-1,:)=ligne;
end
%figure;imagesc(tul1);
%figure;imagesc(croix1);
%figure;imagesc(in(1:x,1:y));colormap gray;


for i=1:y
   fl_waitbar('view',h,x,x/2+i/2);
   colonne=fracinterp(in(1:x,i),debut,fin,1,type_ond,alpha,siz1,0);
   %tul2(i,:)=colonne;
   croix1(:,2*i-1)=colonne;
end

%figure;imagesc(croix1);



for i=1:x-1
    for j=1:y-1
        croix1(2*i,2*j)=(croix1(2*i-1,2*j-1)+croix1(2*i-1,2*j)+...
                        croix1(2*i-1,2*j+1)+...
                        croix1(2*i,2*j-1)+croix1(2*i,2*j+1)+...
                        croix1(2*i+1,2*j-1)+croix1(2*i+1,2*j)+...
                        croix1(2*i+1,2*j+1))/8;
    end
end



for i=x
    for j=1:y-1
        croix1(2*i,2*j)=(croix1(2*i-1,2*j-1)+croix1(2*i-1,2*j)+...
                        croix1(2*i-1,2*j+1)+...
                        croix1(2*i,2*j-1)+croix1(2*i,2*j+1))/5;
    end
end


for i=1:x-1
    for j=y
        croix1(2*i,2*j)=(croix1(2*i-1,2*j-1)+croix1(2*i-1,2*j)+...
                        croix1(2*i,2*j-1)+...
                        croix1(2*i+1,2*j-1)+croix1(2*i+1,2*j))/5;
    end
end


croix1(2*x,2*y)=(croix1(2*x-1,2*y-1)+croix1(2*x-1,2*y)+croix1(2*x,2*y-1))/3;

%figure;imagesc(croix1);colormap gray;


croix2=croix1(1:2*x1,1:2*y1);
out=croix2;
fl_waitbar('close',h);

%figure;imagesc(in2);colormap gray;title('original')
%figure;imagesc(croix2);colormap gray;title('interp')
