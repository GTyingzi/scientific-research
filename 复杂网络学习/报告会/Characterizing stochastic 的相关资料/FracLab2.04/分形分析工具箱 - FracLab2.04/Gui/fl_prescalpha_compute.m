function varargout=fl_gifs_function(varargin)


% Callback functions for the GIFS GUI.
% MODIFICATIONS DE BERTRAND : toutes les strcmp(r,'') 
% remplaces par isempty(r).

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

case 'edittext_holderfunct'
        
	holderfunct=get(gcbo,'String');

case 'ppm_holderfunct'
	ppmValue=get(gcbo,'Value');
        switch ppmValue
           case 1, 	
			EditHandle=findobj('Tag','EditText_holderfunct');
		   	set(EditHandle,'String', ...
               		'0.2*(1-floor(2*t))+0.8*floor(2*t)') ;
           case 2, 	
			EditHandle=findobj('Tag','EditText_holderfunct');
		   	set(EditHandle,'String', ...
			't') ;
	   case 3,
		        EditHandle=findobj('Tag','EditText_holderfunct');
			set(EditHandle,'String', ...
			'abs(sin(3*pi*t))') ;
		    
           case 4, 	EditHandle=findobj('Tag','EditText_holderfunct');
		   	set(EditHandle,'String','example: 2*sqrt(t*(1-t)), then press RETURN') ;
           end
	
case 'gifs_edittext_iter'
	string = get(gcbo,'String') ;
	val = str2num(string) ;
	set(findobj('Tag','Slider_gifs_iter'),'Value',val);

case 'gifs_slider_iter'
	val = get(gcbo,'Value');
	string = num2str(floor(val)) ;
	set(findobj('Tag','EditText_gifs_iter'),'String',string);

case 'gifs_compute'
	%% permet d'afficher la montre et de se souvenir
	%% de la tete du pointeur souris actuel
	mon_pointeur_courant=fl_waiton;
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

		%%%% Get the Holder function %%%%
	EditHandle=findobj('Tag','EditText_holderfunct');
	holderfunct = get(EditHandle,'String') ;

		%%%% Get the number of iteration %%%

	edit_iter_h = findobj('Tag','EditText_gifs_iter');
	iter = floor(str2num(get(edit_iter_h,'String')));

		%%%%% Get a name for the output cell %%%%%
	[varname1 varname2] = fl_find_mnames(varargin{2},'prescribedH_','prescribedH_ord_');
	eval(['global ' varname1]);
	eval(['global ' varname2]);
	
		%%%%% Perform the computation %%%%

	[x y] = prescrib(Int,holderfunct,iter) ;
	eval ([varname1 '= struct (''type'',''graph'',''data1'',x,''data2'',y,''title'',''GIFS attractor with prescribed Holder function'',''xlabel'',''x'',''ylabel'',''y'');']);
	fl_addlist(0,varname1);

	eval ([varname2 '=y;']) ;
    
    
    
    chaine=['[',varname1,',',varname2,']=prescrib(['...
        num2str(Int(1,:)),';',num2str(Int(2,:)),';',num2str(Int(3,:))...
        ,'],''',holderfunct,''',',num2str(iter),');'];
    
    fl_diary(chaine);
	
	fl_addlist(0,varname2);
	
	varargout{1} = [varname1 ' ' varname2] ;
	
	 %% retablit l'ancien pointeur	 
	 fl_waitoff(mon_pointeur_courant);	
end
