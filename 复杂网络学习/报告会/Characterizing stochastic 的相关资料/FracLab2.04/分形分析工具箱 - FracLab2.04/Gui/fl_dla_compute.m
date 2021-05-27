function [varargout]=fl_dla_compute(varargin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[objTmp,dla_fig] = gcbo;

if ((isempty(dla_fig)) | (~strcmp(get(dla_fig,'Tag'),'Fig_gui_fl_dla')))
  dla_fig = findobj ('Tag','Fig_gui_fl_dla');
end;

ud = get(dla_fig,'UserData');
returnString = '';

switch(varargin{1});
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  General  SECTION   %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'ppm_predefinedvalues'
	index_predefinedvalue = get(gcbo,'Value');
	switch (index_predefinedvalue)
	case 1
	  set(findobj(dla_fig,'Tag','EditText_size'),'String',32);
	  set(findobj(dla_fig,'Tag','EditText_nb_particles'),'String',250);
	  set(findobj(dla_fig,'Tag','EditText_nb_iter'),'String',200);
	  set(findobj(dla_fig,'Tag','EditText_rad_launching'),'String',1);
	  set(findobj(dla_fig,'Tag','EditText_rad_killing'),'String',5);
	  set(findobj(dla_fig,'Tag','popupmenu_progression'),'Value',2);
	case 2
	  set(findobj(dla_fig,'Tag','EditText_size'),'String',128);
	  set(findobj(dla_fig,'Tag','EditText_nb_particles'),'String',2500);
	  set(findobj(dla_fig,'Tag','EditText_nb_iter'),'String',2000);
	  set(findobj(dla_fig,'Tag','EditText_rad_launching'),'String',1);
	  set(findobj(dla_fig,'Tag','EditText_rad_killing'),'String',20);
	  set(findobj(dla_fig,'Tag','popupmenu_progression'),'Value',1);
	case 3
	  set(findobj(dla_fig,'Tag','EditText_size'),'String',256);
	  set(findobj(dla_fig,'Tag','EditText_nb_particles'),'String',10000);
	  set(findobj(dla_fig,'Tag','EditText_nb_iter'),'String',2000);
	  set(findobj(dla_fig,'Tag','EditText_rad_launching'),'String',1);
	  set(findobj(dla_fig,'Tag','EditText_rad_killing'),'String',20);
	  set(findobj(dla_fig,'Tag','popupmenu_progression'),'Value',1);
	case 4
	  set(findobj(dla_fig,'Tag','EditText_size'),'String',512);
	  set(findobj(dla_fig,'Tag','EditText_nb_particles'),'String',30000);
	  set(findobj(dla_fig,'Tag','EditText_nb_iter'),'String',10000);
	  set(findobj(dla_fig,'Tag','EditText_rad_launching'),'String',1);
	  set(findobj(dla_fig,'Tag','EditText_rad_killing'),'String',20);
	  set(findobj(dla_fig,'Tag','popupmenu_progression'),'Value',3);
	case 5
	  set(findobj(dla_fig,'Tag','EditText_size'),'String',1024);
	  set(findobj(dla_fig,'Tag','EditText_nb_particles'),'String',100000);
	  set(findobj(dla_fig,'Tag','EditText_nb_iter'),'String',20000);
	  set(findobj(dla_fig,'Tag','EditText_rad_launching'),'String',1);
	  set(findobj(dla_fig,'Tag','EditText_rad_killing'),'String',20);
	  set(findobj(dla_fig,'Tag','popupmenu_progression'),'Value',3);
	end


case 'edittext_size'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('The size of the simulation must be an integer !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = floor(max(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end

case 'edittext_sp'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('The sticking probability must be a real !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = max(0,min(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end

    
case 'edittext_nb_particles'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('The number of the particles must be an integer !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = floor(max(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end    
    
case 'edittext_nb_iter'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('The number of the iterations must be an integer !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = floor(max(1,n_value));
    	set(gcbo,'String',num2str(n_value)) ;
    end        
    

case 'edittext_rad_launching'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('The rad of launching must be a real !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = max(0,n_value);
    	set(gcbo,'String',num2str(n_value)) ;
    end   
    
case 'edittext_rad_killing'
    n_value = str2num(get(gcbo,'String')) ;
    if isempty(n_value)
         fl_warning('The rad of killing must be a real !');
         pause(.3);
         set(gcbo,'String','100');
    else 
    	n_value = max(0,n_value);
    	set(gcbo,'String',num2str(n_value)) ;
    end   



    
    
    %%%%%%%%%%%%%%%%%%%%%%%%
  case 'compute_dla'
    %%%%%%%%%%%%%%%%%%%%%%%%
    
	current_cursor=fl_waiton;
	fl_clearerror;
	  
	  	  
	  %%%%% Get Parameters %%%%% 
	  T = str2num(get(findobj(dla_fig,'Tag','EditText_size'),'String'));
	  drl = str2num(get(findobj(dla_fig,'Tag','EditText_rad_launching'),'String'));
	  dra = str2num(get(findobj(dla_fig,'Tag','EditText_rad_killing'),'String'));
	  ndepmax = str2num(get(findobj(dla_fig,'Tag','EditText_nb_iter'),'String'));
	  npart = str2num(get(findobj(dla_fig,'Tag','EditText_nb_particles'),'String'));
	  sp = str2num(get(findobj(dla_fig,'Tag','EditText_sp'),'String'));
	  vis_temp = get(findobj(dla_fig,'Tag','popupmenu_progression'),'Value');
	  if vis_temp == 3
	  	vis = 0;
	  else
	  	vis = vis_temp;
	  end
	  
	  %%%%%% Disable close and compute %%%%%%%%
	  set(findobj(dla_fig,'Tag','Pushbutton_wclose'),'enable','off');
	  set(findobj(dla_fig,'Tag','Pushbutton_dla_compute'),'enable','off');
	  
	  
	%%%%% Perform the computation %%%%%
	  
	OutputNameA=['A'];
	OutputNamePN=['pn'];
	OutputNameCR=['cr'];
	
	[varnameA varnamePN varnameCR ] = fl_find_mnames(varargin{2},OutputNameA,OutputNamePN,OutputNameCR);
	
	eval(['global ' varnameA]);
	eval(['global ' varnamePN]);
	eval(['global ' varnameCR]);

		
	varargout{1} = [varnameA '  ' varnamePN '  ' varnameCR];

	eval(['[', varnameA, ' , ', varnamePN, ' , ', varnameCR, '] = dla(T,drl,dra,ndepmax,npart,sp,vis);']);

        chaine=['[',varnameA, ',', varnamePN, ',', varnameCR,']=dla(',num2str(T),',',num2str(drl),',',num2str(dra),',',num2str(ndepmax),',',num2str(npart),',',num2str(sp),',',num2str(vis),');'];
    
        fl_diary(chaine);
	
        fl_addlist(0,varnameA);
	fl_addlist(0,varnamePN);
        fl_addlist(0,varnameCR);
        

    
        fl_waitoff(current_cursor);
	
	
	%%%%%% Enable close and compute %%%%%%%%
	  set(findobj(dla_fig,'Tag','Pushbutton_wclose'),'enable','on');
	  set(findobj(dla_fig,'Tag','Pushbutton_dla_compute'),'enable','on');
	
   
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'help'
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
	helpwin dla


    %%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'close'
    %%%%%%%%%%%%%%%%%%%%%%%%%%

    fl_clearerror;
    close (dla_fig);
    
  
end %
