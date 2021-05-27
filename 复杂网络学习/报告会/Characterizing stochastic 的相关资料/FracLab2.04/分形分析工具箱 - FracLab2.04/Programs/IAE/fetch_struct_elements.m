function erg = fetch_struct_elements(results, data)

elements = max(size(results));

if (isstruct(data)==0)
	results{elements+1} = cell2mat(data);
else
	
	names = fieldnames(data); 
	
	for i=1:1:max(size(names))
		results = fetch_struct_elements(results, names(i));	
	end
	
end

erg = results;