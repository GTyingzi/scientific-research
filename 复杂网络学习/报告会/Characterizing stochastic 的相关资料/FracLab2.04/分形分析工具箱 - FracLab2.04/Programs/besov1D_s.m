function [VectEnergie,EnergieT]=besov1D_s(Input,s,niveau,type_ond,siz1) 

d=MakeQMF(type_ond,siz1);

[wt,index,length] =FWT(Input,niveau,d);
t=(1:niveau);
VectEnergie=zeros(1,niveau);
for sc=1:niveau
        VectWT=abs(wt(index(sc):(index(sc)+length(sc)-1)));
        VectEnergie(sc)=2^(sc*(s+1/2))*max(VectWT);
end
EnergieT=max(VectEnergie);

figure;plot(t,VectEnergie,'b');
title('Besov Norms');xlabel('Level');ylabel('Norm');