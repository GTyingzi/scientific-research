function new_structure = DistMap_Tool_set_value_to_cell(structure, indexvector, value)

new_structure = structure;

pos_str = '';
for h=1:1:size(indexvector,2)
	pos_str = [pos_str num2str(indexvector(h))];
	if (h < size(indexvector,2))
		pos_str = [pos_str ','];
	end
end

eval(['new_structure{' pos_str '}=value;']);