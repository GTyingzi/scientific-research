function new_fitnessmap = fitnessmap_add(fitnessmap, append);

if (size(append,1)<size(append,2))
	append = append';
end

new_fitnessmap = [fitnessmap, append];