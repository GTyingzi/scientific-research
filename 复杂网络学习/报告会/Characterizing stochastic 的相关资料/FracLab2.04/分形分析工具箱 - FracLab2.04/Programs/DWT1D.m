function [visualisation]=DWT1D(WT)

% Pierrick Legrand, January 2005


NbSc = WTNbScales(WT);
SignalSize = WTOrigSize(WT);
Multires = zeros(NbSc, SignalSize);
N=SignalSize;
n=NbSc;
[ScIndex, ScLength]=WTStruct(WT);

% for j=1:n
%    Multires(j,1:N/(2^(n-1))= 
% end    

wc=WT;

matrice1=zeros(n,2^(n-1));
for j=1:1:n
%     1:ScLength(j)
%     ScIndex(j):ScIndex(j)+ScLength(j)-1
    matrice1(n-j+1,1:ScLength(j))=wc(ScIndex(j):ScIndex(j)+ScLength(j)-1);
end;    
wc;
matrice1;


% redondance
for j=1:n
    for k=1:2^(j-1)
        matrice3(j,1+(k-1)*floor(2^(n-1)/2^(j-1)):(k)*floor(2^(n-1)/2^(j-1)))=matrice1(j,k);
    end;
end    
visualisation=matrice3;
%figure;imagesc(visualisation)
    
    
    
    
    
    
    
    
 