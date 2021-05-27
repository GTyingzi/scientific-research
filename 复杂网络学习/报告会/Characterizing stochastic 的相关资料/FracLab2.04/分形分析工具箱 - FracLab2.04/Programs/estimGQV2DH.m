function [H_max_reg, G_max_reg, H_max, H_reg] = estimGQV2DH(x,gamma,delta,k1,k2)
%   estimGQV2DH
%   Generalized Quadratic Variations based Estimation of the Holder function of 2D mBm
%   Olivier Barrière
%   January 2006
%
%   Estimates the the Holder function of a 2-D signal using the
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
%   o  x : Real matrix [N1,N2]
%      2-D signal
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
%   o  H_max_reg : Real matrix [N1,N2]
%      Estimator of the Holder function, using both regression and GQV
%
%   o  G_max_reg : Real matrix [N1,N2]
%      Estimator of the scale factor
%
%   2.  See also:
%
%   estimGQV1DH


%function [H, H_max, H_reg, H_max_reg, G_reg, G_max_reg] = estimGQV2DH(x,gamma,delta,k1,k2)
%function [H, H_max, H_moy, H_reg, H_max_reg_global, H_max_reg_local] = estimGQV2DH(x,gamma,delta,k1,k2)
%function H_max_reg_local = estimGQV2DH(x,gamma,delta,k1,k2)


[N1, N2] = size(x);
N = N1*N2; %sqrt(N1*N2);
d=2;
nb_zones = 7;

%delta*b < gamma < delta+1/2
%Choix de base = 1 / 1  => meilleur choix ??
%gamma = 0.8;
%delta = 1;


%disp('Calcul de V...');
avancement = 0;
pq=5;

Dk = k2-k1+1;
%V = zeros(N1,N2,k2);
V = NaN*ones(N1,N2,k2);

h_waitbar = fl_waitbar('init');

%Moyennage après calcul des Vn
for k=k1:k2
	if Dk>1 
		fl_waitbar('view',h_waitbar,k/2,Dk);  %Première étape qui va jusqu'à la moitié de la barre de progresssion
	end
	N1_k=floor(N1/k);
	N2_k=floor(N2/k);
	for indi = 1:k
		for indj = 1:k
			V([indi:k:N1],[indj:k:N2],k)=GQV2D(x([indi:k:N1],[indj:k:N2]),gamma,delta);
		end
	end
	%Moyennage avant régression (par blocs)
	%if k~=1
	%	for i=0:k:N1-k
	%		for j=0:k:N2-k
	%			V([i+1:i+k],[j+1:j+k],k)=nanmean(nanmean(V([i+1:i+k],[j+1:j+k],k)))*ones(k);		
	%		end
	%		%reste de la division euclidienne entre k*N_k+1 et N (eventuellement) (sur les bords)
	%		V([i+1:i+k],k*N2_k+1:N2,k)=nanmean(nanmean(V([i+1:i+k],k*N2_k+1:N2,k)))*ones(k,N2-k*N2_k);
	%		V(k*N1_k+1:N1,[i+1:i+k],k)=nanmean(nanmean(V(k*N1_k+1:N1,[i+1:i+k],k)))*ones(N1-k*N1_k,k);
	%	end
	%	%et dans le coin en bas à droite
	%	V(k*N1_k+1:N1,k*N2_k+1:N2,k)=nanmean(nanmean(V(k*N1_k+1:N1,k*N2_k+1:N2,k)))*ones(N1-k*N1_k,N2-k*N2_k);
	%end
end


%%Moyennage par blocs avant calcul des Vn
%for k=k1:k2
%	N1_k=floor(N1/k);
%	N2_k=floor(N2/k);
%	%Moyennage par blocs
%	if k~=1
%		for i=0:k:N1-k
%			for j=0:k:N2-k
%				xx([i+1:i+k],[j+1:j+k])=nanmean(nanmean(x([i+1:i+k],[j+1:j+k])))*ones(k);		
%			end
%			%reste de la division euclidienne entre k*N_k+1 et N (eventuellement) (sur les bords)
%			xx([i+1:i+k],k*N2_k+1:N2)=nanmean(nanmean(x([i+1:i+k],k*N2_k+1:N2)))*ones(k,N2-k*N2_k);
%			xx(k*N1_k+1:N1,[i+1:i+k])=nanmean(nanmean(x(k*N1_k+1:N1,[i+1:i+k])))*ones(N1-k*N1_k,k);
%		end
%		%et dans le coin en bas à droite
%		xx(k*N1_k+1:N1,k*N2_k+1:N2)=nanmean(nanmean(x(k*N1_k+1:N1,k*N2_k+1:N2)))*ones(N1-k*N1_k,N2-k*N2_k);
%	else
%		xx=x;
%	end
%	%Image "pré-moyennée"
%	%figure; imagesc(xx);
%	
%	
%	%Une seule image pour "un point sur k" => un seul appel à GQV
%	V([1:k:N1],[1:k:N2],k)=GQV2D(xx([1:k:N1],[1:k:N2]),gamma,delta);
%
%	%Remplissage de V aux autres endroits, par blocs....
%	if k~=1
%		for i=0:k:N1-k
%			for j=0:k:N2-k
%				V([i+1:i+k],[j+1:j+k],k)=V(i+1,j+1,k)*ones(k);		
%			end
%			%reste de la division euclidienne entre k*N_k+1 et N (eventuellement) (sur les bords)
%			V([i+1:i+k],k*N2_k+1:N2,k)=V(i+1,j+1,k)*ones(k,N2-k*N2_k);
%			V(k*N1_k+1:N1,[i+1:i+k],k)=V(i+1,j+1,k)*ones(N1-k*N1_k,k);
%		end
%		%et dans le coin en bas à droite
%		V(k*N1_k+1:N1,k*N2_k+1:N2,k)=V(i+1,j+1,k)*ones(N1-k*N1_k,N2-k*N2_k);
%	end
%end
%

%Moyennage par filtre moyenneeur avant calcul des Vn
%NE MARCHE PAS ! Il _faut_ une image de taille inférieure pour permettre la régression !
%for k=k1:k2
%	N1_k=floor(N1/k);
%	N2_k=floor(N2/k);
%	%xx = imfilter(x,fspecial('average',[k,k])); %trop d'effets de bord
%	if k~=1
%		for i=1:N1
%			if floor(k/2) == k/2
%				imin = max(i-k/2+1,1);
%				imax = min(i+k/2,N1);
%			else
%				imin = max(i-(k-1)/2,1);
%				imax = min(i+(k-1)/2,N1);
%			end
%			for j=1:N2
%				if floor(k/2) == k/2
%					jmin = max(j-k/2+1,1);
%					jmax = min(j+k/2,N2);
%				else
%					jmin = max(j-(k-1)/2,1);
%					jmax = min(j+(k-1)/2,N2);					
%				end
%				xx(i,j)=nanmean(nanmean(x([imin:imax],[jmin:jmax])));
%			end
%		end
%	else
%		xx=x;
%	end
%	
%	%Image "pré-moyennée"
%	figure; imagesc(xx);
%	
%	V(:,:,k)=GQV2D(xx,gamma,delta);
%end





for k=k1:k2
	H(:,:,k) = 1/(2*delta)*(d*(1-gamma)-log2(V(:,:,k))./log2(N/k^2));
end

%Valeur de H obtenue directement par la formule
H_max = H(:,:,k1);

%Moyenne des H pour différentes valeurs de N
%H_moy = nanmeandim(H,3);



%Regression pour obtenir une valeur de H plus robuste
if Dk>1 
	%disp('Regression...');
	for k=k1:k2
		t(k) = log2(N/k^2);
	end
	
	for i=1:N1
		fl_waitbar('view',h_waitbar,1/2*(N1) + i/2,N1);  %Deuxième étape
		
		for j=1:N2
			for k=k1:k2
				log2V (k)= log2(V(i,j,k));
			end
				%t1=polyfit(t(k1:k2),log2V(k1:k2),1);
				%alpha0 = t1(2);
				%alpha1 = t1(1);
				[alpha1, alpha0] = monolr(t(k1:k2),log2V(k1:k2));
				G_reg(i,j) = 2^(alpha0/2);
				H_reg(i,j) =  (alpha1-d*(1-gamma))/(-2*delta); %(alpha1)/(-2*delta);
		end
    end
	

    moy_reg = fl_tendance(H_reg,nb_zones);
    moy_max = fl_tendance(H_max,nb_zones);
    H_max_reg=H_max-moy_max+moy_reg;	
    
	
% 	%%Alignement de la moyenne globale avec celle de la regression
% 	%moy_reg = nanmean(nanmean(H_reg));
% 	%moy_max = nanmean(nanmean(H_max));
% 	%moy_moy = nanmean(nanmean(H_moy));
% 	%H_max_reg_global = (H_max-moy_max+moy_reg);
% 	%H_moy_reg_global = (H_moy-moy_moy+moy_reg);
% 	
% 	%%Moyenne locale
% 	%disp('Moyenne locale...');
% 	for i=1:N1
% 		fl_waitbar('view',h_waitbar,2/3*(N1) + i/3,N1);  %Troisième étape
% 		
% 		for j=1:N2
% 			x_i = i/N1;
% 			y_j = j/N2;
% 			
% 			large = 2;
% 			
% 			p_min = ceil(N1^delta*(x_i-N1^(-gamma/large)));
% 			p_max = floor(N1^delta*(x_i+N1^(-gamma/large)));
% 			
% 			q_min = ceil(N2^delta*(y_j-N2^(-gamma/large)));
% 			q_max = floor(N2^delta*(y_j+N2^(-gamma/large)));
% 			
% 			v(1) = max(p_min,1);
% 			v(2) = min(p_max,N1);
% 			v(3) = max(q_min,1);
% 			v(4) = min(q_max,N2);
% 			
% 			moy_reg = nanmean(nanmean(H_reg(v(1):v(2),v(3):v(4))));
% 			moy_max = nanmean(nanmean(H_max(v(1):v(2),v(3):v(4))));			
% 			
% 			H_max_reg(i,j)=H_max(i,j)-moy_max+moy_reg;
% 			
% 		end
% 	end
	
	%Calcul de la fonction multiplicative, G
	G_max_reg = N.^((H_max_reg-H_max));
else    
	H_max_reg = H_max;
	G_max_reg = ones(N1,N2);
end

fl_waitbar('close',h_waitbar);




function [V]=GQV2D(x,gamma,delta)

[N1, N2] = size(x);
V = zeros(N1,N2);
for i=1:N1
	for j=1:N2
		%Voisinage v_N(ti) = {p_i / 0<=p_i<=N-2 et |t_i-p_i/N^delta|<=N^-gamma}
		%Il suffit de calculer p_min et p_max pour chaque i
		x_i = (i-1)/N1;
		y_j = (j-1)/N2;
		N1_delta = N1^(1-delta);
		N2_delta = N2^(1-delta);
		
		
		p_min = ceil(N1^delta*(x_i-N1^(-gamma)));
		p_max = floor(N1^delta*(x_i+N1^(-gamma)));
		
		q_min = ceil(N2^delta*(y_j-N2^(-gamma)));
		q_max = floor(N2^delta*(y_j+N2^(-gamma)));
		
		
		v(1) = max(p_min,1);
		v(2) = min(p_max,N1-2);
		v(3) = max(q_min,1);
		v(4) = min(q_max,N2-2);
		

		for p = v(1):v(2)
			for q = v(3):v(4)
				%  1 -2  1
				% -2  4 -2 
				%  1 -2  1
				p0 = min(max(round(N1_delta*(p)),1),N1);
				p1 = min(max(round(N1_delta*(p+1)),1),N1);
				p2 = min(max(round(N1_delta*(p+2)),1),N1);
				q0 = min(max(round(N2_delta*(q)),1),N2);
				q1 = min(max(round(N2_delta*(q+1)),1),N2);
				q2 = min(max(round(N2_delta*(q+2)),1),N2);
				
				V(i,j)=V(i,j)+(x(p0,q0)-2*x(p1,q0)+x(p2,q0)   -2*x(p0,q1)+4*x(p1,q1)-2*x(p2,q1)  +x(p0,q2)-2*x(p1,q2)+x(p2,q2) )^2;
			end
		end
		if V(i,j) == 0
			V(i,j) = NaN;
		end
	end
end

