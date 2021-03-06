function fig = gui_fl_estimGQV1DH()
% This is the machine-generated representation of a Handle Graphics object
% and its children.  Note that handle values may change when these objects
% are re-created. This may cause problems with any callbacks written to
% depend on the value of the handle at the time the object was saved.
%
% To reopen this object, just type the name of the M-file at the MATLAB
% prompt. The M-file and its associated MAT-file must be on your path.


a = figure( ...
	'HandleVisibility','callback', ...
	'MenuBar','none', ...
	'Position',[20 50 350 260], ...
	'Units','pixels', ...
	'UserData',struct('Function',0,'Precision_frontier',10,'Frontier',0,'Length',1,'Choice_estim',0,'Choice_example',0,'Exponents',0), ...
	'Tag','Fig_gui_fl_estimGQV1DH');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Title FRAME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.347826086956521, ...
	'ListboxTop',0, ...
	'Position',[0.05 0.817087 0.92 0.143349], ...
	'Style','frame', ...
	'Tag','Frame_title');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.576923076923077, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.065 0.852 0.9 0.08], ...
	'String','GQV-based Estimation of the Holder function of mBm', ...
	'Style','text', ...
	'Tag','StaticText_Title');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INPUT FRAME    
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.266666666666666, ...
	'ListboxTop',0, ...
	'Position',[0.05 0.596 0.92 0.2], ...
	'Style','frame', ...
	'Tag','Frame_input');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.607287449392713, ...
	'FontWeight','bold', ...
	'HorizontalAlignment','left', ...
	'ListboxTop',0, ...
	'Position',[0.075 0.656 0.22 0.076], ...
	'String','Input Signal', ...
	'Style','text', ...
	'Tag','StaticText_input');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'FontSize',0.533333333333332, ...
	'HorizontalAlignment','center', ...
	'ListboxTop',0, ...
	'Position',[0.3466666666666667 0.656 0.3333333333333334 0.08], ...
	'String','', ...
	'Style','edit', ...
	'Enable','inactive',...
	'Tag','EditText_input');

    b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimGQV1DH_compute(''launch'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7133333333333334 0.636 0.2333333333333333 0.12], ...
	'String','Refresh', ...
	'Tag','Pushbutton_refreshInput');


b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.168421052631579, ...
	'ListboxTop',0, ...
	'Position',[0.05 0.236 0.92 0.34], ...
	'Style','frame', ...
	'Tag','Frame_input');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'Position',[0.08 0.475 0.15 0.06], ...
	'String','gamma', ...
	'Style','text', ...
	'Tag','StaticText_gamma');
	
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_estimGQV1DH_compute(''edit_gamma'');', ...
	'FontSize',0.659340659340659, ...
	'Position',[0.28 0.475 0.15 0.07], ...
	'String','0.6', ...
    	'Style','edit', ...
	'Tag','EditText_gamma');
	

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.7, ...
	'Position',[0.58 0.475 0.1 0.06], ...
	'String','delta', ...
	'Style','text', ...
	'Tag','StaticText_delta');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_estimGQV1DH_compute(''edit_delta'');', ...
	'FontSize',0.659340659340659, ...
	'Position',[0.75 0.475 0.15 0.07], ...
	'String','1', ...
    	'Style','edit', ...
	'Tag','EditText_delta');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimGQV1DH_compute(''radiobutton_regression'')', ...
	'FontSize',0.533333333333332, ...
	'Position',[0.1 0.38 0.4 0.08], ...
	'String','Regression', ...
	'Style','Checkbox', ...
	'Tag','Radiobutton_regression', ...
   	'Value',1);

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.35, ...
	'Position',[0.06 0.265 0.2 0.12], ...
	'String','Initial sub-sampling', ...
	'Style','text', ...
	'Tag','StaticText_k1');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_estimGQV1DH_compute(''edit_k1'');', ...
	'FontSize',0.659340659340659, ...
	'Position',[0.28 0.3 0.15 0.07], ...
	'String','1', ...
    	'Style','edit', ...
	'Tag','EditText_k1');
	
	
	
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'FontSize',0.35, ...
	'Position',[0.53 0.265 0.2 0.12], ...
	'String','Final sub-sampling', ...
	'Style','text', ...
	'Tag','StaticText_k2');

b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'BackgroundColor',[1 1 1], ...
	'Callback','fl_estimGQV1DH_compute(''edit_k2'');', ...
	'FontSize',0.659340659340659, ...
	'Position',[0.75 0.3 0.15 0.07], ...
	'String','5', ...
    	'Style','edit', ...
	'Tag','EditText_k2');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','eval([''global '' fl_estimGQV1DH_compute(''compute'',who)]);', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.05 0.076 0.2333333333333333 0.12], ...
	'String','Compute', ...
	'Tag','button_compute');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
  'Callback','fl_estimGQV1DH_compute(''help'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.3966666666666667 0.076 0.2333333333333333 0.12], ...
	'String','Help', ...
	'Tag','button_help');
b = uicontrol('Parent',a, ...
	'Units','normalized', ...
	'FontUnits','normalized', ...
	'Callback','fl_estimGQV1DH_compute(''close'');', ...
	'FontSize',0.399999999999999, ...
	'FontWeight','bold', ...
	'ListboxTop',0, ...
	'Position',[0.7300000000000001 0.076 0.2333333333333333 0.12], ...
	'String','Close', ...
	'Tag','button_close');
	
fl_window_init(a);	
	
if nargout > 0, fig = a; end

fl_estimGQV1DH_compute('launch');
