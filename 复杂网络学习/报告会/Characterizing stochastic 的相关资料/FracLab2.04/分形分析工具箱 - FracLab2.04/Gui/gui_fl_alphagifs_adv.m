function fig = gui_fl_alphagifs_adv()
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
	'Name','Holder regularity estimation', ...
	'Position',[20 50 300 250], ...
	'Tag','Fig_gui_fl_alphagifs_adv');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.347826086956521, ...
	'ListboxTop',0, ...
	'Position',[0.05 0.817087 0.92 0.143349], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_alphagifs_adv');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.065 0.852 0.9 0.08], ...
	'String','Holder Function Estimation using GIFS', ...
	'Style','text', ...
	'Tag','StaticText_gui_fl_alphagifs_adv');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.266666666666666, ...
	'ListboxTop',0, ...
	'Position',[0.05 0.596 0.92 0.2], ...
	'Style','frame', ...
	'Tag','Frame_input');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.14 0.656 0.2 0.076], ...
	'String','Input', ...
	'Style','text', ...
	'Tag','StaticText_input');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.3466666666666667 0.656 0.3333333333333334 0.08], ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_sig_nname');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_alphagifs_adv_compute(''launch'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7133333333333334 0.636 0.2333333333333333 0.12], ...
	'String','Refresh', ...
	'Tag','refresh_input');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.168421052631579, ...
	'ListboxTop',0, ...
	'Position',[0.05 0.236 0.92 0.34], ...
	'Style','frame', ...
	'Tag','Frame_alpha_param');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.14 0.436 0.2166666666666667 0.076], ...
	'String','Limit type', ...
	'Style','text', ...
   'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_alphagifs_adv_compute('' alphagifs_adv_ppm_limit'');', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Max',2, ...
	'Min',1, ...
	'Position',[0.4633333333333334 0.436 0.4 0.08], ...
	'String',{'regression', 'cesaro'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_alphagifs_limit', ...
	'Value',1);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.14 0.284 0.2166666666666667 0.076], ...
	'String','Wavelet', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Min',1, ...
	'Position',[0.4633333333333334 0.284 0.4 0.08], ...
	'String','Daubechies 4', ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_alphagifs_wav', ...
	'Value',1);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_alphagifs_adv_compute( ''alphagifs_compute'',who)]);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.076 0.2333333333333333 0.12], ...
	'String','Compute', ...
	'Tag','Pushbutton_alphagifs_compute');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','helpwin gui_fl_alphagifs_adv_help;', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.3966666666666667 0.076 0.2333333333333333 0.12], ...
	'String','Help', ...
	'Tag','Pushbutton_help');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(gcf);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7300000000000001 0.076 0.2333333333333333 0.12], ...
	'String','Close', ...
	'Tag','Pushbutton_close');

fl_window_init(h0);

if nargout > 0, fig = h0; end
