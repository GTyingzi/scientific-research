function EAStruct = EA_Sort(EAStruct)



for i=1:1:length(EAStruct.Individuals)-1
	for j=i+1:1:length(EAStruct.Individuals)
		if (EAStruct.Individuals(i).fitness < EAStruct.Individuals(j).fitness)
            
			help = EAStruct.Individuals(i);
			EAStruct.Individuals(i) = EAStruct.Individuals(j);
			EAStruct.Individuals(j) = help;
           
		end
	end
end

