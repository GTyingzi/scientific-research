function fig = gui_fl_estimcrossingtree_op()
% gui_fl_estimcrossingtree: GUI of the Crossing tree estimator with Options
% Modified by W.Arroum Dec 2005

% Main block
h0 = figure( ...
	'Colormap',[], ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Name','Estimation of the Hurst index via the crossing tree', ...
	'Position',[20 50 400 700], ...
	'Tag','Fig_gui_fl_estimcrossingtree');

%title 'Estimation of the Hurst index via the crossing tree' + box
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.5*2/3*(6/7), ...
	'ListboxTop',0, ...
	'Position',[0.0275 1-0.09*2/3 0.9400000000000001 0.08*2/3*(6/7)], ...
	'Style','frame', ...
	'Tag','Frameestimcrossingtree');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.8*2/3, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 1-0.08*2/3 0.9 0.055*2/3*(6/7)], ...
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
	'Position',[0.0275 1.31*2/3 0.9400000000000001 0.11*2/3*(6/7)], ...
	'Style','frame', ...
	'Tag','FrameParam2');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 1.36*2/3 0.9 0.06*1/2*(6/7)], ...
	'String','Get Hits', ...
	'Style','text',  ...
	'Tag','Frame2Title');

% Input Signal
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.08 1.32*2/3 0.2525 0.06*1/2*(6/7)], ...
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
	'Position',[0.35 1.32*2/3 0.35 0.06*1/2*(6/7)], ...
	'String','', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_input');

% refresh
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''launch_op'');', ...
	'FontSize',1.1*0.5, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7075 1.32*2/3 0.225 0.06*1/2*(6/7)], ...
	'String','Refresh', ...
    'enable','on',...
	'Tag','Pushbutton_refreshInput');



%============================ Get hits OPTIONS ============================
%Get hist Option Affichage
h2 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.0846560846560844, ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.62 0.9400000000000001 0.495*2/3-0.095*(6/7)], ...
	'Style','frame', ...
	'Tag','FrameParam');

h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.84 0.9 0.06*1/2*(6/7)], ...
	'String','Get Hits Options', ...
	'Style','text',  ...
    'enable','off',...
	'Tag','Frame3Title');

% Input time
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'Callback','fl_estimcrossingtree_compute(''isTimeSeries'');', ...
	'ListboxTop',0, ...
	'Position',[0.08 0.805 0.2525 0.06*1/2*(6/7)], ...
	'String','Time Vector', ...
	'Style','checkbox', ...
    'enable','off',...
	'Tag','checkbox_inputtime');
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',1.1*0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.35 0.805 0.35 0.06*1/2*(6/7)], ...
	'String','Time indexed', ...
	'Style','edit', ...
	'Enable','off',...
	'Tag','EditText_inputtime');

h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''launch_time'');', ...
	'FontSize',1.1*0.5, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7075 0.805 0.225 0.06*1/2*(6/7)], ...
	'String','Refresh', ...
	'Enable','off',...
	'Tag','Pushbutton_refreshInputtime');

%Delta
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'Callback','fl_estimcrossingtree_compute(''delta'');', ...
	'ListboxTop',0, ...
	'Position',[0.08 0.765 0.2525 0.06*1/2*(6/7)], ...
	'String','Delta', ...
	'Style','checkbox', ...
    'enable','off',...
	'Tag','checkbox_delta'); % new wahib

h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',1.1*0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.2 0.765 0.25 0.06*1/2*(6/7)], ...
	'String','delta', ...
	'Style','edit', ...
    'Enable','off',...
	'Tag','EditText_delta');

%min max level
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'Callback','fl_estimcrossingtree_compute(''mmlevel'');', ...
	'ListboxTop',0, ...
	'Position',[0.08 0.725 0.2525 0.06*1/2*(6/7)], ...
	'String','Min/Max Level size', ...
	'Style','checkbox', ...
    'enable','off',...
	'Tag','checkbox_mmlevel'); % new wahib

% min level
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.4 0.725 0.24 0.06*1/2*(6/7)], ...
	'String','Minimun', ...
	'Style','text', ...
    'enable','off',...
	'Tag','StaticText_minl');

h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',1.1*0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.4 0.705 0.25 0.06*1/2*(6/7)], ...
	'String','min level', ...
	'Style','edit', ...
    'Enable','off',...
	'Tag','EditText_minl');

% max level
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.7 0.725 0.24 0.06*1/2*(6/7)], ...
	'String','Maximum', ...
	'Style','text', ...
    'enable','off',...
	'Tag','StaticText_maxl');

h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',1.1*0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.7 0.705 0.25 0.06*1/2*(6/7)], ...
	'String','max level', ...
	'Style','edit', ...
    'Enable','off',...
	'Tag','EditText_maxl');

% Delete first crossings
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.08 0.665 0.5325 0.06*1/2*(6/7)], ...
	'String','Delete first crossing at each level', ...
	'Style','checkbox', ...
    'enable','off',...
	'Value',1,...
	'Tag','checkbox_deletefirst');

% Plot crossings
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.6 0.665 0.25 0.06*1/2*(6/7)], ...
	'String','Plot crossings', ...
	'Style','checkbox', ...
    'enable','off',...
	'Value',0,...
	'Tag','checkbox_plot_Xing');

% Validate
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
    'Callback','fl_estimcrossingtree_compute(''validate'')', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.07 0.63 0.225 0.06*1/2*(6/7)], ...
	'String','Validate', ...
    'enable','off',...
	'Tag','PushbuttonV');
%get hits

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''get_hits_op'');', ...
	'FontSize',0.59, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7075 0.63 0.225 0.06*1/2*(6/7)], ...
	'String','Get hits', ...
    'enable','off',...
	'Tag','Pushbutton_get_hits');



%======================== CalcH OPTIONS ================================
%CalcH Option Affichage

%title main box

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.0846560846560844*(6/7), ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.7750*2/3 0.9400000000000001 0.17*2/3*(6/7)], ...
	'Style','frame', ...
	'Tag','FrameParam2');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.878*2/3 0.9 0.06*1/2*(6/7)], ...
	'String','Compute H at given method', ...
	'Style','text',  ...
    'enable','off',...
	'Tag','Frame4Title');

% method
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.1 0.555 0.225 0.06*1/2*(6/7)], ...
	'String','Method', ...
	'Style','text', ...
    'enable','off',...
	'Tag','StaticText_method');

h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',1.1*0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.25 0.56 0.225 0.06*1/2*(6/7)], ...
	'Callback','fl_estimcrossingtree_compute(''edittext_method_op'');', ...
	'String',{'iid','srd','lrd'}, ...
	'Style','popupmenu', ...
    'enable','off',...
	'Tag','EditText_method');

%bias
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.6 0.56 0.3325 0.06*1/2*(6/7)], ...
	'String','Bias Corrected', ...
	'Style','checkbox', ...
	'Value',1,...
    'enable','off',...
	'Tag','checkbox_biasCorrected');

%compute
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''compute_op'');', ...
	'FontSize',0.59, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7075 0.525 0.225 0.06*1/2*(6/7)], ...
	'String','Compute', ...
	'enable','off',...
	'Tag','Pushbutton_estimcrossingtree_compute_op');


%=========================Hurst Compute table===================================
%table
	tbl = axes('Parent',h0, 'position', [0.0275 0.37 0.895 0.14],'Tag','table');
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
	'Position',[0.08 0.2*2/3 0.87 0.37*2/3*(6/7)], ...
    'XGrid','on',...
    'YGrid','on',...%'YLim',[0 1],...%'YTick',[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1],...
	'Tag','Axes_plotH');

%==================== ostic plot Diagn at given level ========================
%title main box

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.0846560846560844, ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.06*2/3 0.9400000000000001 0.125*2/3*(6/7)], ...
	'Style','frame', ...
	'Tag','FrameParam2');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.12*2/3 0.9 0.06*1/2*(6/7)], ...
	'String','Diagnostic plot for a given level', ...
	'Style','text',  ...
    'enable','off',...
	'Tag','Frame5Title');

% levels
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.1 0.07*2/3 0.225 0.06*1/2*(6/7)], ...
	'String','Level', ...
	'Style','text', ...
    'enable','off',...
	'Tag','StaticText_level');

h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',1.1*0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.25 0.075*2/3 0.225 0.06*1/2*(6/7)], ...
	'Callback','fl_estimcrossingtree_compute(''edittext_level_op'');', ...
    'String',{''}, ...
	'Style','popupmenu', ...
    'enable','off',...
	'Tag','EditText_level');

% Diagnostic	
h3 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',1.1*0.55, ...
	'HorizontalAlignment','left', ...
    'Callback','fl_estimcrossingtree_compute(''checkbox_diagnosticPlot'');', ...
	'ListboxTop',0, ...
	'Position',[0.7075 0.075*2/3 0.225 0.06*1/2*(6/7)], ...
	'String','Diagnostic Plot', ...
	'Enable','off', ...
	'Tag','checkbox_diagnosticPlot');



%========================Close/Help=================================


% help
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''help'')', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.463 0.01*2/3 0.25 0.06*1/2*(6/7)], ...
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
	'Position',[0.713 0.01*2/3 0.25 0.06*1/2*(6/7)], ...
	'String','Close', ...
	'Tag','Pushbutton_cancel');


% Clearop
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimcrossingtree_compute(''Clearop'');', ...
	'FontSize',0.7, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.02 0.01*2/3 0.25 0.06*1/2*(6/7)], ...
	'String','Clear', ...
	'enable','off',...
	'Tag','Pushbutton_clear2');

fl_window_init(h0);

	
if nargout > 0, fig = h0; end