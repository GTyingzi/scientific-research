function [A,pn,cr]=dla(T,drl,dra,ndepmax,npart,sp,vis)

%Simulates a Diffusion-Limited Agregation (dla).
%The simulation starts with a particle at the center
%of the screen, which will develop into the agregation
%cluster. Particles are then launched one at a
%time from "infinity", i.e. from a circle of radius
%rl. The position on the circle is chosen randomly.
%The particle then diffuses randomly, i.e. at each
%step it moves one step to one the eight neighbouring
%positions (lattice diffusion). Three things may then happen:
%1) The particle hits the cluster, in which case it sticks to
%it with probability sp.
%2) The particle goes to far away from the center of the screen,
%i.e. its distance the origin gets larger than a parameter ra.
%It is then annihilated.
%3) The particle has wandered more than the maximum allowed
%duration ndepmax. Again, it is annihilated.
%Another particle is then launched, and the process goes on.
%To speed up the simulation, the radius of launching rl and
%the one of annihilation ra are not fixed, but grow as a function
%of the radius of the cluster rc. More precisely,
%rl=rc+drl and ra=rl+dra.
%The simulation stops when the launching radius is larger
%than half the size of the image (parameter 'T'), or when 
%the maximum number of particles (parameter 'npart') has been reached.
%In addition to the DLA cluster, the code computes the number
%of particles pn and the radius rc as a function of the
%number of launched particles.
%The colours in the cluster code for the arrival time.

%vis=1 allows to visualize the growth of the cluster.

%Initialisations
%square of the initial cluster radius.
rc2=1;
%initial radius of the launching circle.
rl=3;
%the launching radius at time t is equal to rc(t)+drl,
%with a default drl=0.
%initial square of the radius of the annihilating circle.
ra2=9;
%the annihilating radius at time t is equal to rl+dra,
%with a default drl=20;
%maximum number of moves before a particle is anihilated.
%default : ndepmax=2000 for T<512,
%ndepmax=10000 for T=512,ndepmax=20000 for T=1024
%maximum number of particles in the cluster.
%default :npart=100000 for T=1024,npart=30000 for T=512,
%npart=10000 for T=256, npart=2500 for T=128.

%matrix containing the cluster
A=zeros(T,T);
%matric for visualizing the moving particles
B=A;
%seed of the cluster
A(T/2,T/2)=1/2;
%prepare for visualization.
if vis>=1  
    nf1=figure; set(nf1,'DoubleBuffer','on');imagesc(A);axis image;
    fl_window_init(nf1,'Figure');
else
    h_waitbar = fl_waitbar('init');
end
%current number of particles in the cluster.
pn=ones(1,npart);
%auxiliary variable for the number of particle
%used in the inner loop
cpn=1;
%current radius of the cluster.
cr=ones(1,npart);

%rand('state',sum(100*clock))

%draw the random angles for the starting point of the particles.
theta=2*pi*rand(1,npart);
%loop on the particles.
for np=1:npart
    if vis == 0
    	fl_waitbar('view',h_waitbar,np,npart);
    end
    %rand('state',sum(100*clock))
    rdx=rand(1,ndepmax);
    rdy=rand(1,ndepmax);
    
    %initial position.
    x=T/2+floor(rl*cos(theta(np)));
    y=T/2+floor(rl*sin(theta(np)));    
    
    
    %loop on the movement of each particle.
    for dep=1:ndepmax
        
        %diffusion
        %erase the particle from its current position 
        %(for visualization purpose).
        B(x,y)=0;
        %computes the move.
        dx=floor(3*rdx(1,dep))-1;
        dy=floor(3*rdy(1,dep))-1;
        x=max(2,min(T-1,x+dx));
        y=max(2,min(T-1,y+dy));
        %test whether the particle has reached the cluster
        %and sticks to it depending on the sticking probabilty sp
        if max(max(A(x-1:x+1,y-1:y+1)))>0 & rand<sp
            %the particle is sticked with a colour
            %depending on the arrival time.
            cpn=cpn+1;
            A(x,y)=1-np/npart;
            %updates the various radii.
            rc2=max(rc2,(x-T/2)^2+(y-T/2)^2);
            rl=sqrt(rc2+drl);
            ra2=(rl+dra)^2;
            if vis==1
            	figure(nf1);imagesc(A);axis image;pause(0.000001);
            end
            break
        end
        %annihilate the particle if it reaches the annihilating circle.
        if (x-T/2)^2+(y-T/2)^2> ra2
            break
        end
        %puts the particle in its new position
        B(x,y)=.6;
        if vis==2
            figure(nf1);imagesc(max(A,B));axis image;pause(0.000001);
        end
    end
    cr(np)=sqrt(rc2);
    pn(np)=cpn;
    %stop the simulation if the radius of launching is too large.
    if rl>T/2-1
        break
    end
end

if vis == 0
    fl_waitbar('close',h_waitbar);
    nf1=figure;
end
%figure(nf1);
imagesc(A);axis image;
xlabel(['DLA with  ', num2str(np), ' particles'])
nf2=figure;
subplot(3,1,1);plot(cr(1:np-1));
xlabel('radius of the cluster as a function of the # of launched particles')
subplot(3,1,2);plot(pn(1:np-1))
xlabel('# of particles in the cluster as a function of the # of launched particles')
subplot(3,1,3);loglog(cr(1:np-1),pn(1:np-1))
xlabel('logarithm of the # of particles as a function of the logarithm of the radius')

fl_window_init(nf1,'Figure');
fl_window_init(nf2,'Figure');
