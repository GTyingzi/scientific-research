function gui_fl_dwtspec()
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
	'Position',[20 50 300 250], ...
	'Tag','Fig_gui_fl_dwtspec');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_dwtspec_compute(''compute_dwtspec'',who);])', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.0633333 0.216 0.233333 0.12], ...
	'String','Compute', ...
	'Tag','Pushbutton_dwtspec_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_dwtspec_compute(''advanced_compute'')', ...
	'FontSize',0.399999999999999, ...
	'Position',[0.246667 0.416 0.466667 0.12], ...
	'String','Advanced compute', ...
	'Tag','Pushbutton_dwtspec_advanced');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(clf)', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.663333 0.216 0.233333 0.12], ...
	'String','close', ...
	'Tag','Pushbutton_dwtspec_close');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.0586797 0.686364 0.855747 0.236364], ...
	'Style','frame', ...
	'Tag','Frame1');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.499999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.102689 0.740908 0.748167 0.0909092], ...
	'String','DWT Based Legendre Spectrum', ...
	'Style','text', ...
	'Tag','StaticText1');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_dwtspec_compute(''help'')', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.363333 0.216 0.233333 0.12], ...
	'String','Help', ...
	'Tag','Pushbutton1');

fl_window_init(a);