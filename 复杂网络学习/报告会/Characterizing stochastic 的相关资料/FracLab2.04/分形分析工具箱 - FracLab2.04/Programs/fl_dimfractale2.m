function [dim,handlefig]=fl_dimfractale2(f,Nepsilonmin,Nepsilonmax,a,b,reg,RegParam)


s=size(f);
N=s(1);

pas=(b-a)/N;

%epsilonend=(b-a)/N

%V=zeros(nbpoints,1);

V=zeros(Nepsilonmax,2);

oscillation=fl_oscillation2(f,Nepsilonmax,a,b);

%pas=abs(epsilonend-epsilonstart)/nbpoints;

h_waitbar = fl_waitbar('init');
for(i=1:Nepsilonmax)
    fl_waitbar('view',h_waitbar,i,Nepsilonmax);
    epsilon=i*pas;
    V(i,1)=log(1/epsilon);
    V(i,2)=log((1/(epsilon*epsilon))*fl_variations(f,i,oscillation,a,b));
end
fl_waitbar('close',h_waitbar);
 

%figure; plot(V(Nepsilonmin:Nepsilonmax,1),V(Nepsilonmin:Nepsilonmax,2));

%dim=regression(V(Nepsilonmin:Nepsilonmax,2),V(Nepsilonmin:Nepsilonmax,1));
[dim,handlefig]=fl_regression(V(Nepsilonmin:Nepsilonmax,1)',V(Nepsilonmin:Nepsilonmax,2)','a_hat','BoxDimension',reg,RegParam);