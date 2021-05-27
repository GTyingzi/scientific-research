function varargout=fl_estimGQV2DH_compute(varargin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù
[objTmp,estimGQV2DH_fig] = gcbo;

if ((isempty(estimGQV2DH_fig)) | (~strcmp(get(estimGQV2DH_fig,'Tag'),'Fig_gui_fl_estimGQV2DH')))
  estimGQV2DH_fig = findobj ('Tag','Fig_gui_fl_estimGQV2DH');
end;

ud = get(estimGQV2DH_fig,'UserData');
returnString = '';

switch(varargin{1});
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  INPUT SECTION  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'launch'
    [ImgIn_name error_in] = fl_get_input('matrix') ;
    eval(['global ' ImgIn_name]) ;
    if error_in
      fl_warning('Input must be a matrix !') ;
      return ;
    end
    ImgIn = eval(ImgIn_name) ;
    fl_callwindow('Fig_gui_fl_estimGQV2DH','gui_fl_estimGQV2DH') ;
    etm1estimGQV2D = findobj ('Tag','Fig_gui_fl_estimGQV2DH');
    set(findobj(etm1estimGQV2D,'Tag','EditText_input'),'String',ImgIn_name);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  General  SECTION   %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  case 'edit_k1'
    k_value = str2num(get(gcbo,'String')) ;
    if isempty(k_value)
         fl_warning('Initial sub-sampling must be an integer !');
         pause(.3);
         k1=1;
         set(gcbo,'String','1');
    else 
    	k_value = floor(max(1,k_value));
    	set(gcbo,'String',num2str(k_value)) ;
    	
    	EditHandle=findobj(estimGQV2DH_fig,'Tag','Radiobutton_regression');
	Reg = get(EditHandle,'Value') ;
    	EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_k2');
	k2 = str2num(get(EditHandle,'String'));
	if Reg == 0
		set(EditHandle,'String',num2str(k_value));
	else
		if (k_value>k2)
			fl_warning('Initial sub-sampling must be inferior to Final sub-sampling !');
         		pause(.3);
         		set(gcbo,'String',num2str(k2)) ;
		end
	end
    end

  case 'edit_k2'
    k_value = str2num(get(gcbo,'String')) ;
    if isempty(k_value)
         fl_warning('Final sub-sampling must be an integer !');
         pause(.3);
         k2=5;
         set(gcbo,'String','5');
    else 
    	k_value = floor(max(1,k_value));
    	set(gcbo,'String',num2str(k_value)) ;
    	EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_k1');
	k1 = str2num(get(EditHandle,'String'));
	if (k_value<k1)
		fl_warning('Final sub-sampling must be superior to Initial sub-sampling !');
         	pause(.3);
         	set(gcbo,'String',num2str(k1)) ;
	end
    end

   case 'edit_gamma'
    gamma_value = str2num(get(gcbo,'String')) ;
    if isempty(gamma_value)
         fl_warning('gamma must be a real !');
         pause(.3);
         set(gcbo,'String','0.8');
    else 
    	gamma_value = max(0,gamma_value);
    	set(gcbo,'String',num2str(gamma_value)) ;
    end
    
    
   case 'edit_delta'
    delta_value = str2num(get(gcbo,'String')) ;
    if isempty(delta_value)
         fl_warning('delta must be a real !');
         pause(.3);
         set(gcbo,'String','1');
    else 
    	delta_value = max(0,delta_value);
    	set(gcbo,'String',num2str(delta_value)) ;
    end  
  
    case 'radiobutton_regression'
	Reg = get(gcbo,'Value') ;
	if Reg == 1 
      		set(gcbo,'String','Regression') ;
      		set(findobj(estimGQV2DH_fig,'Tag','StaticText_k2'),'enable','on');
      		set(findobj(estimGQV2DH_fig,'Tag','EditText_k2'),'enable','on');
      		set(findobj(estimGQV2DH_fig,'Tag','EditText_k2'),'String',num2str(3)) ;
	elseif Reg == 0
      		set(gcbo,'String','No Regression') ;
      		set(findobj(estimGQV2DH_fig,'Tag','StaticText_k2'),'enable','off');
      		set(findobj(estimGQV2DH_fig,'Tag','EditText_k2'),'enable','off');
      		EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_k1');
	  	k1 = str2num(get(EditHandle,'String'));
      		set(findobj(estimGQV2DH_fig,'Tag','EditText_k2'),'String',k1) ;
	end 
  

    %%%%%%%%%%%%%%%%%%%%%%%%
  case 'compute'
    %%%%%%%%%%%%%%%%%%%%%%%%
    
	current_cursor=fl_waiton;
	fl_clearerror;
	
	%%%%% First get the input %%%%%%
	fl_clearerror;
	inputName=get(findobj(estimGQV2DH_fig,'Tag','EditText_input'),'String');
	if isempty(inputName)
	  fl_warning('Input image must be initiated: Refresh!');
	  fl_waitoff(current_cursor);
	else
	
	  eval(['global ' inputName]);
	  
	  %%%%%% Disable close and compute %%%%%%%%
	  set(findobj(estimGQV2DH_fig,'Tag','button_close'),'enable','off');
	  set(findobj(estimGQV2DH_fig,'Tag','button_compute'),'enable','off');
	  	  
	  %%%%% Get Parameters %%%%%  
	  EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_gamma');
	  gamma = str2num(get(EditHandle,'String'));
	  EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_delta');
 	  delta = str2num(get(EditHandle,'String'));
	  EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_k1');
	  k1 = str2num(get(EditHandle,'String'));
      	  EditHandle=findobj(estimGQV2DH_fig,'Tag','EditText_k2');
	  k2 = str2num(get(EditHandle,'String'));
	  
	%%%%% Perform the computation %%%%%
	  
	OutputNameH=['estim_H_' inputName];
	%OutputNameG=['estim_G_' inputName];
	%[varnameH varnameG] = fl_find_mnames(varargin{2},OutputNameH,OutputNameG);
	varnameH = fl_findname(OutputNameH, varargin{2});
	eval(['global ' varnameH]);
	%eval(['global ' varnameG]);
	%varargout{1} = [varnameH ' ' varnameG] ;
	varargout{1} = varnameH;
	
	%eval(['[', varnameH, ' , ', varnameG, '] =estimGQV2DH(', inputName, ',gamma,delta,k);']);
	eval([varnameH, ' =estimGQV2DH(', inputName, ',gamma,delta,k1,k2);']);
	
    chaine=[varnameH,'=estimGQV2DH(',inputName,',',num2str(gamma),',',...
        num2str(delta),',',num2str(k1),',',num2str(k2),');'];
    
        fl_diary(chaine);
    
    fl_addlist(0,varnameH);
	%fl_addlist(0,varnameG);
	
	end
	
	fl_waitoff(current_cursor);
	
	
	%%%%%% Enable close and compute %%%%%%%%
	  set(findobj(estimGQV2DH_fig,'Tag','button_close'),'enable','on');
	  set(findobj(estimGQV2DH_fig,'Tag','button_compute'),'enable','on');
	
    
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'help'
  
      helpwin estimGQV2DH
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'close'
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    fl_clearerror;
    close (estimGQV2DH_fig);
    
  
end %
