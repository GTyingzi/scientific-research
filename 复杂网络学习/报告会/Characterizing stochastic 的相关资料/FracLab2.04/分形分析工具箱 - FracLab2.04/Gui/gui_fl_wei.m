function fig = gui_fl_wei()
% This is the machine-generated representation of a Handle Graphics object
% and its children.  Note that handle values may change when these objects
% are re-created. This may cause problems with any callbacks written to
% depend on the value of the handle at the time the object was saved.
%
% To reopen this object, just type the name of the M-file at the MATLAB
% prompt. The M-file and its associated MAT-file must be on your path.


h0 = figure( ...
	'Colormap',[], ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Name','Generation parameters', ...
	'Position',[20 50 400 300], ...
	'Tag','Fig_gui_fl_wei');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.319999999999999, ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.8300000000000001 0.9400000000000001 0.1330000000000001], ...
	'Style','frame', ...
	'Tag','FrameWei');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.470588235294116, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.1975 0.8467 0.585 0.08], ...
	'String','Weierstrass Function Synthesis', ...
	'Style','text', ...
	'Tag','StaticTextTitle');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.0914285714285712, ...
	'ListboxTop',0, ...
	'Position',[0.0275 0.23 0.9400000000000001 0.55], ...
	'Style','frame', ...
	'Tag','FrameParam');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Enable','inactive', ...
	'FontSize',0.551723999999999, ...
	'Interruptible','off', ...
	'ListboxTop',0, ...
	'Position',[0.0725 0.6633000000000001 0.25 0.0633], ...
	'String','Holder exponent', ...
	'Style','text', ...
	'Tag','StaticText_holderexponent');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_wei_compute(''slider_inith'');', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.3725 0.6633333333333333 0.25 0.06666666666666667], ...
	'Style','slider', ...
	'Tag','Slider_inith', ...
	'Value',0.5);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_wei_compute(''edit_inith'');', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.6475 0.6633333333333333 0.225 0.06666666666666667], ...
	'String','0.5', ...
	'Style','edit', ...
	'Tag','EditText_inith');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551723999999999, ...
	'ListboxTop',0, ...
	'Position',[0.0725 0.5633333333333334 0.25 0.06333333333333334], ...
	'String','Sample Size', ...
	'Style','text', ...
	'Tag','StaticText_sample');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_wei_compute(''ppm_sample'');', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.3725 0.5633333333333334 0.25 0.06666666666666667], ...
	'String',{'8 points', '16 points', '32 points', '64 points', '128 points', '256 points', '512 points', '1024 points', '2048 points', '4096 points'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_sample', ...
	'Value',6);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_wei_compute(''edit_sample'');', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.6475 0.5633333333333334 0.225 0.06666666666666667], ...
	'String','256', ...
	'Style','edit', ...
	'Tag','EditText_sample');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'ListboxTop',0, ...
	'Position',[0.0725 0.4666666666666667 0.25 0.06333333333333334], ...
	'String','time support', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_wei_compute(''edit_tmax'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.6475 0.4666666666666667 0.225 0.06666666666666667], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText_wei_tmax');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_wei_compute(''edit_lambda'')', ...
	'FontSize',0.551723999999999, ...
	'ListboxTop',0, ...
	'Position',[0.0725 0.3700000000000001 0.25 0.06333333333333334], ...
	'String','lambda', ...
	'Style','text', ...
	'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_wei_compute(''edit_lambda'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.6475 0.3700000000000001 0.225 0.06666666666666667], ...
	'String','2', ...
	'Style','edit', ...
	'Tag','EditText_wei_lambda');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'ListboxTop',0, ...
	'Position',[0.0725 0.2733333333333334 0.25 0.06333333333333334], ...
	'String','Sum order', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
    'callback','fl_wei_compute(''nyquist'')', ...
	'ListboxTop',0, ...
	'Position',[0.37 0.2733333333333334 0.25 0.06333333333333334], ...
	'String','Nyquist Default', ...
    'Value',0, ...
	'Style','checkbox', ...
	'Tag','Nyquist');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_wei_compute(''edit_kmax'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.6475 0.2733333333333334 0.225 0.06666666666666667], ...
	'String','50', ...
	'Style','edit', ...
	'Tag','EditText_wei_kmax');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_wei_compute(''compute'',who)])', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.1225 0.06333333333333334 0.175 0.1], ...
	'String','Compute', ...
	'Tag','Pushbutton_compute');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_wei_compute(''help'')', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.3975 0.06333333333333334 0.175 0.1], ...
	'String','Help', ...
	'Tag','Pushbutton_help');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(gcf);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.6725 0.06333333333333334 0.175 0.1], ...
	'String','Close', ...
	'Tag','Pushbutton_cancel');

fl_window_init(h0);

if nargout > 0, fig = h0; end
