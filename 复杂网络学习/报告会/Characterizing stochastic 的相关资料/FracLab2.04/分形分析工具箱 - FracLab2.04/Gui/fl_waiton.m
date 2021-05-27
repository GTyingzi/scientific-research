function pointer=fl_waiton()
% displays a watch pointer
% B. Guiheneuf 1997

	pointer{1}=gcf;
	pointer{2} = get(gcf,'Pointer');
	set(gcf,'Pointer','watch');
	pause(0.1);
