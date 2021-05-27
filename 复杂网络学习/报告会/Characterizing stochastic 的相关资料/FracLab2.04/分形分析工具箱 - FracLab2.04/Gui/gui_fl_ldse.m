function gui_fl_ldse()
% This is the machine-generated representation of a MATLAB object
% and its children.  Note that handle values may change when these
% objects are re-created. This may cause problems with some callbacks.
% The command syntax may be supported in the future, but is currently 
% incomplete and subject to change.
%
% To re-open this system, just type the name of the m-file at the MATLAB
% prompt. The M-file and its associtated MAT-file must be on your path.

                

a = figure( ...
	'Colormap',[], ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Name','Large Deviation Spectrum Estimation', ...
	'Position',[20 50 400 450], ...
	'Tag','Fig_gui_fl_ldse', ...
	'UserData',0.00137174);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.344086021505376, ...
	'Position',[0.05 0.9 0.9 0.0775], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_fgse');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333333, ...
	'FontWeight','bold', ...
	'Position',[0.15 0.905 0.7 0.05], ...
	'String','Large deviation spectrum estimation', ...
	'Style','text', ...
	'Tag','StaticText_gui_fl_fgse');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.20125786163522, ...
	'Position',[0.05 0.7425 0.9 0.1325], ...
	'Style','frame', ...
	'Tag','Frame_input');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'Position',[0.075 0.8125 0.2 0.04], ...
	'String','Input data', ...
	'Style','text', ...
	'Tag','StaticText_input');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''radiobutton_measure'');', ...
	'FontSize',0.666666666666667, ...
	'Position',[0.275 0.8125 0.2 0.04], ...
	'String','measure', ...
	'Style','radiobutton', ...
	'Tag','RadioButton_measure', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''radiobutton_function'');', ...
	'FontSize',0.666666666666667, ...
	'Position',[0.5 0.8125 0.2 0.04], ...
	'String','function', ...
	'Style','radiobutton', ...
	'Tag','RadioButton_function');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Enable','off', ...
	'Callback','fl_ldse(''radiobutton_cwt'');', ...
	'FontSize',0.666666666666667, ...
	'Position',[0.725 0.8125 0.2 0.04], ...
	'String','cwt', ...
	'Style','radiobutton', ...
	'Tag','RadioButton_cwt');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''refresh'');', ...
	'FontSize',0.666666666666667, ...
	'FontWeight','bold', ...
	'Position',[0.075 0.7675 0.15 0.04], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refresh');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','center', ...
	'Position',[0.275 0.7675 0.1 0.04], ...
	'String','name', ...
	'Style','text', ...
	'Tag','StaticText_name');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.4 0.7675 0.2 0.04], ...
	'String','Input data name', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','StaticText_sig_nname');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','center', ...
	'Position',[0.6 0.7675 0.1 0.04], ...
	'String','size', ...
	'Style','text', ...
	'Tag','StaticText_size');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','center', ...
	'Position',[0.725 0.7675 0.2 0.04], ...
	'String','[M x N]', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_size');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.101587301587302, ...
	'Position',[0.05 0.45 0.9 0.2625], ...
	'Style','frame', ...
	'Tag','Frame_coarse');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.592592592592593, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','center', ...
	'Position',[0.1 0.6625 0.8 0.045], ...
	'String','Coarse grain Hoelder exponents estimation', ...
	'Style','text', ...
	'Tag','StaticText_coarse');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.075 0.6325 0.4 0.04], ...
	'String','min size', ...
	'Style','text', ...
	'Tag','StaticText_min');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ldse(''edittext_min'');', ...
	'FontSize',0.666666666666667, ...
	'Max',64, ...
	'Min',1, ...
	'Position',[0.075 0.6 0.175 0.04], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText_min', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''slider_min'');', ...
	'FontSize',0.666666666666667, ...
	'Max',64, ...
	'Min',1, ...
	'Position',[0.275 0.6 0.2 0.04], ...
	'Style','slider', ...
	'Tag','Slider_min', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.525 0.6325 0.4 0.04], ...
	'String','max size', ...
	'Style','text', ...
	'Tag','StaticText_max');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ldse(''edittext_max'');', ...
	'FontSize',0.666666666666667, ...
	'Max',64, ...
	'Min',1, ...
	'Position',[0.525 0.6 0.175 0.04], ...
	'String','8', ...
	'Style','edit', ...
	'Tag','EditText_max', ...
	'Value',8);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''slider_max'');', ...
	'FontSize',0.666666666666667, ...
	'Max',64, ...
	'Min',1, ...
	'Position',[0.725 0.6 0.2 0.04], ...
	'Style','slider', ...
	'Tag','Slider_max', ...
	'Value',8);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.055 0.5325 0.2 0.04], ...
	'String','# of scales', ...
	'Style','text', ...
	'Tag','StaticText_scale_nb');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ldse(''edittext_scale_nb'');', ...
	'FontSize',0.666666666666667, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.225 0.5325 0.1 0.04], ...
	'String','5', ...
	'Style','edit', ...
	'Tag','EditText_scale_nb', ...
	'Value',5);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[0.701961 0.701961 0.701961], ...
	'Callback','fl_ldse(''slider_scale_nb'');', ...
	'FontSize',0.666666666666667, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.35 0.5325 0.2 0.04], ...
	'Style','slider', ...
	'Tag','Slider_scale_nb', ...
	'Value',5);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.575 0.5325 0.2 0.04], ...
	'String','progress.', ...
	'Style','text', ...
	'Tag','StaticText_progression');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''popupmenu_progression'');', ...
	'FontSize',0.666666666666667, ...
	'Max',3, ...
	'Min',1, ...
	'Position',[0.725 0.5325 0.2 0.04], ...
	'String',{'linear','logarithmic','decimated'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_progression', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.075 0.475 0.2 0.04], ...
	'String','ball', ...
	'Style','text', ...
	'Tag','StaticText_ball');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''popupmenu_ball'');', ...
	'FontSize',0.666666666666667, ...
	'Max',3, ...
	'Min',1, ...
	'Position',[0.2 0.475 0.25 0.04], ...
	'String',{'center','asymmetric','star'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_ball', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.5 0.475 0.2 0.04], ...
	'String','power', ...
	'Style','text', ...
	'Tag','StaticText_power');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ldse(''edittext_power'');', ...
	'Enable','off', ...
	'FontSize',0.666666666666667, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.6 0.475 0.1 0.04], ...
	'SliderStep',[0.99 1], ...
	'String','2.0', ...
	'Style','edit', ...
	'Tag','EditText_power', ...
	'Value',2);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''slider_power'');', ...
	'Enable','off', ...
	'FontSize',0.666666666666667, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.725 0.475 0.2 0.04], ...
	'Style','slider', ...
	'Tag','Slider_power', ...
	'Value',2);
% b = uicontrol('Parent',a, ...
% 	'Units','normalized', ...
% 	'FontUnits','normalized', ...
% 	'Callback','eval([''global '' fl_ldse(''compute_exponents'',who)]);', ...
% 	'FontSize',0.355555555555556, ...
% 	'FontWeight','bold', ...
% 	'Position',[0.3 0.35 0.4 0.075], ...
% 	'String','Compute exponents', ...
% 	'Tag','Pushbutton_compute_exponents');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.152380952380952, ...
	'Position',[0.05 0.15 0.9 0.175], ...
	'Style','frame', ...
	'Tag','Frame_spectra');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','center', ...
	'Position',[0.1 0.275 0.8 0.04], ...
	'String','Spectrum estimation', ...
	'Style','text', ...
	'Tag','StaticText_spectrum');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.075 0.2325 0.3 0.04], ...
	'String','density', ...
	'Style','text', ...
	'Tag','StaticText_density');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''popupmenu_density'');', ...
	'FontSize',0.666666666666667, ...
	'Max',4, ...
	'Min',1, ...
	'Position',[0.25 0.2325 0.25 0.04], ...
	'String',{'continuous', 'discrete', 'wavelet', 'parametric'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_density', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.525 0.2325 0.3 0.04], ...
	'String','kernel', ...
	'Style','text', ...
	'Tag','StaticText_kernel');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''popupmenu_kern'');', ...
	'FontSize',0.666666666666667, ...
	'Max',5, ...
	'Min',1, ...
	'Position',[0.675 0.2325 0.25 0.04], ...
	'String',{'boxcar', 'triangle', 'mollifier', 'epanechnikov', 'gaussian'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_kern', ...
	'Value',5);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.666666666666667, ...
	'HorizontalAlignment','left', ...
	'Position',[0.075 0.175 0.3 0.04], ...
	'String','adaptation', ...
	'Style','text', ...
	'Tag','StaticText_precision');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''popupmenu_precision'');', ...
	'FontSize',0.666666666666667, ...
	'Max',4, ...
	'Min',1, ...
	'Position',[0.25 0.175 0.25 0.04], ...
	'String',{'manual','maxdev','double kernel','diagonal'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_precision', ...
	'Value',2);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_ldse(''edittext_precision'');', ...
	'Enable','off', ...
	'FontSize',0.666666666666667, ...
	'Position',[0.525 0.175 0.175 0.04], ...
	'String','0.1', ...
	'Style','edit', ...
	'Tag','EditText_precision', ...
	'Value',0.1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_ldse(''slider_precision'');', ...
	'Enable','off', ...
	'FontSize',0.666666666666667, ...
	'Position',[0.725 0.175 0.2 0.04], ...
	'Style','slider', ...
	'Tag','Slider_precision', ...
	'Value',0.1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_ldse(''compute'',who)]);', ...
	'FontSize',0.355555555555556, ...
	'FontWeight','bold', ...
	'Position',[0.05 0.05 0.2 0.075], ...
	'String','Compute', ...
	'Tag','Pushbutton_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','helpwin fl_ldse;', ...
	'FontSize',0.355555555555556, ...
	'FontWeight','bold', ...
	'Position',[0.4 0.05 0.2 0.075], ...
	'String','Help', ...
	'Tag','Pushbutton_help');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[0.701961 0.701961 0.701961], ...
	'Callback','close(findobj(''Tag'',''Fig_gui_fl_ldse''));', ...
	'FontSize',0.355555555555556, ...
	'FontWeight','bold', ...
	'Position',[0.75 0.05 0.2 0.075], ...
	'String','Close', ...
	'Tag','Pushbutton_close');

fl_window_init(a);