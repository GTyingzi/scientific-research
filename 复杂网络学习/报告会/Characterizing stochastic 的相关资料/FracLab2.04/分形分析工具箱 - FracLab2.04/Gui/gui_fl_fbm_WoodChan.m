function fig = gui_fl_fbm_WoodChan()
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
	'Position',[20 50 300 250], ...
	'Tag','Fig_gui_fl_fbm_WoodChan');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''help'')', ...
	'FontSize',0.266666666666666, ...
	'ListboxTop',0, ...
	'Position',[0.0233 0.716 0.96 0.2], ...
	'Style','frame', ...
	'Tag','Framefbm');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''help'')', ...
	'FontSize',0.533333333333332, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.1633 0.76266 0.682517 0.079114], ...
	'String','fBm Synthesis (Wood & Chan)', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.133333333333333, ...
	'ListboxTop',0, ...
	'Position',[0.0233 0.248 0.96 0.448], ...
	'Style','frame', ...
	'Tag','FrameParam');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''help'')', ...
	'Enable','inactive', ...
	'FontSize',0.551723999999999, ...
	'Interruptible','off', ...
	'ListboxTop',0, ...
	'Position',[0.03666666666666667 0.58 0.3666666666666667 0.076], ...
	'String','Holder exponent', ...
	'Style','text', ...
	'Tag','StaticText_holderexponent');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''slider_inith'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.44 0.58 0.3 0.08], ...
	'Style','slider', ...
	'Tag','Slider_inith', ...
	'Value',0.5);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_fbm_WoodChan_compute(''edit_inith'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.7466670000000001 0.58 0.216667 0.08], ...
	'String','0.5', ...
	'Style','edit', ...
	'Tag','EditText_inith');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551723999999999, ...
	'ListboxTop',0, ...
	'Position',[0.03666666666666667 0.48 0.3666666666666667 0.076], ...
	'String','Sample Size', ...
	'Style','text', ...
	'Tag','StaticText_sample');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''ppm_sample'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.44 0.48 0.3 0.08], ...
	'String',{'8 points', '16 points', '32 points', '64 points', '128 points', '256 points', '512 points', '1024 points', '2048 points', '4096 points'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_sample', ...
	'Value',6);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_fbm_WoodChan_compute(''edit_sample'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.746667 0.48 0.216667 0.08], ...
	'String','256', ...
	'Style','edit', ...
	'Tag','EditText_sample');
    
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551723999999999, ...
	'ListboxTop',0, ...
	'Position',[0.03666666666666667 0.38 0.3666666666666667 0.076], ...
	'String','time support:', ...
	'Style','text', ...
	'Tag','StaticText_support');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_fbm_WoodChan_compute(''edit_tmax'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.746667 0.38 0.216667 0.08], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText_tmax');
    
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''help'')', ...
	'FontSize',0.551723999999999, ...
	'ListboxTop',0, ...
	'Position',[0.03666666666666667 0.28 0.3666666666666667 0.076], ...
	'String','Random Seed', ...
	'Style','text', ...
	'Tag','StaticText_rseed');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_fbm_WoodChan_compute(''edit_rseed'')', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.746667 0.28 0.216667 0.08], ...
	'Style','edit', ...
	'Tag','EditText_rseed');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_fbm_WoodChan_compute(''compute'',who)])', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.07666666666666667 0.06 0.233333 0.12], ...
	'String','Compute', ...
	'Tag','Pushbutton_compute');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_fbm_WoodChan_compute(''help'')', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.3966666666666667 0.06 0.233333 0.12], ...
	'String','Help', ...
	'Tag','Pushbutton1');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(clf)', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.6966666666666667 0.06 0.233333 0.12], ...
	'String','Close', ...
	'Tag','Pushbutton_cancel');

fl_window_init(h0);	
	
if nargout > 0, fig = h0; end
