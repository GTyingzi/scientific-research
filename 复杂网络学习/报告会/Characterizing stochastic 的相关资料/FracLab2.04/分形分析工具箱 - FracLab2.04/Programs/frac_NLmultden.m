function [out] = frac_NLmultden(in, param, lam, wavelet, siz, start_level)




N=length(in);
q=MakeQMF(wavelet,siz);
n=floor(log2(N));



[wt,wti,wtl,siz] =FWT(in,n,q);

% standart deviation estimation

% t=[wti(1):(wti(1)+wtl(1)-1)];
% sig=median(t)/0.6745;

sig=(median(abs(wt(wti(1):(wti(1)+wtl(1)-1)))))/0.6745;

t=findobj('Tag','Fig_gui_fl_multden3');
if ~isempty(t)
    %NLP_fig=gcf;
    sigtext=num2str(sig);
    set(findobj(t,'tag','EditText_multden3_sigma'),'String',sigtext);
end





if isempty(lam)
lam=(sig)*2^(-n/2)*sqrt(2*n);
set(findobj(t,'tag','EditText_multden3_lambdashift'),'String',num2str(lam));
end

wt2=wt;
for sc=1:n-start_level
    for k=(wti(sc):(wti(sc)+wtl(sc)-1))
     wt2(k) =wt2(k).*((abs(wt2(k))>lam)+(abs(wt2(k))<lam)*2^(-((n-sc+1)*param)));
 end
end;


out=IWT(wt2);