function [H_max_reg, G_max_reg, H_reg, H_max] = estimGQV1DH(x,gamma,delta,k1,k2)
%   estimGQV1DH
%   Generalized Quadratic Variations based Estimation of the Holder function of mBm
%   Olivier Barrière
%   January 2006
%
%   Estimates the the Holder function of a 1-D signal using the
%   Generalized Quadratic Variations
%
%   1.  Usage
%
%   ______________________________________________________________________
%   [H_max_reg, G_max_reg] = estimGQV1DH(x,gamma,delta,k1,k2)
%   ______________________________________________________________________
%
%   1.1.  Input parameters
%
%   o  x : Real vector [1,N]
%      1-D signal
%
%   o  gamma :  Real in [0,1]
%      First parameter of the Generalized Quadratic Variations neighboorhoods :
%      v_N(ti) = {p_i / 0<=p_i<=N-2 et |t_i-p_i/N^delta|<=N^-gamma}
%
%   o  delta :  Real in [0,1]
%      Second parameter of the Generalized Quadratic Variations neighboorhoods :
%      v_N(ti) = {p_i / 0<=p_i<=N-2 and |t_i-p_i/N^delta|<=N^-gamma}
%
%   o  k1 :  Positive integer
%      Initial sub-sampling for the regression : 1 point out of k1
%
%   o  k2 :  Positive integer
%      Final sub-sampling for the regression : 1 point out of k2
%
%
%   1.2.  Output parameters
%
%   o  H_max_reg : Real vector [1,N]
%      Estimator of the Holder function, using both regression and GQV
%
%   o  G_max_reg : Real vector [1,N]
%      Estimator of the scale factor
%
%   2.  See also:
%
%   estimGQV2DH, DWTestim_all, exposc3
%
%   3.  Examples
%
%   % signal synthesis
%   N=1024; t=linspace(0,1,N); Ht=eval('0.5+0.3*sin(4*pi*t)');
%   mBm0=mBmQuantifKrigeage(N,10,Ht,1,1);
%   G = exp(linspace(1,log(100),N))';
%   %estimation
%   [H_mBm0,G_mBm0]=estimGQV1DH(G.*mBm0,0.6,1,1,5);

%function [H, H_max, H_reg, H_max_reg, G_reg, G_max_reg, G_cov, moy_max, moy_reg, moy_max_reg] = estimGQV1DH(x,gamma,delta,k1,k2)
%function [H, H_max, H_reg, H_max_reg, H_reg_moy, H_max_reg_align, G_reg, G_max_reg, G_reg_moy] = estimGQV1DH(x,gamma,delta,k1,k2)



N = length(x);

%delta*b < gamma < delta+1/2
%Choix de base = 1 / 1  => meilleur choix ??
%gamma = 0.8;
%delta = 1;
%k1 = 1;
%k2 = 4;
nb_zones = 10;

Dk = k2-k1+1;
V = NaN*ones(N,k2);

%disp('Calcul de V...');

h_waitbar = fl_waitbar('init');

for k=k1:k2
	if Dk>1 
		%fl_waitbar('view',h_waitbar,k/3,Dk);  %Première étape qui va jusqu'au tiers de la barre de progresssion
        fl_waitbar('view',h_waitbar,k/2,Dk);  %Première étape qui va jusqu'à la moitié de la barre de progresssion
	end
	N_k=floor(N/k);
	for ind = 1:k
		V([ind:k:N],k)=GQV1D(x([ind:k:N]),gamma,delta);
	end
	%%Moyennage avant régression (par blocs)
	%if k~=1
	%	for i=0:k:N-k
	%		V([i+1:i+k],k)=nanmean(V([i+1:i+k],k))*ones(1,k);
	%	end
	%	%reste de la division euclidienne entre k*N_k+1 et N (eventuellement)
	%	V(k*N_k+1:N,k)=nanmean(V(k*N_k+1:N))*ones(1,N-k*N_k);
	%end
end


for k=k1:k2
	H(:,k) = 1/(2*delta)*((1-gamma)-log2(V(:,k))./log2(N/k));
end

%Valeur de H obtenue directement par la formule
H_max = H(:,k1);

%Moyenne des H pour différentes valeurs de N
%H_moy = nanmean(H')';

%Regression pour obtenir une valeur de H plus robuste
if Dk>1 
	for k=k1:k2
		t(k) = log2(N/k);
	end
	%disp('Regression...');
	for i=1:N
		%fl_waitbar('view',h_waitbar,1/3*(N) + i/3, N);  %Deuxième étape		
		fl_waitbar('view',h_waitbar,1/2*(N) + i/2, N);  %Deuxième étape		
        
		%t1=polyfit(t(k1:k2),log2(V(i,k1:k2)),1);				
		%alpha0 = t1(2);
		%alpha1 = t1(1);
		[alpha1, alpha0] = monolr(t(k1:k2),log2(V(i,k1:k2)));
		G_reg(i) = 2^(alpha0/2);
		H_reg(i) = (alpha1-(1-gamma))/(-2*delta); %(alpha1)/(-2*delta);
	end
	
	G_reg = G_reg';
	H_reg = H_reg';
	
	%Recentrage de H_reg entre 0 et 1 >>> En vue de générer des mbm après...   sens mathématique ???
	%if max(H_reg)<0
	%	H_reg = H_reg - min(H_reg)
	%end
	
	%if min(H_reg)<0 && max(H_reg)>0
	%	amplitude = max(H_reg)-min(H_reg);
	%	H_reg = ((H_reg - min(H_reg)))/amplitude*max(H_reg);
	%end
	
	%if max(H_reg)>1
	%	amplitude = max(H_reg)-min(H_reg);
	%	H_reg = 1 + ((H_reg - max(H_reg)))/amplitude*(1-min(H_reg));	 
	%end
	
	
	%Alignement de la moyenne globale avec celle de la regression
	%moy_reg = nanmean(H_reg);
	%moy_max = nanmean(H_max);
	%moy_moy = nanmean(H_moy);
	
	%H_max_reg = (H_max-moy_max+moy_reg);
	%H_moy_reg = (H_moy-moy_moy+moy_reg);
	
	%Moyenne locale
	%H_max_reg = zeros(N,1);
	%H_moy_reg = zeros(N,1);

    moy_reg = fl_tendance(H_reg,nb_zones)';
    moy_max = fl_tendance(H_max,nb_zones)';
    H_max_reg=H_max-moy_max+moy_reg;
    
    G_max_reg = N.^((H_max_reg-H_max));
    
% 	%disp('Moyenne locale...');
% 	x_acc = [0; diff(x)]; %taille N !
% 	for i=1:N
% 		fl_waitbar('view',h_waitbar,2/3*(N) + i/3, N);  %Troisième étape
% 		
% 		t_i = i/N;
% 		N_delta = N^(1-delta);
% 		%large = 10/abs(gamma-1); %1/(gamma-1)^2 %10 %100 (autres possibilités...)
% 		large = 3;
% 		
% 		p_min = ceil(N^delta*(t_i-N^(-gamma)));
% 		p_max = floor(N^delta*(t_i+N^(-gamma)));
% 		%p_min_large = ceil(N^delta*(t_i-large*N^(-gamma)));
% 		%p_max_large = floor(N^delta*(t_i+large*N^(-gamma)));
% 		p_min_large = ceil(N^delta*(t_i-N^(-gamma/large)));
% 		p_max_large = floor(N^delta*(t_i+N^(-gamma/large)));
% 		v(1) = max(p_min,1);
% 		v(2) = min(p_max,N);
% 		v_large(1) = max(p_min_large,1);
% 		v_large(2) = min(p_max_large,N);
% 		
% 		%moy_reg(i) = nanmean(H_reg(v_large(1):v_large(2)));
% 		%moy_max(i) = nanmean(H_max(v_large(1):v_large(2)));
% 		%moy_moy = nanmean(H_moy(v(1):v(2)));
% 		
% 		
% 		%H_reg_moy(i) = moy_reg; %nanmean(H_reg(v(1):v(2)));
% 		%H_max_reg(i)=H_max(i)-moy_max(i)+moy_reg(i);
% 		%H_moy_reg(i)=H_moy(i)-moy_moy+moy_reg;
% 		
% 		%G_reg_moy(i) = nanmean(G_reg(v_large(1):v_large(2)));
% 		
% 		%Autre méthode d'estimation de G, en utilisant la variance instantanée des accroissements
% 		X_cov_estimee = cov(x_acc(v(1):v(2)));
% 		X_cov_theorique = (N-1)^(-2*H_max_reg(i));
% 		G_cov(i) = 2*sqrt(X_cov_estimee/X_cov_theorique);
%     end


    
% 	for i=1:N
% 		t_i = i/N;
% 		N_delta = N^(1-delta);
% 		%large = 10/abs(gamma-1); %1/(gamma-1)^2 %10 %100 (autres possibilités...)
% 		large = 3;
% 		
% 		p_min = ceil(N^delta*(t_i-N^(-gamma)));
% 		p_max = floor(N^delta*(t_i+N^(-gamma)));
% 		%p_min_large = ceil(N^delta*(t_i-large*N^(-gamma)));
% 		%p_max_large = floor(N^delta*(t_i+large*N^(-gamma)));
% 		p_min_large = ceil(N^delta*(t_i-N^(-gamma/large)));
% 		p_max_large = floor(N^delta*(t_i+N^(-gamma/large)));
% 		v_large(1) = max(p_min_large,1);
% 		v_large(2) = min(p_max_large,N);
% 		
% 		moy_max_reg(i) = nanmean(H_max_reg(v_large(1):v_large(2)));
% 	end	
% 	
% 	%%Réglage de l'amplitude de H_max_reg sur celle de H_reg ? (elimination valeur aberrantes + 5% max / 5% min)
% 	%H_reg_sort = sort(H_reg,1);
% 	%H_max_reg_sort = sort(H_max_reg,1);
% 	%min_H_reg = mean(H_reg_sort(1+round(N/100):round(5*N/100)));
% 	%max_H_reg = mean(H_reg_sort(round(95*N/100):round(99*N/100)));
% 	%min_H_max_reg = mean(H_max_reg_sort(1+round(N/100):round(5*N/100)));
% 	%max_H_max_reg = mean(H_max_reg_sort(round(95*N/100):round(99*N/100)));
% 	%amplitude_H_reg = max_H_reg - min_H_reg;
% 	%amplitude_H_max_reg = max_H_max_reg - min_H_max_reg;
% 	%
% 	%H_max_reg_align = ((H_max_reg - min_H_max_reg)/amplitude_H_max_reg)*amplitude_H_reg+min_H_reg;
% 	
% 	%Calcul de la fonction multiplicative, G
% 	G_max_reg = N.^((H_max_reg-H_max)); %(N/2).^((H_max_reg-H_max));
% 	%G_moy = N.^((H_moy_reg-H_moy)); %(N/2).^((H_moy_reg-H_moy));
	
else
	%Pas de regression
	H_max_reg = H_max;
	G_max_reg = ones(N,1);	
end

fl_waitbar('close',h_waitbar);



function [V]=GQV1D(x,gamma,delta)

N = length(x);
V = zeros(N,1);

for i=1:N	
	%Voisinage v_N(ti) = {p_i / 0<=p_i<=N-2 et |t_i-p_i/N^delta|<=N^-gamma}
	%Il suffit de calculer p_min et p_max pour chaque i
	t_i = (i-1)/N;
	p_min = ceil(N^delta*(t_i-N^(-gamma)));
	p_max = floor(N^delta*(t_i+N^(-gamma)));
	
	N_delta = N^(1-delta);
	v(1) = max(p_min,1);
	v(2) = min(p_max,N-2);

	for p = v(1):v(2)
		p0 = min(max(round(N_delta*(p)),1),N);
		p1 = min(max(round(N_delta*(p+1)),1),N);
		p2 = min(max(round(N_delta*(p+2)),1),N);
		
		V(i)=V(i)+(x(p0)-2*x(p1)+x(p2))^2;
	end
	
	if V(i) == 0
		V(i) = NaN;
	end

end
