function [out]=denois(in, param, method, q )


	if (nargin<4), q=MakeQMF('daubechies',10); end;
	if (nargin<3), method='multifpump'; end;
	if (nargin<2), param=1; end;
	
	
	nbsc=floor(log2(max(size(in))));
	[wtin,wti,wtl,siz]=FWT(in,nbsc,q);

	if ( strcmp(method,'visushrink') ),

		wtout=WTShrink(wtin,param);
		
	elseif (strcmp(method,'multifpump')),
		wtout=WTPump(wtin,param);
	end;

	out=IWT(wtout);
	out=out(1:siz);	
