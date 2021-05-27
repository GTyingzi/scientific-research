function [string,flag] = fl_get_details();

% this function is intended to get the name of the highlighted var in
% the window "details"

[name error]= fl_get_input;

flag = 0;

if ~exist (name)
  eval ([ 'global ' name ';' ]);
end

if error 
  flag = 1;
  string = '';
  return
else
  eval (['fl_test1 = isstruct(', name, ');']);
  if fl_test1
    lbh = findobj('Tag','Listbox_details');
    var = get(lbh,'String');
    values = get(lbh,'Value');
    val = values(1);
    if val > 1 
      varname = strtok(var{val});
      string = [name '.' varname];
    else
      flag = 1;
      string = '';
      fl_warning (' please select a field ');
    end    
  else
    string = name;
  end
end
