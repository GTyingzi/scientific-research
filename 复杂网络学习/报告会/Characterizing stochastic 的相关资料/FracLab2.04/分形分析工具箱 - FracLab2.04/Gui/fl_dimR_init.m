
fl_clearerror;
global handlefig_dimR;

fl_callwindow('Fig_gui_fl_dimR','gui_fl_dimR');

handlefig_dimR=[gcf];
fl_dimR_compute('refresh');



