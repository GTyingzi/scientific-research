function varargout=fl_gifs_compute(varargin)


% Callback functions for the GIFS GUI.
% MODIFICATIONS DE BERTRAND : toutes les strcmp(r,'') 
% remplaces par isempty(r).
% Modifs Pierrick  [a b] par [a,b]

% Modification P. Legrand, January 2005.

switch(varargin{1})

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%  Main GIFS Window %%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'gifs_edittext_interp1'
	string = get(gcbo,'String') ;
	r=string ;
	var=cell(1);
	i=1;
	bool = 0  ;
	while(~isempty(r))
		[var{i},r]=strtok(r) ;
		i=i+1;
	end
	l=i-1;
	for i=1:l,
		val(i) = str2num(var{i}) ;
		if(isempty(val(i)))
			bool = 1 ;
		end
	end
	if(bool)
		string = 'Interpolation points must be scalars' ;
		set(gcbo,'String',string) ; 	
	end
case 'gifs_edittext_interp2'
	string = get(gcbo,'String') ;
	r=string ;
	var=cell(1);
	i=1;
	bool = 0  ;
	while(~isempty(r))
		[var{i},r]=strtok(r) ;
		i=i+1;
	end

case 'gifs_edittext_interp3'
	string = get(gcbo,'String') ;
	r=string ;
	var=cell(1);
	i=1;
	bool = 0  ;
	while(~isempty(r))
		[var{i},r]=strtok(r) ;
		i=i+1;
	end

case 'gifs_edittext_ratio1'
	string = get(gcbo,'String') ;
	r = string ;
	var=cell(1);
	i=1 ;
	while(~isempty(r))
		[var{i},r]=strtok(r) ;
		i=i+1;
	end
	l=i-1 ;
case 'gifs_edittext_ratio2'
	string = get(gcbo,'String') ;
	r = string ;
	var=cell(1);
	i=1 ;
	while(~isempty(r))
		[var{i},r]=strtok(r) ;
		i=i+1;
	end
	l=i-1 ;
	
case 'gifs_edittext_iter'
	string = get(gcbo,'String') ;
	val = str2num(string) ;
	set(findobj('Tag','Slider_gifs_iter'),'Value',val);

case 'gifs_slider_iter'
	val = get(gcbo,'Value');
	string = num2str(floor(val)) ;
	set(findobj('Tag','EditText_gifs_iter'),'String',string);

case 'gifs_edittext_beta'
	string = get(gcbo,'String') ;
	val = str2num(string) ;
	set(findobj('Tag','Slider_gifs_beta'),'Value',val);

case 'gifs_slider_beta'
	val = get(gcbo,'Value');
	string = num2str(val) ;
	set(findobj('Tag','EditText_gifs_beta'),'String',string);

case 'gifs_ppm_law'
	string = get(gcbo,'String');
	val = get(gcbo,'Value');
	law = string{val} ;
      
case 'gifs_compute'
	
	%% permet d'afficher la montre et de se souvenir
	%% de la tete du pointeur souris actuel
	mon_pointeur_courant = fl_waiton;
	
	%%%% Get the first interpolation point %%%%

	edit_interp_h = findobj('Tag','EditText_gifs_interp1');
	string_interp = get(edit_interp_h,'String');
	r_interp = string_interp ;
	var_interp = cell(1);
	i=1 ;
	while(~isempty(r_interp))
		[var_interp{i},r_interp]=strtok(r_interp) ;
		i=i+1;
	end
	Int(1,1) = str2num(var_interp{1});
	Int(1,2) = str2num(var_interp{2});

		%%%% Get the second interpolation point %%%%

	edit_interp_h = findobj('Tag','EditText_gifs_interp2');
	string_interp = get(edit_interp_h,'String');
	r_interp = string_interp ;
	var_interp = cell(1);
	i=1 ;
	while(~isempty(r_interp))
		[var_interp{i},r_interp]=strtok(r_interp) ;
		i=i+1;
	end
	Int(2,1) = str2num(var_interp{1});
	Int(2,2) = str2num(var_interp{2});

		%%%% Get the third interpolation point %%%%

	edit_interp_h = findobj('Tag','EditText_gifs_interp3');
	string_interp = get(edit_interp_h,'String');
	r_interp = string_interp ; 
	var_interp = cell(1);
	i=1 ;
	while(~isempty(r_interp))
		[var_interp{i},r_interp]=strtok(r_interp) ;
		i=i+1;
	end
	Int(3,1) = str2num(var_interp{1});
	Int(3,2) = str2num(var_interp{2});

		%%%% Get the first coefficient ratio %%%%

	edit_ratio_h = findobj('Tag','EditText_gifs_ratio1');
	string_ratio = get(edit_ratio_h,'String');
	r_ratio = string_ratio ;
	var_ratio = cell(1);
	i=1 ;
	while(~isempty(r_ratio))
		[var_ratio{i},r_ratio]=strtok(r_ratio) ;
		i=i+1;
	end
	l_ratio = i-1;
	
	coefs(1) = str2num(var_ratio{1}) ;

		%%%% Get the second coefficient ratio %%%%

	edit_ratio_h = findobj('Tag','EditText_gifs_ratio2');
	string_ratio = get(edit_ratio_h,'String');
	r_ratio = string_ratio ;
	var_ratio = cell(1);
	i=1 ;
	while(~isempty(r_ratio))
		[var_ratio{i},r_ratio]=strtok(r_ratio) ;
		i=i+1;
	end
	l_ratio = i-1;
	
	coefs(2) = str2num(var_ratio{1}) ;

		%%%% Get the number of iteration %%%

	edit_iter_h = findobj('Tag','EditText_gifs_iter');
	iter = floor(str2num(get(edit_iter_h,'String'))) ;

		%%%% Get the law type %%%%

	edit_law_h = findobj('Tag','PopupMenu_gifs_law');
	string_law = get(edit_law_h,'String');
	val_law = get(edit_law_h,'Value');
	law = string_law{val_law} ;

		%%%% Get Beta %%%

	edit_beta_h = findobj('Tag','EditText_gifs_beta');
	beta = str2num(get(edit_beta_h,'String'));

		%%%%% Get a name for the output structure  %%%%%
	
	[varname1 varname2 varname3] = fl_find_mnames(varargin{2},'sgifs_','sgifs_ord_','sgifs_ci_');
	%[varname1] = fl_findname('sgifs_',varargin{2});
	%[varname2] = fl_findname('sgifs_ord_',varargin{2}) ;
	%[varname3] = fl_findname('sgifs_ci_',varargin{2}) ;
	eval(['global ',varname1]);
	eval(['global ',varname2]);
	eval(['global ',varname3]);
		%%%%% Perform the computation %%%%
%% ATTENTION : MODIF EFFECTUEE PAR BERTRAND LE 12/02/98 -> gifs( devient sgifs(.
	[x y C] = sgifs(Int,coefs,iter,law,beta);
        eval ([varname1,'= struct (''type'',''graph'',''data1'',x,''data2'',y,''title'',[''Statistical SGIFS with ',law ,' distribution''],''xlabel'',''x'',''ylabel'',''y'');']);
		%%%%% Add to ouput list %%%%%
	
	
		%%%%% Get a name for the second output %%%%%
	eval ([varname2,'=y;',]) ;
	fl_addlist(0,varname2);

		%%%%% Get a name for the third output %%%%%
	eval ([varname3,'=C;',]) ;
	varargout{1} = [[varname1],' ',[varname2],' ',[varname3]] ;
	fl_addlist(0,varname3);
	fl_addlist(0,varname1);
    
    
    chaine=['[',varname1,'.data1,',varname1,'.data2]=sgifs(',...
        string_interp,...
        ',',num2str(coefs),',',num2str(iter),',''',num2str(law),''',',...
        num2str(beta),');'];
    fl_diary(chaine)
    
	 %% retablit l'ancien pointeur	 
	 fl_waitoff(mon_pointeur_courant);	
	
end






