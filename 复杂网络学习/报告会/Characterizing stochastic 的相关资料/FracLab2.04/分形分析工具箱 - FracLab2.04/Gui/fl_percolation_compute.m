function [varargout]=fl_percolation_compute(varargin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[objTmp,percolation_fig] = gcbo;

if ((isempty(percolation_fig)) | (~strcmp(get(percolation_fig,'Tag'),'Fig_gui_fl_percolation')))
  percolation_fig = findobj ('Tag','Fig_gui_fl_percolation');
end;

ud = get(percolation_fig,'UserData');
returnString = '';

switch(varargin{1});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  INPUT SECTION  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'radiobutton_uniform'
	set(findobj(percolation_fig,'Tag','Radiobutton_uniform'),'Value',1) ;
	set(findobj(percolation_fig,'Tag','Radiobutton_fbm'),'Value',0) ;
	set(findobj(percolation_fig,'Tag','Radiobutton_userdefined'),'Value',0) ;
	
	
	set(findobj(percolation_fig,'Tag','StaticText_n_uniform'),'enable','on');
	set(findobj(percolation_fig,'Tag','EditText_n_uniform'),'enable','on');
	set(findobj(percolation_fig,'Tag','StaticText_n_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_n_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','StaticText_H_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_H_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_input'),'enable','off');
	set(findobj(percolation_fig,'Tag','Pushbutton_refreshInput'),'enable','off');

case 'radiobutton_fbm'
	set(findobj(percolation_fig,'Tag','Radiobutton_uniform'),'Value',0) ;
	set(findobj(percolation_fig,'Tag','Radiobutton_fbm'),'Value',1) ;
	set(findobj(percolation_fig,'Tag','Radiobutton_userdefined'),'Value',0) ;
	
	
	set(findobj(percolation_fig,'Tag','StaticText_n_uniform'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_n_uniform'),'enable','off');
	set(findobj(percolation_fig,'Tag','StaticText_n_fbm'),'enable','on');
	set(findobj(percolation_fig,'Tag','EditText_n_fbm'),'enable','on');
	set(findobj(percolation_fig,'Tag','StaticText_H_fbm'),'enable','on');
	set(findobj(percolation_fig,'Tag','EditText_H_fbm'),'enable','on');
	set(findobj(percolation_fig,'Tag','EditText_input'),'enable','off');
	set(findobj(percolation_fig,'Tag','Pushbutton_refreshInput'),'enable','off');


case 'radiobutton_userdefined' 
	set(findobj(percolation_fig,'Tag','Radiobutton_uniform'),'Value',0) ; 
	set(findobj(percolation_fig,'Tag','Radiobutton_fbm'),'Value',0) ; 
	set(findobj(percolation_fig,'Tag','Radiobutton_userdefined'),'Value',1) ;
	set(findobj(percolation_fig,'Tag','StaticText_n_uniform'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_n_uniform'),'enable','off');
	set(findobj(percolation_fig,'Tag','StaticText_n_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_n_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','StaticText_H_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_H_fbm'),'enable','off');
	set(findobj(percolation_fig,'Tag','EditText_input'),'enable','on');
	set(findobj(percolation_fig,'Tag','Pushbutton_refreshInput'),'enable','on');

case 'checkbox_progression'
	if get(gcbo,'Value')
		set(findobj(percolation_fig,'Tag','Checkbox_progression'),'String','Show progression (slower)')
	else
		set(findobj(percolation_fig,'Tag','Checkbox_progression'),'String','Don''t show (faster)')
		
	end
		




case 'launch'
    [SigIn_name error_in] = fl_get_input('matrix') ;
    eval(['global ' SigIn_name]) ;
    if error_in
      fl_warning('Input must be a matrix !') ;
      %fl_waitoff(current_cursor);
      return ;
    end
    SigIn = eval(SigIn_name) ;
    set(findobj(percolation_fig,'Tag','EditText_input'),'String',SigIn_name);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  General  SECTION   %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'edittext_n_uniform'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('Random media matrix size must be an integer !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = floor(max(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end
    
case 'edittext_n_fbm'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('fBm size must be an integer !');
         pause(.3);
         set(gcbo,'String','128');
    else 
    	n_value = floor(max(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end  

case 'edittext_H_fbm'
    h_value = str2num(get(gcbo,'String')) ;
    if isempty(h_value)
         fl_warning('fBm Holder exponent must be a real !');
         pause(.3);
         set(gcbo,'String','0.5');
    else 
    	h_value = max(0,h_value);
    	set(gcbo,'String',num2str(h_value)) ;
    end  


case 'edittext_max_iter'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('Number of iterations must be an integer !');
         pause(.3);
         set(gcbo,'String','1000');
    else 
    	n_value = floor(max(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%
  case 'compute_percolation'
    %%%%%%%%%%%%%%%%%%%%%%%%
    
	current_cursor=fl_waiton;
	fl_clearerror;
	  
	  	  
	  %%%%% Get Parameters %%%%% 
	  
	  
	pasdesignal = 0;  
	if get(findobj(percolation_fig,'Tag','Radiobutton_uniform'),'Value') 
	   	t=0;
	   	n = str2num(get(findobj(percolation_fig,'Tag','EditText_n_uniform'),'String'));
	   	H = 0;
	   	inputName = 'uniform';
	   	uniform = 0;
	end
	if get(findobj(percolation_fig,'Tag','Radiobutton_fbm'),'Value')
	   	t=1;
	   	n = str2num(get(findobj(percolation_fig,'Tag','EditText_n_fbm'),'String'));
	   	H = str2num(get(findobj(percolation_fig,'Tag','EditText_H_fbm'),'String'));
	   	inputName = 'fBm';
	   	fBm = 0;
	end
	if get(findobj(percolation_fig,'Tag','Radiobutton_userdefined'),'Value') 
	   	t=2;
	   	n=0;
	   	H = 0;
	   	inputName=get(findobj(percolation_fig,'Tag','EditText_input'),'String');
		if isempty(inputName)
	  		fl_warning('Input signal must be initiated: Refresh!');
	  		pasdesignal = 1;
	  	else
	  		eval(['global ' inputName]);
	  	end
	end  
	  
	  
	if ~pasdesignal
	  
	  m = str2num(get(findobj(percolation_fig,'Tag','EditText_max_iter'),'String'));
	  vis = get(findobj(percolation_fig,'Tag','Checkbox_progression'),'Value');
	  
	  
	  %%%%%% Disable close and compute %%%%%%%%
	  set(findobj(percolation_fig,'Tag','Pushbutton_wclose'),'enable','off');
	  set(findobj(percolation_fig,'Tag','Pushbutton_percolation_compute'),'enable','off');
	  
	  
	%%%%% Perform the computation %%%%%
	  
	OutputNameA=['RandMedia_' inputName];
	OutputNameB=['PercCluster_' inputName];
	OutputNameAB=['PercRand_' inputName];
	OutputNameBP=['PercBinary_' inputName];
	OutputNamePC=['PercDepth_' inputName];
	OutputNameLF=['PercLength_' inputName];

	[varnameA varnameB varnameAB varnameBP varnamePC varnameLF] = fl_find_mnames(varargin{2},OutputNameA,OutputNameB,OutputNameAB,OutputNameBP,OutputNamePC,OutputNameLF);
	eval(['global ' varnameA]);
	eval(['global ' varnameB]);
	eval(['global ' varnameAB]);
	eval(['global ' varnameBP]);	
	eval(['global ' varnamePC]);
	eval(['global ' varnameLF]);
		
	varargout{1} = [varnameA '  ' varnameB '  ' varnameAB '  ' varnameBP '  ' varnamePC ' ' varnameLF];

	if ~get(findobj(percolation_fig,'Tag','Radiobutton_userdefined'),'Value') 
		inputName = [ '''' inputName ''''];
	end
	
	eval(['[', varnameA, ' , ', varnameB, ' , ', varnameAB, ' , ', varnameBP, ' , ', varnamePC, ' , ', varnameLF, '] = fl_percolation(n,m,vis,t,H,', inputName, ');']);
	
	chaine=['[',varnameA, ',', varnameB, ',', varnameAB, ',', varnameBP, ',', varnamePC, ',', varnameLF, ']=fl_percolation(',num2str(n),',',num2str(m),',',num2str(vis),',',num2str(t),',',num2str(H),',',inputName,');'];
        fl_diary(chaine);
	
	
        fl_addlist(0,varnameA);
	fl_addlist(0,varnameB);
        fl_addlist(0,varnameAB);
	fl_addlist(0,varnameBP);
        fl_addlist(0,varnamePC);
	fl_addlist(0,varnameLF);
	
	end
	
	fl_waitoff(current_cursor);
	
	
	%%%%%% Enable close and compute %%%%%%%%
	  set(findobj(percolation_fig,'Tag','Pushbutton_wclose'),'enable','on');
	  set(findobj(percolation_fig,'Tag','Pushbutton_percolation_compute'),'enable','on');
	
    
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'help'
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
	helpwin fl_percolation


    %%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'close'
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    fl_clearerror;
    close (percolation_fig);
    
  
end %
