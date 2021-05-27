function [out]=frac_multden2D(in,param,lam,wavelet,siz,start_level)

q=MakeQMF(wavelet,siz);
n=floor(log2(max(size(in))));
d=lam;
[wt,wti,wtl,siz] =FWT2D(in,n,q);


% standart deviation estimation

% t=[wti(1,1):(wti(1,1)+wtl(1,1)*wtl(1,2)-1),wti(1,2):(wti(1,2)+wtl(1,1)*wtl(1,2)-1),wti(1,3):(wti(1,3)+wtl(1,1)*wtl(1,2)-1)];
% sig=median(t)/0.6745;

sig=(median(abs(wt(wti(1):(wti(1)+wtl(1)-1)))))/0.6745;

t=findobj('Tag','Fig_gui_fl_multden3');
if ~isempty(t)
    
    sigtext=num2str(sig);
    set(findobj(t,'tag','EditText_multden3_sigma'),'String',sigtext);
end

if isempty(lam)
 lam=(sig)*2^(-n/2)*sqrt(2*n);
 set(findobj(t,'tag','EditText_multden3_lambdashift'),'String',num2str(lam));
end


%%%%%%%%%%%%%%%%%%%%%%%%%
wtout=wt;
for sc=1:n-start_level,
    for j=1:3,
      wtout( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ) ...
	   = the2dpump(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ), ...
	  2.^(-param*(n-sc+1)),lam);
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
out=IWT2D(wtout);
out=out(1:siz(1),1:siz(2));


function [out] = the2dpump(in,s,lam)
out = in.*((abs(in)>lam)+(abs(in)<lam).*s);




% function [out] = frac_NLmultden(in, param, trshld, wavelet, siz)
% 
% 
% N=length(in);
% q=MakeQMF(wavelet,siz);
% n=floor(log2(N));
% 
% 
% 
% [wt,wti,wtl,siz] =FWT(in,n,q);
% 
% % standart deviation estimation
% 
% t=[wti(1):(wti(1)+wtl(1)-1)];
% sig=median(t);
% 
% 
% 
% if isempty(trshld)
% lam=(sig)*2^(-n/2)*sqrt(2*n);
% end
% 
% wt2=wt;
% for sc=1:n
%     for k=(wti(sc):(wti(sc)+wtl(sc)-1))
%      wt2(k) =wt2(k).*((abs(wt2(k))>lam)+(abs(wt2(k))<lam)*2^(-((n-sc+1)*param)));
%  end
% end;
% 
% 
% out=IWT(wt2);