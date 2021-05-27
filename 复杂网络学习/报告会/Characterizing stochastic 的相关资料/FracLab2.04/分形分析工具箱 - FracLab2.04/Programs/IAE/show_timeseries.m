function H = show_timeseries(handles, data, axes_tag, options)


	if(min(size(findobj('Tag',axes_tag))) == 0)
		eval(['axes(handles.' axes_tag ')']);
		H = eval(['handles.' axes_tag]);
	else
		axes(findobj('Tag',axes_tag))
		H = findobj('Tag',axes_tag);
	end
	
	
	if (size(data,1)==1)
		data = [data;data];
	end
	
	plot(data,'-b','LineWidth',2);

	
	eval(options);