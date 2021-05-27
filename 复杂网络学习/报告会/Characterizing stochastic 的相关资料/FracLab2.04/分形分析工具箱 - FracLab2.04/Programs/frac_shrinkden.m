function [out]=frac_shrinkden(in,trshld,niveau,type_ond,siz1,mode)

if (nargin<3), niveau=floor(log2(length(in))/2); end;
if (nargin<4), type_ond='Daubechies'; end;
if (nargin<5), siz1=10; end;
if (nargin<6), mode='soft'; end;

q=MakeQMF(type_ond,siz1);
n=floor(log2(max(size(in))));
[wt,wti,wtl,siz] =FWT(in,n,q);
wtout=wt;



% standart deviation estimation

%t=[wti(1):(wti(1)+wtl(1)-1)];

sig=(median(abs(wt(wti(1):(wti(1)+wtl(1)-1)))))/0.6745;
%sig=median(t)/0.6745;



   t=findobj('Tag','Fig_gui_fl_shrinkden2');
   if ~isempty(t)
    shrink_fig=gcf;
    sigtext=num2str(sig);
    set(findobj(shrink_fig,'tag','EditText_shrinkden2_sigma'),'String',sigtext);
   end


% shrink_fig=gcf;
% sigtext=num2str(sig);
% set(findobj(shrink_fig,'tag','EditText_shrinkden2_sigma'),'String',sigtext);


if isempty(trshld)
trshld=(sig)*2^(-n/2)*sqrt(2*n);
if ~isempty(t)
set(findobj(shrink_fig,'tag','EditText_shrinkden2_alphashift'),'String',num2str(trshld));
end
end


if mode=='soft'
  for sc=1:(n-niveau+1),
	wtout( wti(sc):(wti(sc)+wtl(sc)-1) ) ...
        = theshrinksoft(wt(wti(sc):(wti(sc)+wtl(sc)-1)), trshld);
  end; 
end;
if mode=='hard'
  for sc=1:(n-niveau+1),
	wtout( wti(sc):(wti(sc)+wtl(sc)-1) ) ...
        = theshrinkhard(wt(wti(sc):(wti(sc)+wtl(sc)-1)), trshld);
  end;  
end;


out=IWT(wtout);
out=out(1:siz);


function [out] = theshrinksoft(in,s)
	tmp = abs(in)-s;
	out = tmp .* sign(in) .* (tmp>0);
    
function [out] = theshrinkhard(in,s)
	tmp = abs(in);
	out = tmp .* sign(in) .* (tmp>s);    