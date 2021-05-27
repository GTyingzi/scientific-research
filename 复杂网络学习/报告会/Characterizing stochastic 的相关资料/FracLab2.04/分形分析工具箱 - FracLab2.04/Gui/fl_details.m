% Usage : fl_details 
%
%
% Gets the highlighted var in the "Variables" Listbox and lists it's  
% details in the "Details" Listbox
%
% inputs: var's names
%
% outputs: none
%


temp_flag = 1;

%  * set src and target listbox

listbox_handle_src=findobj('Tag','Listbox_variables');
listbox_handle_target=findobj('Tag','Listbox_details');

%  * get the cell of src listbox
str_cell=get(listbox_handle_src,'String');

% * get the var of src listbox
if iscell(str_cell)
  % case non-empty src listbox
  num_val=get(listbox_handle_src,'Value');
  str_var=strtok(str_cell{num_val(1)});  
else
  % case empty src listbox
  return
end

eval (['global ' str_var]);

%            ****    modify target listbox     ****

% first, clear it 
set (listbox_handle_target,'Value',[]);
set (listbox_handle_target,'String','');

% get the type of the highlighted var in "Variables "

var_properties = whos(str_var);

% * print infos in "details" *

% if var is a matrix, just print its name and dimentions

if strcmp(var_properties.class, 'double')
    temp_flag = 0 ;
    str_out{1} = var_properties.name;	
    str_out{2} = ['Matrix [ '];
    temp_length = length(var_properties.size);
    for temp_i = 1:(temp_length - 1)
    	str_out{2} = [str_out{2},num2str(var_properties.size(temp_i)),' x '];
    end
    str_out{2} = [str_out{2},num2str(var_properties.size(temp_length)),' ]'];
    set (listbox_handle_target,'Value',1);
    set (listbox_handle_target,'String',str_out);
    clear str_out;
    clear temp_length;
end

% if var is a structure, print its name and fields

if strcmp(var_properties.class,'struct')
    temp_flag = 0 ;
    temp_str = [str_var,'.type'];
    str_out{1} = ['Structure of type ',eval(temp_str),' containing :'];
    temp_var = fieldnames(eval(str_var));
    for temp_i = 2:(length(temp_var))
      temp_str = [str_var,'.',temp_var{temp_i}];
      temp_size = size (eval(temp_str));
      temp_length = length(temp_size);
      str_out{temp_i} = ['   ',temp_var{temp_i},'  [ '];
      for temp_j = 1 : ( temp_length - 1 )
        str_out{temp_i} = [str_out{temp_i},num2str(temp_size(temp_j)),' x '];
      end
      str_out{temp_i} = [str_out{temp_i},num2str(temp_size(temp_length)),' ]'];
    end
    set (listbox_handle_target,'Value',1);
    set (listbox_handle_target,'String',str_out);
    clear str_out;  	
    clear temp_j;
    clear temp_var;
    clear temp_size;
    clear temp_str;
    clear temp_i;
end
clear temp_i;
if  (temp_flag == 1 )
    str_out{1} = 'Variable type not supported';
    set (listbox_handle_target,'Value',1);
    set (listbox_handle_target,'String',str_out);
    clear str_out;
end

clear num_val;
clear var_properties;
clear str_cell;
clear str_var;
clear listbox_handle_src;
clear listbox_handle_target;
clear temp_flag;







