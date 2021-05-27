function [out]=denois2D(in, param, method, q )


	if (nargin<4), q=MakeQMF('daubechies',10); end;
	if (nargin<3), method='multifpump'; end;
	if (nargin<2), 
		if (method=='visushrink')
			param=1;
		elseif (method=='multifpump')
			param=0.5;
		end;
	end;
	
	
	nbsc=floor(log2(max(size(in))));
	[wtin,wti,wtl,siz]=FWT2D(in,nbsc,q);

	if ( strcmp(method,'visushrink') ),

		wtout=WT2DShrink(wtin,param);
		
	elseif (strcmp(method,'multifpump')),
		wtout=WT2DPump(wtin,param);
	end;

	out=IWT2D(wtout);
   out=out(1:siz(1),1:siz(2));
		
