function pointer=fl_waitoff(pointer)
% redisplays an initial pointer
% B. Guiheneuf 1997

	set(pointer{1},'Pointer',pointer{2});
	pause(0);
