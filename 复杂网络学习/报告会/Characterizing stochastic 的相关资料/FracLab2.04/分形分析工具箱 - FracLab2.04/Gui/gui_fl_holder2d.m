function gui_fl_holder2d()
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
	'Name','2D Holder Exponents Estimation', ...
	'Position',[20 50 300 300], ...
	'Tag','Fig_gui_fl_holder2d', ...
	'UserData','a');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.266666666666666, ...
	'Position',[0.03 0.85 0.94 0.13], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_title_holder2d');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.146789333333333, ...
	'Position',[0.03 0.15 0.94 0.53], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_holder2d');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551723999999999, ...
	'FontWeight','bold', ...
	'Position',[0.1 0.87 0.8 0.07], ...
	'String','2D Holder Exponents Estimation', ...
	'Style','text', ...
	'Tag','StaticText_holder2d_title');
    
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.307692307692308, ...
	'Position',[0.03 0.70 0.94 0.13], ...
	'Style','frame', ...
	'Tag','Frame_input');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.8, ...
	'FontWeight','bold', ...	
	'HorizontalAlignment','left', ...
	'Position',[0.06 0.73 0.25 0.05], ...
	'String','Input Signal', ...
	'Style','text', ...
	'Tag','StaticText_input');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.8, ...
	'HorizontalAlignment','center', ...
	'Position',[0.32 0.735 0.4 0.05], ...
	'String','', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_sig_nname');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_holder2d_compute(''refresh_input'');', ...
	'FontSize',0.533333333333333, ...
	'FontWeight','bold', ...
	'Position',[0.75 0.722 0.175 0.075], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refresh');
   
    
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'Position',[0.1 0.56 0.8 0.07], ...
	'String','Parameters', ...
	'FontWeight','bold', ...
	'Style','text', ...
	'Tag','StaticText_Params');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.499999999999999, ...
	'HorizontalAlignment','left', ...
	'Position',[0.13 0.45 0.266667 0.07], ...
	'String','Capacity', ...
	'Style','text', ...
	'Tag','StaticText1');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.499999999999999, ...
	'Max',5, ...
	'Min',1, ...
	'Position',[0.396667 0.46 0.45 0.07], ...
	'String',{'sum', 'variance', 'standard deviation', 'min', 'max'}, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_fl_holder2d', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.499999999999999, ...
	'HorizontalAlignment','left', ...
	'Position',[0.13 0.32 0.6 0.07], ...
	'String','Number of Resolutions :', ...
	'Style','text', ...
	'Tag','StaticText_holder2d_res');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.499999999999999, ...
	'Position',[0.63 0.32 0.133333 0.07], ...
	'HorizontalAlignment','center', ...
	'String','1', ...
	'Style','text', ...
	'Tag','StaticText_holder2d_resdisp');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_holder2d_compute(''slider_res'');', ...
	'FontSize',0.551723999999999, ...
	'Max',10, ...
	'Min',1, ...
	'Position',[0.2 0.23 0.6 0.07], ...
	'SliderStep',[0.1 0.2], ...
	'Style','slider', ...
	'Tag','Slider_holder2d_reso', ...
	'Value',1);
    
    
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_holder2d_compute(''compute'',who);]);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.0733333 0.03 0.233333 0.1], ...
	'String','Compute', ...
	'Enable','off', ...
	'Tag','Pushbutton_holder2d_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_holder2d_compute(''help'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.373333 0.03 0.233333 0.1], ...
	'String','Help', ...
	'Tag','Pushbutton_holder2d_help');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(findobj(''Tag'',''Fig_gui_fl_holder2d''));', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.673333 0.03 0.233333 0.1], ...
	'String','Close', ...
	'Tag','Pushbutton_close');

fl_window_init(a);