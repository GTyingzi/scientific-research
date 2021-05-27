function [list_lac,time]=lacunarity(A,eps_min,eps_max,step)


% Karine CHRISTOPHE and Raphael CELLARD
% April 2003
% 
% Lacunarity

[m,n]=size(A);
Ma=sum(sum(A));
list_lac=[];
time=[];
if (Ma~=0)
    if(eps_min<1)
            disp('> eps_min must be > 1 !')
        elseif(eps_max>min(m,n))
            disp('>eps_max must be inferior to the number of rows and columns in A !')
        else
            for eps=eps_min:step:eps_max
                massW=Ma*eps^2/(m*n);
                mat_conv=1/massW*ones(eps,eps);
                SSum=0;
                index=ceil(eps/2);
                mat_inter=conv2(A,mat_conv,'same')-ones(m,n);
                mat2_inter=mat_inter(index:index+m-eps,index:index+n-eps);
                mat3_inter=mat2_inter.^2; 
                SSum=sum(sum(mat3_inter));
                Lac=SSum/((m-eps+1)*(n-eps+1));
                list_lac=[list_lac;Lac];
                time=[time;eps];
            end
        end
else
    disp('> Beware ! Uniformly black image !')
    Lac=0;
end
%plot(time,list_lac);