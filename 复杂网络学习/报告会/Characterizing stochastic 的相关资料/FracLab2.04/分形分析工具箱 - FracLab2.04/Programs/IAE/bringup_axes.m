function H = bringup_axes(handles, axes_tag)

if(min(size(findobj('Tag',axes_tag))) == 0)
	eval(['axes(handles.' axes_tag ')']);
	H = eval(['handles.' axes_tag]);
elseif (isempty(findobj('Tag',axes_tag)) == 0)
	axes(findobj('Tag',axes_tag))
	H = findobj('Tag',axes_tag);
end
