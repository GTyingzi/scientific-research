function gui_fl_reg()
% This is the machine-generated representation of a MATLAB object
% and its children.  Note that handle values may change when these
% objects are re-created. This may cause problems with some callbacks.
% The command syntax may be supported in the future, but is currently 
% incomplete and subject to change.
%
% To re-open this system, just type the name of the m-file at the MATLAB
% prompt. The M-file and its associtated MAT-file must be on your path.
                

[SigIn_name error_in] = fl_get_input ('vector') ;
eval(['global ',SigIn_name]) ;
SigIn = eval(SigIn_name) ;
N = length(SigIn) ;

a = figure( ...
	'Colormap',[], ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Name','Multifractal regularization of 1D and 2D signals', ...
	'Position',[20 50 320 270], ...
	'Tag','Fig_gui_fl_reglog', ...
	'UserData','a');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.273971999999999, ...
	'Position',[0.0833333 0.76 0.833333 0.21], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_reglog');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.256410666666666, ...
	'Position',[0.0833333 0.264423 0.833333 0.274038], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_reglog2');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.556321333333332, ...
	'FontWeight','bold', ...
	'Position',[0.113333 0.86 0.76 0.076], ...
	'String','Multifractal regularization (Kullback norm)', ...
	'Style','text', ...
	'Tag','StaticText_reglog_title1');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551723999999999, ...
	'FontWeight','bold', ...
	'Position',[0.213333 0.78 0.56 0.076], ...
	'String','1D and 2D signals', ...
	'Style','text', ...
	'Tag','StaticText_reglog_title2');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.088 0.414 0.35 0.076], ...
	'String','Regularity Increase', ...
	'Style','text', ...
	'Tag','StaticText_reglog_param');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_reglog_compute(''edit_param'');', ...
	'FontSize',0.532, ...
	'Position',[0.8 0.416 0.1 0.08], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText_reglog_param');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_reglog_compute(''slider_param'');', ...
	'FontSize',0.55034469, ...
	'Max',5, ...
	'Position',[0.463333 0.416 0.3 0.076], ...
	'Style','slider', ...
	'Tag','Slider_reglog_param', ...
	'Value',1);
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_reglog_compute(''compute'',who);]);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.0833333 0.072 0.233333 0.12], ...
	'String','Compute', ...
	'Tag','Pushbutton_reglog_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_reglog_compute(''help'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.38 0.072 0.233333 0.12], ...
	'String','Help', ...
	'Tag','Pushbutton_reglog_help');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(findobj(''Tag'',''Fig_gui_fl_reglog''));fl_clearerror;', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.676667 0.072 0.233333 0.12], ...
	'String','Close', ...
	'Tag','Pushbutton_close');



%% refresh Frame
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.341880341880342, ...
	'Position',[0.0833333 0.6 0.833333 0.13], ...
	'Style','frame', ...
	'Tag','Frame_input_reglog');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.634920634920635, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'Position',[0.09 0.62 0.4 0.07], ...
	'String','Analysed signal', ...
	'Style','text', ...
	'Tag','StaticText_input_reglog');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_reglog_compute(''refresh'');', ...
	'FontSize',0.493827160493827, ...
	'FontWeight','bold', ...
	'Position',[0.73 0.62 0.175 0.09], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refresh_reglog');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.634920634920635, ...
	'HorizontalAlignment','left', ...
	'Position',[0.42 0.63 0.28 0.07], ...
	'String','', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_sig_nname_reglog');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.09 0.29 0.2 0.076], ...
	'String','Start level', ...
	'Style','text', ...
	'Tag','StaticText_reglog_level');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_dreg_compute(''edit_level'');', ...
	'FontSize',0.532, ...
	'Position',[0.3 0.3 0.1 0.08], ...
	'String',num2str(ceil(log2(N)/2)), ...
	'Style','edit', ...
	'Tag','EditText_reglog_level');

%%%%%%%%%%%%%%%%%%%%


matond{1}='daubechies  2';
matond{2}='daubechies  4';
matond{3}='daubechies  6';
matond{4}='daubechies  8';
matond{5}='daubechies 10';
matond{6}='daubechies 12';
matond{7}='daubechies 14';
matond{8}='daubechies 16';
matond{9}='daubechies 18';
matond{10}='daubechies 20';
matond{11}='coiflet  6';
matond{12}='coiflet 12';
matond{13}='coiflet 18';
matond{14}='coiflet 24';


% b = uicontrol('Parent',a, ...
% 	'Units','normalized', ...
% 	'FontUnits','normalized', ...
% 	'FontSize',0.513792999999999, ...
% 	'Position',[0.4386 0.142 0.15 0.076], ...
% 	'String','Wavelet', ...
% 	'Style','text', ...
% 	'Tag','StaticText_reglog_wavelet');


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_reglog_compute(''ondelette'');', ...
	'FontSize',0.587097, ...
	'Max',3, ...
	'Min',1, ...
	'Position',[0.56 0.31 0.3425 0.07], ...
	'String',matond, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_reglog_wtype', ...
	'Value',5);


fl_window_init(a);


fl_reglog_compute('refresh');
