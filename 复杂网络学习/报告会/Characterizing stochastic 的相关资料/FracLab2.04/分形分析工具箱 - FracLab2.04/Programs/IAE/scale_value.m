function dest_val = scale_value(src_val, src_min, src_max, dest_min, dest_max)
% scales a value from the range (src_min,src_max) into a value in the range (dest_min,dest_max)

if (src_max - src_min ~= 0)
	rel = (src_val - src_min)./(src_max - src_min);
else
	rel = 0.5;	
end

dest_val = rel .* (dest_max - dest_min) + dest_min;

