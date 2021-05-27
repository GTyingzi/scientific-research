function[x3,wc3]=fracinterp(in,n1,n_fin,lambda,filtre,nombre,size_ond,showWaitbars)

if nargin == 7
    showWaitbars = 1;
end

% x = IWT_SBS(wc,1,qmf,dqmf);
% figure;plot(x);hold;plot(in,'r.');title('preuve de la reconstruction')

nb=1;

marq=0;
if showWaitbars h = fl_waitbar('init'); end
for l=1:nombre
    if showWaitbars fl_waitbar('view',h,l,nombre); end

    [a,b]=size(in);
    if a>b
        in=in';
        marq=1;
    end


    if size_ond==0
        [qmf,dqmf] = MakeBSFilter(filtre);
        wc = FWT_SBS(in,1,qmf,dqmf);

        N=length(in);
        n=floor(log2(length(in)));
        matrice1=zeros(n,2^(n-1));
        for j=1:1:n
            matrice1(j,1:2^(j-1))=wc(2^(j-1)+1:2^(j));
        end;
        wc2=wc;

        for t=n:n+nb-1
            wc2=[wc2  zeros(1,2^(t))];
        end

    else
        N=length(in);
        q=MakeQMF(filtre,size_ond);
        n=floor(log2(max(size(in))));
        [wc,wti,wtl,siz] =FWT(in,n,q);
wc;
        for sc=1:n,
            matrice1(n-sc+1,1:length(wc(wti(sc):(wti(sc)+wtl(sc)-1))))...
                =(wc(wti(sc):(wti(sc)+wtl(sc)-1)));
        end;
        
        wc2=wc;

        for t=n:n+nb-1
            wc2=[wc(1:(end-2^n)),zeros(1,2^(t)),wc((end-2^n+1):end)];
        end
        

    end




    wc;
    matrice1;

    %wc2=[wc zeros(1,2^(n+nb-1))];

    




    n2=n+nb;
    matrice2=zeros(n2,2^(n2-1));
    for j=1:1:n2
        matrice2(j,1:2^(j-1))=wc2(2^(j-1)+1:2^(j));
    end;




    %x2 = IWT_SBS(wc2,1,qmf,dqmf);
    %figure;plot(x2);hold on;plot(2*[1:N]-1,in,'k');plot(x2,'r.');title('preuve de l interpolation')

    %Attention regression jusqu'au niveau 2 (pas le niveau 1 !)


    % redondance
    for j=1:n
        for k=1:2^(j-1)
            matrice3(j,1+(k-1)*floor(2^(n-1)/2^(j-1)):(k)*floor(2^(n-1)/2^(j-1)))=matrice1(j,k);
        end;
    end
    matrice3;

    for k=1:2^(n-1)
        for j=1:n
            vecteur1{k}(j)=matrice3(j,k);
        end
        vecteur1{k};
    end



    eps1=0.001;
    eps2=eps1;
    eps3=eps1;
    index1=[];
    for k=1:2^(n-1)
        vecteur_reg1{k}=[n1:n_fin]; %attention 2<n1<n
        vecteur1{k}=vecteur1{k}(n1:n_fin);
        if abs(vecteur1{k}(end))>=eps1 | abs(vecteur1{k}(end-1))>=eps2
            for t=length(vecteur1{k}):-1:1
                if abs(vecteur1{k}(t))<=eps3
                    vecteur1{k}(t)=[];
                    vecteur_reg1{k}(t)=[];
                end;
            end;
            if length(vecteur1{k})>=2 % & (length([n1:n])-length(vecteur1{k}))>=n2
                index1=[index1 k];
            end;
        end;
    end;

    %Regression sur la totalité des coeffs
    for k=index1
        vecteur_reg1{k};
        %figure;plot(vecteur_reg1{k},log2(abs(matrice3(vecteur_reg1{k},k))),'bo');title(num2str(k))
        [a_hat,b_hat]=monolr(vecteur_reg1{k},log2(abs(matrice3(vecteur_reg1{k},k))));
        pente1(k)=a_hat;
        ordo(k)=b_hat;
    end

    %pente1
    %k=31;figure;plot(vecteur{k},log2(abs(matrice3(vecteur{k},k))),'ko');

    matrice6(1:n,1:2^(n-1))=matrice1;
    matrice6(n+1,1:2^n)=0;

    matrice7(1:n,1:2^(n-1))=matrice1;
    matrice7(n+1,1:2^n)=0;

    % pente_neg=0;
    % pente_pos=0;

    for k=index1

        %if pente1(k)~=0 % si la pente trouvée est non nulle alors
        if pente1(k)<-1/2


            if sign(matrice1(n,k))>0 & in(2*k)>in(min(2*k+1,N))
                matrice6(n+1,2*k-1) = 0;'cas 1';
                matrice6(n+1,2*k) = lambda*sign(matrice1(n,k))*2^(pente1(k)*(n+1)+ordo(k));
            end;
            if sign(matrice1(n,k))<0 & in(2*k)>=in(min(2*k+1,N))
                matrice6(n+1,2*k) = 0;'cas 2';
                matrice6(n+1,2*k-1) = lambda*sign(matrice1(n,k))*2^(pente1(k)*(n+1)+ordo(k));
            end;
            if sign(matrice1(n,k))>0 & in(2*k)<=in(min(2*k+1,N))
                matrice6(n+1,2*k) = 0;'cas 3';
                matrice6(n+1,2*k-1) = lambda*sign(matrice1(n,k))*2^(pente1(k)*(n+1)+ordo(k));
            end;
            if sign(matrice1(n,k))<0 & in(2*k)<in(min(2*k+1,N))
                matrice6(n+1,2*k-1) = 0;'cas 4';
                matrice6(n+1,2*k) = lambda*sign(matrice1(n,k))*2^(pente1(k)*(n+1)+ordo(k));
            end;
        end;
    end;

    n2=n+nb;
    %matrice2=zeros(n2,2^(n2-1));
   


    % for t=n+2:n2
    %     for k=1:2^(t-1)-1
    %     matrice6(t,2*k-1:2*k)=matrice6(t-1,k);
    %     end;
    % end


    if size_ond==0
        wc3=wc2;
        for j=1:1:n2
            wc3(2^(j-1)+1:2^(j))=matrice6(j,1:2^(j-1));
        end;  
        x3 = IWT_SBS(wc3,1,qmf,dqmf);
    else
         [wc3,wti3,wtl3,siz3]=FWT([in,in],2*n,q);
wc3=wc2;
wc3(1)=2^(n+1);
wc3(2)=n+1;
v=length(wc);
matrice6(n-sc+1,1:end);
wc3(v-2^n+1:v)=matrice6(n-sc+1,1:end);
%         for sc=1:n,
%             wc3(wti3(sc):(wti3(sc)+wtl3(sc)-1))...
%             =matrice6(n-sc+1,1:end);
%         end;
        wc2;
        wc3;
        x3 = IWT(wc3);
        
    end
    in=x3;
    %matrice1
    %matrice6
    
end

if marq==1
    x3=x3';
end
if showWaitbars fl_waitbar('close',h); end

%figure;plot(x3,'k');hold on;plot(2*[1:N]-1,in,'b');plot(x2,'g.');plot(x3,'r.');title('notre interpolation')
