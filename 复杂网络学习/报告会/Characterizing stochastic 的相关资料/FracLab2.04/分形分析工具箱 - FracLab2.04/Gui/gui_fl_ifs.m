function fig = gui_fl_ifs()
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
	'Name','IFS Attractor', ...
	'Position',[20 50 350 400], ...
	'Tag','Fig_gui_fl_ifs');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.319999999999999, ...
	'ListboxTop',0, ...
	'Position',[0.02571428571428571 0.8525 0.9428571428571428 0.1], ...
	'Style','frame', ...
	'Tag','Frame_ifs');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05428571428571428 0.8725000000000001 0.8857142857142857 0.05], ...
	'String','Fractal Interpolation Functions', ...
	'Style','text', ...
	'Tag','Statictext_ifs');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.0888888888888887, ...
	'ListboxTop',0, ...
	'Position',[0.02571428571428571 0.3975 0.9428571428571428 0.425], ...
	'Style','frame', ...
	'Tag','Frame_gui_ifs');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.05428571428571428 0.6900000000000001 0.3428571428571429 0.05], ...
	'String','Interpolation points', ...
	'Style','text', ...
	'Tag','StaticText_interp');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.44 0.735 0.4714285714285714 0.05], ...
	'String','[X1 Y1 ; X2 Y2 ; ... ; Xn Yn]', ...
	'Style','text', ...
	'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ifs_compute(''ifs_edittext_interp'');', ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.4114285714285714 0.6975 0.5142857142857142 0.05], ...
	'String','[0 0.5 ; 0.7 -1 ; 1 2 ; 1.4 -2]', ...
	'Style','edit', ...
	'Tag','EditText_ifs_interp');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.05428571428571428 0.5675 0.4285714285714285 0.0475], ...
	'String','Contraction factors', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.525 0.61 0.3428571428571429 0.05], ...
	'String','[C1 ; C2 ; ... ; Cn]', ...
	'Style','text', ...
	'Tag','StaticText3');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ifs_compute(''ifs_edittext_ratio'');', ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.4114285714285714 0.5725 0.5142857142857142 0.05], ...
	'String','[0.5 ; -0.9 ; 0.2]', ...
	'Style','edit', ...
	'Tag','EditText_ifs_ratio');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551724137931033, ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.05428571428571428 0.4475 0.4285714285714285 0.0475], ...
	'String','Number of points', ...
	'Style','text', ...
	'Tag','StaticText4');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ifs_compute(''ifs_edittext_points'');', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'HorizontalAlignment','center', ...
	'Position',[0.4114285714285714 0.4525 0.2 0.05], ...
	'String','5000', ...
	'Style','edit', ...
	'Tag','EditText_ifs_points');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.266666666666666, ...
	'ListboxTop',0, ...
	'Position',[0.02571428571428571 0.2475 0.9428571428571428 0.125], ...
	'Style','frame', ...
	'Tag','Frame1');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'ListboxTop',0, ...
	'Position',[0.05428571428571428 0.2725 0.2 0.05], ...
	'String','IFS type', ...
	'Style','text', ...
	'Tag','StaticText5');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ifs_compute(''ifs_ppm_type'');', ...
	'FontSize',0.499999999999999, ...
	'ListboxTop',0, ...
	'Max',2, ...
	'Min',1, ...
	'Position',[0.4114285714285714 0.2775 0.2857142857142857 0.055], ...
	'String',{'affine', 'sinusoidal'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_ifs_type', ...
	'Value',1);
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_ifs_compute(''ifs_compute'',who)]);', ...
	'FontSize',0.355555555555555, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.06857142857142857 0.0975 0.2285714285714286 0.08750000000000001], ...
	'String','compute', ...
	'Tag','Pushbutton_ifs_compute');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','helpwin gui_fl_ifs_help;', ...
	'FontSize',0.355555555555555, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.3828571428571428 0.0975 0.2285714285714286 0.08750000000000001], ...
	'String','Help', ...
	'Tag','Pushbutton_gifs_help');
h1 = uicontrol('Parent',h0, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(gcf);', ...
	'FontSize',0.355555555555555, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.6971428571428572 0.0975 0.2285714285714286 0.08750000000000001], ...
	'String','close', ...
	'Tag','Pushbutton_ifs_close');
	
fl_window_init(h0);
	
if nargout > 0, fig = h0; end
