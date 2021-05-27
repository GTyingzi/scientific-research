function [A,B,AB,BP,pc,lf] = fl_percolation(n,m,vis,t,H,mname)

%Simulates an Invasion Percolation.

%INPUTS:
%n= random media size.
%m= maximum number of iterations.
%vis=1: Shows the percolation in progress, vis=0 
%displays only the final result (faster).
%t=0: Random media=iid uniform law on (0,1).
%t=1: Random media=fBm with exponent "H".
%t=2: Random media=matrix named "mname" in the workspace.

%OUTPUTS
%A: Random media.
%B: Percolation cluster.
%AB: Percolation cluster superimposed on the random matrix.
%BP: Binary version of B.
%pc: Depth of the percolation cluster as a function of time.
%lp: Length of the percolation front as a function of time.

%AUXILIARY VARIABLES
%i: "Time" variable.
%F= percolation front at time i.


%Definition of the random media.
if t==0
    %t=0, uniform law.
    A=rand(n,n);
elseif t==1
    %Case of fBm.
    A=synth2(n,0.4,'strfbm');
    %A is rescaled between 0 and 1.
    A=(A-min(min(A)))/(max(max(A))-min(min(A)));
elseif t==2
    %user defined media.
    A=mname;
    %A is rescaled between 0 and 1.
    A=(A-min(min(A)))/(max(max(A))-min(min(A)));
    n = min(size(A));
else
    disp('t must be equal to 0, 1 or 2')
end

%Initialisation: All points are dry at the beginning.
B=zeros(n,n);
BP=zeros(n,n);
%No point is accessible.
F=ones(n,n);
%At time 1, the first line of A is accessible.
F(1,:)=A(1,:);
%AB is used to "superimpose" B on A.
AB=A/2;

%current depth of the percolation cluster.
pc=zeros(1,m);
%current length of the percolation front.
lf=zeros(1,m);


if vis==0
    h_waitbar = fl_waitbar('init');
else
    index_fig1 = figure;
    set(index_fig1,'DoubleBuffer','on')
    subplot(2,2,2);imagesc(BP);
    subplot(2,2,3);image(B);
    subplot(2,2,1);imagesc(AB);
    subplot(2,2,4);imagesc(F);
    fl_window_init(index_fig1,'Figure');
    pause(0.0001);
end
    

%Loop on time instants
for i=1:m
    %One localizes the min of F. 
    [fmin1,floc1]=min(F);
    [fmin2,floc2]=min(min(F));
    %The minimum de F is at (floc1(flco2),floc2)
    %This location is wetted in B
    B(floc1(floc2),floc2)=A(floc1(floc2),floc2);
    BP(floc1(floc2),floc2)=1;
    AB(floc1(floc2),floc2)=1;
    %Ths point must be withdrawn from F, i.e. put at 1,
    %so that it is not considered "wettable" anymore
    F(floc1(floc2),floc2)=1;
    
    %one verifies if the percolation is over 
    if floc1(floc2)==n  
        break;
    end
    %The new wettable points are put in F:
    %Those in contact with the one just wetted.
    %Percolation downwards provided the point is not already wet.
    if BP(floc1(floc2)+1,floc2)==0
        F(floc1(floc2)+1,floc2)=A(floc1(floc2)+1,floc2);
    end
    %Percolation leftwards provided the point is not already wet
    %and one is not on the left side of the media.
    if floc2 >1 & BP(floc1(floc2)+1,floc2-1)==0
        F(floc1(floc2)+1,floc2-1)=A(floc1(floc2)+1,floc2-1);
    end
    %Percolation rightwards provided the point is not already wet
    %and one is not on the right side of the media.
    if floc2 <n & BP(floc1(floc2)+1,floc2+1)==0
        F(floc1(floc2)+1,floc2+1)=A(floc1(floc2)+1,floc2+1);
    end
  
    %update the depth
    pc(i)=max(pc(max(i-1,1)),floc1(floc2));
    
    %update the length
    lf(i)=sum(sum((1-F)>0));
    
    %Display the growth of B, etc.. provided vis=1 
    if vis==1
        pause(0.0001);
        figure(index_fig1);
        subplot(2,2,2);imagesc(BP);
        subplot(2,2,3);imagesc(B);
        subplot(2,2,1);imagesc(AB);
        subplot(2,2,4);imagesc(F);
    else
        fl_waitbar('view',h_waitbar,i,m);
    end
end

if vis == 0
    index_fig1 = figure;
    fl_waitbar('close',h_waitbar);
end
figure(index_fig1);
subplot(2,2,3);image(B);
subplot(2,2,2);imagesc(BP);
subplot(2,2,1);imagesc(AB);
subplot(2,2,4);imagesc(F);
index_fig2 = figure;
fl_window_init(index_fig2,'Figure');
pause(0.0001);
subplot(2,1,1);plot(pc(1:i-1));
subplot(2,1,2);plot(lf(1:i-1));


fl_window_init(index_fig1,'Figure');
fl_window_init(index_fig2,'Figure');
