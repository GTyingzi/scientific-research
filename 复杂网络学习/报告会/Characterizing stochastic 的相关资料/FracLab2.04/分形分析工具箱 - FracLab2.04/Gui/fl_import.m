% Modification P. Legrand, January 2005.
lbh3=findobj('Tag','Listbox_imp_type');
if (strcmp(lbh3, 'uint8') == 1) 
  fl_warning('Cant work with uint8 variables. Convert it in double.');
  return;
end

fl_import_obj=findobj('Tag','Listbox_imp_name');
fl_import_values=get(fl_import_obj,'Value');
fl_import_list=get(fl_import_obj,'String');
fl_import_temp=size(fl_import_values);
fl_import_l=fl_import_temp(2);
for fl_import_i=1:fl_import_l
  fl_import_val=fl_import_values(fl_import_i);
  fl_import_string=fl_import_list{fl_import_val};
  if isempty(whos('global',fl_import_string))    %(~isglobal(fl_import_string))
      warning_state=warning('off','all');
      eval(['global ' fl_import_string]);
      warning(warning_state);
  end
  fl_addlist(0,fl_import_string);
end
clear fl_import_values fl_import_val fl_import_obj fl_import_string;
clear fl_import_list fl_import_temp fl_import_l fl_import_i;
clear lbh3;