function gui_fl_boxdim
% This is the machine-generated representation of a Handle Graphics object
% and its children.  Note that handle values may change when these objects
% are re-created. This may cause problems with any callbacks written to
% depend on the value of the handle at the time the object was saved.
% This problem is solved by saving the output as a FIG-file.
% 
% To reopen this object, just type the name of the M-file at the MATLAB
% prompt.     The M-file and its associated MAT-file must be on your path.
% 
% NOTE: certain newer features in MATLAB may not have been saved in this
% M-file due to limitations of this format, which has been superseded by
% FIG-files.  Figures which have been annotated using the plot editor tools
% are incompatible with the M-file/MAT-file format, and should be saved as
% FIG-files.



h1 = figure(...
'PaperUnits',get(0,'defaultfigurePaperUnits'),...
'MenuBar','none',...
'Resize','off',...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'PaperPosition',[0.6345175 6.345175 20.30456 15.22842],...
'PaperSize',[20.98404194812 29.67743169791],...
'PaperType',get(0,'defaultfigurePaperType'),...
'Position',[68 157 380 340],...
'HandleVisibility','callback',...
'Tag','Fig_gui_fl_boxdim');

h2 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.0289473684210526 0.435294117647059 0.944736842105263 0.323529411764706],...
'Style','frame',...
'Tag','Frame_size');

h4 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.0289473684210526 0.9 0.947368421052632 0.0852941176470588],...
'Style','frame',...
'Tag','Frame1');


h5 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'Callback','fl_boxdim_compute(''close'');',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.718421052631579 0.114705882352941 0.173684210526316 0.0735294117647059],...
'String','Close',...
'Tag','Pushbutton_wclose');


h6 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'Callback','fl_boxdim_compute(''compute_boxdim'');',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.0947368421052632 0.114705882352941 0.173684210526316 0.0735294117647059],...
'String','Compute',...
'Tag','Pushbutton_boxdim_compute');


h7 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.109726 0.0349999 0.399001 0.05],...
'String','Box Dimension =',...
'Style','text',...
'Tag','StaticText7');


h8 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',13,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.139473684210526 0.917647058823529 0.726315789473684 0.05],...
'String','Box  Dimension',...
'Style','text',...
'Tag','StaticText6');


h9 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'BackgroundColor',[1 1 1],...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.620949 0.0349999 0.279302 0.0500001],...
'Style','edit',...
'Tag','EditText_boxdim');


h10 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'Callback','fl_boxdim_compute(''help'');',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.407894736842105 0.114705882352941 0.173684210526316 0.0735294117647059],...
'String','Help',...
'Tag','Pushbutton1');


h11 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.0289473684210526 0.205882352941176 0.947368421052632 0.214705882352941],...
'Style','frame',...
'Tag','frame2');


h12 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.410526315789474 0.361764705882353 0.178947368421053 0.0470588235294118],...
'String','Regression',...
'Style','text',...
'Tag','StaticText_reg');


h13 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.112631578947368 0.23235294117647 0.1 0.0911764705882353],...
'String','Type',...
'Style','text',...
'Tag','StaticTextf_regtype');


h14 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'Callback','fl_boxdim_compute(''ppm_regtype'');',...
'FontSize',12,...
'BackgroundColor','w',...
'ListboxTop',0,...
'Max',2,...
'Min',1,...
'Position',[0.218421052631579 0.241176470588235 0.318421052631579 0.0911764705882353],...
'String',{ 'Least Square' 'Weighted Least Square' 'Penalized Least Square' 'Maximum Likelihood' 'Lepskii Adap. Proc.' 'Lim inf' 'Lim sup' },...
'Style','popupmenu',...
'Value',1,...
'Tag','PopupMenu_regtype');


h15 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.58421052631579 0.241176470588235 0.123684210526316 0.0794117647058823],...
'String','Range',...
'Style','text',...
'Tag','StaticTextf_regrange');

h16 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'Callback','fl_boxdim_compute(''radiobutton_reg'');',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.707894736842105 0.255882352941176 0.2 0.0794117647058823],...
'String','Specify',...
'Style','checkbox',...
'Value',1,...
'Tag','Radiobutton_reg');


h17 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.0298754 0.771251 0.947755 0.11],...
'Style','frame',...
'Tag','Frame_input');


h18 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'FontWeight','bold',...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[0.0789473684210526 0.797058823529412 0.25 0.05],...
'String','Input data name',...
'Style','text',...
'Tag','StaticText_input');

h19 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'Callback','fl_boxdim_compute(''refresh'');',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.768421052631579 0.785294117647059 0.173684210526316 0.0735294117647059],...
'String','Refresh',...
'Tag','Pushbutton_refresh');

h20 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'BackgroundColor',[1 1 1],...
'FontSize',12,...
'HorizontalAlignment','left',...
'ListboxTop',0,...
'Position',[0.339473684210526 0.797058823529412 0.4 0.05],...
'String','',...
'Style','edit',...
'Enable','inactive',...
'Tag','EditText_sig_nname');


h21 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'ListboxTop',0,...
'Position',[0.0631578947368421 0.470588235294118 0.213157894736842 0.0470588235294118],...
'String','Aspect Ratio',...
'Style','text',...
'Tag','StaticText_ratio');


h21 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'BackgroundColor',[1 1 1],...
'Callback','fl_boxdim_compute(''editRatio'');',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.278947368421053 0.461764705882353 0.402631578947368 0.0617647058823529],...
'String','1          1',...
'Style','edit',...
'Tag','EditText_Ratio');


h23 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Position',[0.297368421052632 0.635294117647059 0.136842105263158 0.0411764705882353],...
'String','min size',...
'Style','text',...
'Tag','Text');

h25 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Position',[0.0868421052631579 0.632352941176471 0.136842105263158 0.0411764705882353],...
'String','max size',...
'Style','text',...
'Tag','text2');

h26 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Position',[0.502631578947368 0.635294117647059 0.181578947368421 0.0411764705882353],...
'String','# of box sizes',...
'Style','text',...
'Tag','text3');


h27 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'BackgroundColor',[1 1 1],...
'Callback','fl_boxdim_compute(''editScaleNumber'')',...
'ListboxTop',0,...
'Position',[0.505263157894737 0.561764705882353 0.168421052631579 0.0588235294117647],...
'String','8',...
'Style','edit',...
'Tag','ScaleNumber');


h28 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Position',[0.736842105263158 0.635294117647059 0.157894736842105 0.0411764705882353],...
'String','progression',...
'Style','text',...
'Tag','text4');


h29 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'BackgroundColor',[1 1 1],...
'ListboxTop',0,...
'Position',[0.702631578947368 0.558823529411765 0.228947368421053 0.0617647058823529],...
'String',{ 'power law' 'linear' },...
'Style','popupmenu',...
'Value',1,...
'Tag','progression');

h28 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'FontUnits','pixels',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[0.407894736842105 0.697058823529412 0.178947368421053 0.0470588235294118],...
'String','Box Sizes',...
'Style','text',...
'Tag','text6');

h3 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Callback','fl_boxdim_compute(''editPopupMin'');',...
'Position',[0.273684210526316 0.552941176470588 0.205263157894737 0.0676470588235294],...
'String',{ '1 / 2' '1 / 4' '1 / 8' '1 / 16' '1 / 32' '1 / 64' '1 / 128' '1 / 256' '1 / 512' '1 / 1024' '1 / 2048' '1 / 4096' 'Other ...' },...
'Background','w',...
'Style','popupmenu',...
'Value',1,...
'Tag','PopupMin');


%'Position',[0.0552631578947368 0.558823529411765 0.152631578947368 0.0617647058823529],...
h24 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'BackgroundColor',[1 1 1],...
'Callback','fl_boxdim_compute(''editTextMinSize'');',...
'ListboxTop',0,...
'Position',[0.273684210526316 0.558823529411765 0.162631578947368 0.0617647058823529],...
'String','2',...
'Style','edit',...
'Tag','TextMin');

h31 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Callback','fl_boxdim_compute(''editPopupMax'');',...
'Position',[0.0552631578947368 0.552941176470588 0.205263157894737 0.0676470588235294],...
'String',{ '1 / 2' '1 / 4' '1 / 8' '1 / 16' '1 / 32' '1 / 64' '1 / 128' '1 / 256' '1 / 512' '1 / 1024' '1 / 2048' '1 / 4096' 'Other ...'},...
'BackgroundColor','w',...
'Style','popupmenu',...
'Value',1,...
'Tag','PopupMax');


h32 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'BackgroundColor',[1 1 1],...
'Callback','fl_boxdim_compute(''editTextMaxSize'');',...
'ListboxTop',0,...
'Position',[0.0552631578947368 0.558823529411765 0.162631578947368 0.0617647058823529],...
'String','2',...
'Style','edit',...
'Tag','TextMax');

h33 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'ListboxTop',0,...
'Position',[0.7 0.471 0.245 0.044],...
'String','Normalize data',...
'Style','radiobutton',...
'Tag','NormData');

fl_window_init(h1);

set(h7,'BackgroundColor',fl_getOption('BackGroundColor'));
set(h7,'ForegroundColor',fl_getOption('AltFontColor'));