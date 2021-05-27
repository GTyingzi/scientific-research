function gui_fl_multden()
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
	'Name','Multifractal Denoising of 1D and 2D signals', ...
	'Position',[20 50 320 270], ...
	'Tag','Fig_gui_fl_multden', ...
	'UserData','a');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.21863072, ...
	'Position',[0.0833333 0.76 0.833333 0.21], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_multden');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.20461518, ...
	'Position',[0.0833333 0.264423 0.833333 0.274038], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_multden');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'FontWeight','bold', ...
	'Position',[0.213333 0.86 0.56 0.076], ...
	'String','Multifractal Denoising', ...
	'Style','text', ...
	'Tag','StaticText_multden_title1');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'FontWeight','bold', ...
	'Position',[0.213333 0.78 0.56 0.076], ...
	'String','1D and 2D signals', ...
	'Style','text', ...
	'Tag','StaticText_multden_title2');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.113333 0.416 0.533333 0.076], ...
	'String','Spectrum shift value ', ...
	'Style','text', ...
	'Tag','StaticText_multden_alphashift');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_multden_compute(''edit_alphashift'');', ...
	'FontSize',0.532, ...
	'Position',[0.68 0.416 0.166667 0.08], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText_multden_alphashift');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_multden_compute(''slider_alphashift'');', ...
	'FontSize',0.55034469, ...
	'Max',5, ...
	'Min',-5, ...
	'Position',[0.463333 0.316 0.383333 0.076], ...
	'Style','slider', ...
	'Tag','Slider_multden_alphashift', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_multden_compute(''compute'',who);]);', ...
	'FontSize',0.4, ...
	'FontWeight','bold', ...
	'Position',[0.0833333 0.072 0.233333 0.12], ...
	'String','Compute', ...
	'Tag','Pushbutton_multden_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_multden_compute(''help'');', ...
	'FontSize',0.4, ...
	'FontWeight','bold', ...
	'Position',[0.38 0.072 0.233333 0.12], ...
	'String','Help', ...
	'Tag','Pushbutton_multden_help');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(findobj(''Tag'',''Fig_gui_fl_multden''));fl_clearerror;', ...
	'FontSize',0.4, ...
	'FontWeight','bold', ...
	'Position',[0.676667 0.072 0.233333 0.12], ...
	'String','Close', ...
	'Tag','Pushbutton_close');

%% refresh Frame
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','pixels', ...
	'FontSize',12, ...
	'Position',[0.0833333 0.6 0.833333 0.13], ...
	'Style','frame', ...
	'Tag','Frame_input_multden');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','pixels', ...
	'FontSize',12, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'Position',[0.09 0.62 0.4 0.07], ...
	'String','Analysed signal', ...
	'Style','text', ...
	'Tag','StaticText_input_mulden');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','pixels', ...
	'Callback','fl_multden_compute(''refresh'');', ...
	'FontSize',12, ...
	'FontWeight','bold', ...
	'Position',[0.73 0.62 0.175 0.09], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refresh_multden');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','pixels', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',12, ...
	'HorizontalAlignment','left', ...
	'Position',[0.42 0.63 0.28 0.07], ...
	'String','', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_sig_nname_multden');

fl_window_init(a);

fl_multden_compute('refresh');
