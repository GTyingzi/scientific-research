function fig = gui_fl_estimcrossingtree()

% gui_fl_estimcrossingtree: GUI of the Crossing tree estimator without
% Option
% Modified by W.Arroum Dec 2005

% Main block
h0 = figure( ...
	'Colormap',[], ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Name','Estimation of the Hurst index via the crossing tree', ...
	'Position',[20 50 400 400], ...
	'Tag','Fig_gui_fl_estimcrossingtree');

%title 'Estimation of the Hurst index via the crossing tree' + box
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.5*3/4, ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.91 0.9400000000000001 0.08], ...
	'Style','frame', ...
	'Tag','Frameestimcrossingtree');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.75*3/4, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.92 0.9 0.055], ...
	'String','Estimation of the Hurst index via the crossing tree', ...
	'Style','text',  ...
	'Tag','StaticTextTitle');


%=========================Get Hits===================================
%title main box
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.0846560846560844, ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.73 0.9400000000000001 0.17], ...
	'Style','frame', ...
	'Tag','FrameParam2');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.85 0.9 0.06*3/4], ...
	'String','Get Hits & Compute', ...
	'Style','text',  ...
	'Tag','Frame2Title');

% Input Signal
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.08 0.8 0.2525 0.06*3/4], ...
	'String','Input Signal', ...
	'Style','text', ...
	'Tag','StaticText_input');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.7, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.35 0.8 0.35 0.06*3/4], ...
	'String','', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_input');
% refresh
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''launch'');', ...
	'FontSize',1.1*0.5, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7075 0.8 0.225 0.06*3/4], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refreshInput');

%compute
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''compute'');', ...
	'FontSize',0.59, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.4 0.74 0.225 0.06*3/4], ...
	'String','Compute', ...
	'enable','off',...
	'Tag','Pushbutton_estimcrossingtree_compute');
%=========================Hurst Compute===================================
%table
	tbl = axes('Parent',h0, 'position', [0.0275 0.49 0.895 0.23],'Tag','table');
	Cdata = {'','','',''};
    ebp_table(h0, tbl, 'Table', Cdata);
%   DataChangedCallback - Callback function name or handle.

%=========================Plot===================================
% Create H plot
h1 = axes('Parent',h0, ...
    'Units','normalized', ...
	'FontUnits','normalized', ...
    'FontSize',0.05, ...
	'FontWeight','bold', ...
	'Position',[0.08 0.1 0.87 0.37], ...
    'XGrid','on',...
    'YGrid','on',...'YLim',[0 1],...%'YTick',[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1],...
	'Tag','Axes_plotH');


%========================Close/Help=================================
% option
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
    'Callback','fl_estimcrossingtree_compute(''option'')', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.04 0.74 0.225 0.06*3/4], ...
	'String','Option', ...
	'Tag','Pushbutton_option');

% help
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''help'')', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.463 0.01 0.25 0.06*3/4], ...
	'String','Help', ...
	'Tag','Pushbutton1');

% close
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...%'ButtonDownFcn','fl_estimcrossingtree_compute(''help'')', ...
	'Callback','close(gcf);fl_clearerror;if exist(''fil.mat'') delete fil.mat; end;', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.713 0.01 0.25 0.06*3/4], ...
	'String','Close', ...
	'Tag','Pushbutton_cancel');

% Clear
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''Clear'');', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.02 0.01 0.25 0.06*3/4], ...
	'String','Clear', ...
	'enable','off',...
	'Tag','Pushbutton_clear');

fl_window_init(h0);
	
if nargout > 0, fig = h0; end