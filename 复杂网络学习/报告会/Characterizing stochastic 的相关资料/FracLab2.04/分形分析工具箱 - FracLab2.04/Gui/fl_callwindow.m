function fl_callwindow(tag,gui_name)
% Usage: fl_callwindow(tag,gui_name)
%
% Call the GUI window "gui_name" which tag is "tag".
% If the window is already present, just puts it in foreground.

figh=findobj('Tag',tag);
if isempty(figh)
  eval(gui_name);
else
  figure(figh);
end