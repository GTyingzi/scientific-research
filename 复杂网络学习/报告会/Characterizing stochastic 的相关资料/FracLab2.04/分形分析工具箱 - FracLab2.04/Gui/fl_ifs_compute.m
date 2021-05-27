function varargout=fl_ifs_function(varargin)

% Callback functions for the IFS GUI.

% Modification P. Legrand, January 2005.


switch(varargin{1})

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%  Main IFS Window %%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'ifs_edittext_interp'
	string = get(gcbo,'String') ;


case 'ifs_edittext_ratio'
	string = get(gcbo,'String') ;


case 'ifs_ppm_type'
        string = get(gcbo,'String');
        val = get(gcbo,'Value');
        type = string{val} ;
	
case 'ifs_edittext_points'
	string = get(gcbo,'String') ;
	val = str2num(string) ;
	
case 'ifs_compute'
	%% permet d'afficher la montre et de se souvenir
	%% de la tete du pointeur souris actuel
	mon_pointeur_courant=fl_waiton;
		%%%% Get the interpolation points %%%%

	edit_interp_h = findobj('Tag','EditText_ifs_interp');
	string_interp = get(edit_interp_h,'String');
	Int = eval(string_interp);

		%%%% Get the interpolation points %%%%

	edit_ratio_h = findobj('Tag','EditText_ifs_ratio');
	string_ratio = get(edit_ratio_h,'String');
	coefs = eval(string_ratio);;
	
		%%%% Get the number of points %%%

	edit_points_h = findobj('Tag','EditText_ifs_points');
	iter = floor(str2num(get(edit_points_h,'String')));
	
		%%%% Get the IFS type %%%
        edit_type_h = findobj('Tag','PopupMenu_ifs_type');
        string_type = get(edit_type_h,'String');
        val_type = get(edit_type_h,'Value');
        type = string_type{val_type} ;
		
		%%%%% Get a name for the output cell %%%%%
	[varname1 varname2] = fl_find_mnames(varargin{2},'ifs_','ifs_ord_');
	eval(['global ' varname1]);
	eval(['global ' varname2]);
	
		%%%%% Perform the computation %%%%

	[x y] = fif(Int,coefs,iter,type) ;
	z = [x y] ;
	X = sortrows(z,1) ;
	x = X(:,1) ;
	y = X(:,2) ;
	eval ([varname1 '= struct (''type'',''graph'',''data1'',x,''data2'',y,''title'',[type '' fractal interpolation function''],''xlabel'',''x'',''ylabel'',''y'');']);
	fl_addlist(0,varname1);

	eval ([varname2 '=y;']) ;
	varargout{1} = [varname1 ' ' varname2] ;
%     

    
    chaine=['[x000 y000]=fif(', string_interp,...
    ',',string_ratio,',',num2str(iter),',''',num2str(type),'''); z000 = [x000 y000] ;',...
	'X000 = sortrows(z000,1) ; x000 = X000(:,1) ;',	varname2,' = X000(:,2) ;'];
        
        
    fl_diary(chaine)
    

	fl_addlist(0,varname2);

	 %% retablit l'ancien pointeur	 
	 fl_waitoff(mon_pointeur_courant);
end
