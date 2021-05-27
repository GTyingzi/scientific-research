function [out]=frac_shrinkden2D(in,trshld,niveau,type_ond,siz1,mode)


if (nargin<3), niveau=floor(log2(length(in))/2); end;
if (nargin<4), type_ond='Daubechies'; end;
if (nargin<5), siz1=10; end;
if (nargin<6), mode='soft'; end;


q=MakeQMF(type_ond,siz1);
n=floor(log2(max(size(in))));
[wt,wti,wtl,siz] =FWT2D(in,n,q);



% standart deviation estimation

% t=[wti(1,1):(wti(1,1)+wtl(1,1)*wtl(1,2)-1),wti(1,2):(wti(1,2)+wtl(1,1)*wtl(1,2)-1),wti(1,3):(wti(1,3)+wtl(1,1)*wtl(1,2)-1)];
% sig=median(t)/0.6745;

sig=(median(abs(wt(wti(1):(wti(1)+wtl(1)-1)))))/0.6745;


t=findobj('Tag','Fig_gui_fl_shrinkden2');
if ~isempty(t)
    shrink_fig=gcf;
    sigtext=num2str(sig);
    set(findobj(shrink_fig,'tag','EditText_shrinkden2_sigma'),'String',sigtext);
end

if isempty(trshld)
    trshld=(sig)*2^(-n/2)*sqrt(2*n);
    if ~isempty(t)
        set(findobj(shrink_fig,'tag','EditText_shrinkden2_alphashift'),'String',num2str(trshld));
    end;
end

%%%%%%%%%%%%%%%%%%%%%%%%%
wnbsc = WT2DNbScales(wt);
wtout=wt;
if mode=='soft'
    for sc=1:(wnbsc-niveau+1),
        for j=1:3,
            wtout( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ) ...
                = the2dshrinksoft(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ), ...
                trshld);
        end;
    end;
end;

if mode=='hard'
    for sc=1:(wnbsc-niveau+1),
        for j=1:3,
            wtout( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ) ...
                = the2dshrinkhard(wt( wti(sc,j):(wti(sc,j)+wtl(sc,1)*wtl(sc,2)-1) ), ...
                trshld);
        end;
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out=IWT2D(wtout);
out=out(1:siz(1),1:siz(2));


function [out] = the2dshrinksoft(in,s)
tmp = abs(in)-s;
out = tmp .* sign(in) .* (tmp>0);

function [out] = the2dshrinkhard(in,s)
tmp = abs(in);
out = tmp .* sign(in) .* (tmp>s);