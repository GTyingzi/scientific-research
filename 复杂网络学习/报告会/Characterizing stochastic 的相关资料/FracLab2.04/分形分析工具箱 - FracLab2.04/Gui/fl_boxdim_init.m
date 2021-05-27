function fl_boxdim_init(TypeEntree)
fl_clearerror;
global handlefig_boxdim;

fl_callwindow(['Fig_gui_fl_boxdim_',TypeEntree],'gui_fl_boxdim');

handlefig_boxdim=[gcf];
% Save the input type in the figure GUIdata
handles=guihandles(handlefig_boxdim);
handles.TypeEntree=TypeEntree;
guidata(handlefig_boxdim,handles);

switch(TypeEntree)
    case 'Signal'
        typeentreee='Grayscale data';
    case 'List'
        typeentreee='List of points';
    case 'Binary'
        typeentreee='Binary Data';
end

set(handles.StaticText6,'String',['Box Dimension : ',typeentreee]);
fl_boxdim_compute('refresh');
