 function [varargout]=fl_tools_choice(varargin)
 
 switch(varargin{1})
   
   case 'dilate'
     
     fl_callwindow('Fig_gui_fl_dilate','gui_fl_dilate') ;
     
   case 'fmt'
     
     fl_callwindow('Fig_gui_fl_fmt','gui_fl_fmt') ;
     
   case 'theospec'
     
     fl_callwindow('Fig_gui_fl_bp','gui_fl_bp') ;

 end
