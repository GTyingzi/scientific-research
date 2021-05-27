function fout = fl_waitbar(command, whichbar, i, n, varargin)
% Typical use :
%
% h_waitbar = fl_waitbar('init');
% for i=1:100,
%     % computation here %
%     fl_waitbar('view',h_waitbar,i,100);
% end
% fl_waitbar('close',h_waitbar);
%
%
%Or in case of multiple "for" loops :
%
% h_waitbar = fl_waitbar('init');
% for i1=1:100,
%     % computation here %
%     fl_waitbar('view',h_waitbar,0.5*i1,100);
% end
% for i2=1:1000,
%     % computation here %
%     fl_waitbar('view',h_waitbar,0.5*1000+0.5*i2,1000);
% end
% fl_waitbar('close',h_waitbar);

if fl_getOption('ShowWaitBars')
	waiting_message_init = 'Please wait (initialazing)';
	waiting_message_view = 'Please wait (computation in progress)';
	
	switch command
		case 'init'
			%fout = waitbar(0,waiting_message_init); 
			fout = waitbar(0,waiting_message_init,'Color',fl_getOption('FrameColor')); 
			set(get(get(fout,'children'),'Title'),'Color',fl_getOption('FontColor'));
			pause(0.1);
		case 'view'
			%Just show one window out of 100;
			if find(i == floor(linspace(1,n)))
				%fout = waitbar(i/n, whichbar, waiting_message_view, varargin);
				fout = waitbar(i/n, whichbar, waiting_message_view, 'Color',fl_getOption('FrameColor'), varargin);
				set(get(get(fout,'children'),'Title'),'Color',fl_getOption('FontColor'));
				%fout = waitbar(i/n, whichbar, [ waiting_message_view ' ' num2str(i)], varargin);
				%pause(.1)
			end
		case 'close'
			close(whichbar);
	end
else
	fout = 0;
end