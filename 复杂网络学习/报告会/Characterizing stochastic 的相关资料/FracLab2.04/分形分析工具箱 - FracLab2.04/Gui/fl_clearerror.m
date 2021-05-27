function fl_clearerror()
%		FRACLAB function
% Clear the text of the StaticText dedicated to error messages.
% No input/output.
  sth=findobj('Tag','StaticText_error');
  set(sth,'String','');

