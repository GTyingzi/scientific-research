% --- Return coefficiens from results of WT
function result = WT_Get_Coeff(data, scale)
% data	WT results
%	scale	the scale to extract
% returns: [horz[]; diag[]; vert[]]
erg=[];

scale = data.scales - scale +1;	

for j=1:3
	erg = [erg ; data.wt(data.wti(scale,j):(data.wti(scale,j)+data.wtl(scale,1)*data.wtl(scale,2)-1)) ];
end

result = double(erg);
