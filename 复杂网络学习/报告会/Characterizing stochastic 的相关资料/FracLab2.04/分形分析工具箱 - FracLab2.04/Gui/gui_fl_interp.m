function gui_fl_interp()
% This is the machine-generated representation of a MATLAB object
% and its children.  Note that handle values may change when these
% objects are re-created. This may cause problems with some callbacks.
% The command syntax may be supported in the future, but is currently 
% incomplete and subject to change.
%
% To re-open this system, just type the name of the m-file at the MATLAB
% prompt. The M-file and its associtated MAT-file must be on your path.
              

% [SigIn_name error_in] = fl_get_input ('vector') ;
% eval(['global ',SigIn_name]) ;
% SigIn = eval(SigIn_name) ;
% N = length(SigIn) ;

a = figure( ...
	...'Colormap',mat0, ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Name','Holderian interpolation of 1D and 2D signals', ...
	'Position',[20 50 480 270], ...
	'Tag','Fig_gui_fl_interp', ...
	'UserData','a');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.273971999999999, ...
	'Position',[0.0833333 0.76 0.833333 0.21], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_interp');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.256410666666666, ...
	'Position',[0.0833333 0.264423 0.833333 0.274038], ...
	'Style','frame', ...
	'Tag','Frame_gui_fl_interp2');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.556321333333332, ...
	'FontWeight','bold', ...
	'Position',[0.213333 0.86 0.56 0.076], ...
	'String','Holderian interpolation', ...
	'Style','text', ...
	'Tag','StaticText_interp_title1');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.551723999999999, ...
	'FontWeight','bold', ...
	'Position',[0.213333 0.78 0.56 0.076], ...
	'String','1D and 2D signals', ...
	'Style','text', ...
	'Tag','StaticText_interp_title2');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.09 0.414 0.25 0.076], ...
	'String','Number of interpolations', ...
	'Style','text', ...
	'Tag','StaticText_interp_param');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_interp_compute(''edit_param'');', ...
	'FontSize',0.532, ...
	'Position',[0.35 0.416 0.05 0.08], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','EditText_interp_param');


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.43+0.05 0.414 0.15 0.076], ...
	'String','Start Level', ...
	'Style','text', ...
	'Tag','StaticText_interp_param_debut');


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_interp_compute(''edit_param_debut'');', ...
	'FontSize',0.532, ...
	'Position',[0.59+0.05 0.416 0.05 0.08], ...
	'String','2', ...
	'Style','edit', ...
	'Tag','EditText_interp_param_debut');


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.65+0.05 0.414 0.15 0.076], ...
	'String','End Level', ...
	'Style','text', ...
	'Tag','StaticText_interp_param_fin');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_interp_compute(''edit_param_fin'');', ...
	'FontSize',0.532, ...
	'Position',[0.8+0.05 0.416 0.05 0.08], ...
	'String','4', ...
	'Style','edit', ...
	'Tag','EditText_interp_param_fin');


% b = uicontrol('Parent',a, ...
% 	'Units','normalized', ...
% 	'FontUnits','normalized', ...
% 	'Callback','fl_interp_compute(''slider_param'');', ...
% 	'FontSize',0.55034469, ...
% 	'Max',5, ...
% 	'Position',[0.463333 0.416 0.3 0.076], ...
% 	'Style','slider', ...
% 	'Tag','Slider_interp_param', ...
% 	'Value',1);


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_interp_compute(''compute'',who);]);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.0833333 0.072 0.233333 0.12], ...
	'String','Compute', ...
	'Tag','Pushbutton_interp_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_interp_compute(''help'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'Position',[0.38 0.072 0.233333 0.12], ...
	'String','Help', ...
	'Tag','Pushbutton_interp_help');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','close(findobj(''Tag'',''Fig_gui_fl_interp''));fl_clearerror;', ...
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
	'Tag','Frame_input_interp');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.634920634920635, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'Position',[0.15 0.62 0.4 0.07], ...
	'String','Analysed signal', ...
	'Style','text', ...
	'Tag','StaticText_input_interp');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_interp_compute(''refresh'');', ...
	'FontSize',0.493827160493827, ...
	'FontWeight','bold', ...
	'Position',[0.73 0.62 0.175 0.09], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refresh_interp');
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
	'Tag','EditText_sig_nname_interp');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.55034469, ...
	'Position',[0.09 0.29 0.15 0.076], ...
	'String','Wavelet', ...
	'Style','text', ...
	'Tag','StaticText_interp_level');
% b = uicontrol('Parent',a, ...
% 	'Units','normalized', ...
% 	'FontUnits','normalized', ...
% 	'BackgroundColor',[1 1 1], ...
% 	'Callback','fl_dinterp_compute(''edit_level'');', ...
% 	'FontSize',0.532, ...
% 	'Position',[0.3 0.3 0.1 0.08], ...
% 	'String',num2str(ceil(log2(N)/2)), ...
% 	'Style','edit', ...
% 	'Tag','EditText_interp_level');

%%%%%%%%%%%%%%%%%%%%


%matond{1}='daubechies  2';
%matond{2}='daubechies  4';
%matond{3}='daubechies  6';
%matond{4}='daubechies  8';
%matond{5}='daubechies 10';
%matond{6}='daubechies 12';
%matond{7}='daubechies 14';
%matond{8}='daubechies 16';
%matond{9}='daubechies 18';
%matond{10}='daubechies 20';
%matond{11}='coiflet  6';
%matond{12}='coiflet 12';
%matond{13}='coiflet 18';
%matond{14}='coiflet 24';
%matond{15}='Triangle (interpolating wavelet)';

matond{1}='Triangle (interpolating wavelet)';


% b = uicontrol('Parent',a, ...
% 	'Units','normalized', ...
% 	'FontUnits','normalized', ...
% 	'FontSize',0.513792999999999, ...
% 	'Position',[0.4386 0.142 0.15 0.076], ...
% 	'String','Wavelet', ...
% 	'Style','text', ...
% 	'Tag','StaticText_interp_wavelet');


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_interp_compute(''ondelette'');', ...
	'FontSize',0.607097, ...
	'Max',3, ...
	'Min',1, ...
	'Position',[0.25 0.31 0.5 0.07], ...
	'String',matond, ...
	'Style','popupmenu', ...
	'Tag','PopupMenu_interp_wtype', ...
	'Value',1);


fl_window_init(a);


fl_interp_compute('refresh');
