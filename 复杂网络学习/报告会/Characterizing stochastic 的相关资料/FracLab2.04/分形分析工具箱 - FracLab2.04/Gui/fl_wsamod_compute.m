function varargout=fl_wsamod_compute(varargin)
% Callback functions for the GIFS GUI.
% remplaces par isempty(r).
% Last version Pierrick Legrand 7/12/2001


switch(varargin{1})
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%  Main GIFS Window %%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  case 'launch'
    [SigIn_name error_in] = fl_get_input('vector') ;
    eval(['global ' SigIn_name]) ;
    if error_in
      fl_warning('Input must be a vector !') ;
      %fl_waitoff(current_cursor);
      return ;
    end
    SigIn = eval(SigIn_name) ;
    
    
    %%%%
    N = length(SigIn) ;
  if log2(N)~=floor(log2(N))
	  varargout{1}=SigIn_name;
	  fl_warning('Input vector length must be a power of 2 !');
	  %fl_waitoff(current_cursor);
	  return
  end
  fl_callwindow('Fig_gui_fl_wsamod','gui_fl_wsamod') ;
    Figwsamod = findobj ('Tag','Fig_gui_fl_wsamod');
  set(findobj(Figwsamod,'Tag','EditText_sig_nname'),'String',SigIn_name);
    
    
    %%%%
    input_sig=get(findobj(Figwsamod,'Tag','EditText_sig_nname'),'String');
    eval(['N=length(' input_sig ');']);
    logs =min(5,floor(log(N)/log(2))-1);
    max_iter=floor(log(N)/log(2))-1;
    set(findobj(Figwsamod,'Tag','EditText_wsamod_iter'),'String',logs);
    set(findobj(Figwsamod,'Tag','EditText_wsamod_iter'),'UserData',logs);
    set(findobj(Figwsamod,'Tag','Fig_gui_fl_wsamod'),'UserData',max_iter);
    %%%%

    
  case 'wsamod_ppm_wav'
    string = get(gcbo,'String') ;
    val_wav = get(gcbo,'Value');
    r=string{val_wav} ;
    var=cell(1);
    if(isempty(r))
      sth=findobj('Tag','StaticText_wsamod_output');
      set(sth,'String','Error');
    end
    i=1 ;
    while(~isempty(r))
      [var{i},r]=strtok(r) ;
      i=i+1;
    end
    i=i-1;
    if((i>2) | (i==0))
      fl_warning('The wavelet wss not catched!');
      return;
    end	
    
    val1 = var{1};
    if(i==2)
      val2 = str2num(var{2});
    end
    
 case 'wsamod_edittext_iter'
    fl_clearerror;
    string = get(findobj('Tag','EditText_wsamod_iter'),'String') ;
    val_iter = floor(str2num(string));
    default_iter=get(findobj(gcf,'Tag','EditText_wsamod_iter'),'UserData');
    max_iter=get(findobj(gcf,'Tag','Fig_gui_fl_wsamod'),'UserData');
    if isempty(val_iter) 
       fl_warning('Analysis depth must be integer !');pause(.3);
       set(findobj(gcf,'Tag','EditText_wsamod_iter'),'String',default_iter);
       else 
         if val_iter>max_iter
            fl_warning('Analysis depth too large !');pause(.3);
            %max_iter=get(findobj(gcf,'Tag','Fig_gui_fl_wsamod'),'UserData');
            set(findobj(gcf,'Tag','EditText_wsamod_iter'),'String',max_iter);
         end;
         if (floor(str2num(string))~=(str2num(string)))
            fl_warning('Analysis depth must be integer !');pause(1);
            set(findobj(gcf,'Tag','EditText_wsamod_iter'),'String',val_iter);
         end;
         if val_iter<3
            fl_warning('Analysis depth too small !');pause(.3);
            default_iter=get(findobj(gcf,'Tag','EditText_wsamod_iter'),'UserData');
            set(findobj(gcf,'Tag','EditText_wsamod_iter'),'String','3');
         end;
    end;       
    %%%%%%%
           
    
 case 'wsamod_edittext_err'
    fl_clearerror
    string = get(gcbo,'String') ;
    val_err = str2num(string) ;
    if isempty(val_err) 
       fl_warning('Threshold must be real !');pause(.3);
       set(findobj(gcf,'Tag','EditText_wsamod_err'),'String','10');
       val_err=10;
    end;
    if (val_err<=0) 
       fl_warning('Threshold must be positive !');pause(.3);
       set(findobj(gcf,'Tag','EditText_wsamod_err'),'String','10');
       val_err=10;
    end;
      
 case 'wsamod_edittext_cmin'
    fl_clearerror;
    string = get(gcbo,'String') ;
    val_cmin = str2num(string) ;
    if isempty(val_cmin)
       fl_warning('cmin must be real !');pause(.3);
       set(findobj(gcf,'Tag','EditText_wsamod_cmin'),'String','0.1');
       val_cmin=0.1;
    end;   
    if val_cmin < 0 
       fl_warning('cmin must be a real number between 0 and 1 !');pause(.3);
       val_cmin = 0;
       set(gcbo,'String',num2str(val_cmin));
    end;
    if val_cmin > 1
       fl_warning('cmin must be a real number between 0 and 1 !');pause(.3);
       val_cmin = 1;
       set(gcbo,'String',num2str(val_cmin));
    end;
    val_cmax=str2num(get(findobj('Tag','EditText_wsamod_cmax'),'String'));
    if val_cmax <= val_cmin 
      fl_warning('cmin must be < cmax !');pause(.3); 
      val_cmin = val_cmax-0.01;
      set(gcbo,'String',num2str(val_cmin));
    end
    set(findobj('Tag', 'Slider_wsamod_cmin'),'Value',val_cmin);
    
 case 'wsamod_slider_cmin'
    fl_clearerror;
    val = get(gcbo,'Value');
    valmax=str2num(get(findobj('Tag','EditText_wsamod_cmax'),'String'));
    if valmax<=val
       fl_warning('cmin must be < cmax !');pause(.3);
       val=valmax-0.01;
       set(gcbo,'Value',val);
    end;        
    set(findobj('Tag','EditText_wsamod_cmin'), 'String', num2str(val,4));
    
  case 'wsamod_edittext_cmax'
    fl_clearerror; 
    string = get(gcbo,'String') ;
    val_cmax = str2num(string) ;
    if isempty(val_cmax)
       fl_warning('cmax must be real !');pause(.3);
       set(findobj(gcf,'Tag','EditText_wsamod_cmax'),'String','1');
       val_cmax=1;
    end;
    if val_cmax > 4 
       fl_warning('cmax must be a real number between 0 and 4 !');pause(.3);
       val_cmax = 4;
       set(gcbo,'String',num2str(val_cmax));
    end;
    if val_cmax < 0 
       fl_warning('cmax must be a real number between 0 and 4 !');pause(.3);
       val_cmax = 0;
       set(gcbo,'String',num2str(val_cmax));
    end
    val_cmin=str2num(get(findobj('Tag','EditText_wsamod_cmin'),'String'));
    if val_cmax <= val_cmin 
       fl_warning('cmax must be > cmin !');pause(.3);
       val_cmax = val_cmin+0.01;
       set(gcbo,'String',num2str(val_cmax));
    end
    set(findobj('Tag', 'Slider_wsamod_cmax'),'Value',val_cmax);
  
  case 'wsamod_slider_cmax'
     fl_clearerror;
     val = get(gcbo,'Value');
     valmin=str2num(get(findobj('Tag','EditText_wsamod_cmin'),'String'));
     if valmin>=val
        fl_warning('cmax must be > cmin !');pause(.3);
        val=valmin+0.01;
        set(gcbo,'Value',val);
     end;
     set(findobj('Tag','EditText_wsamod_cmax'), 'String', num2str(val,4));
    
  case 'wsamod_compute'
    
    %fl_clearerror;  %%% Clear the error Zone ! %%%%	
    
    %% permet d'afficher la montre et de se souvenir
    %% de la tete du pointeur souris actuel
    mon_pointeur_courant = fl_waiton;

    %%%%% First get the input %%%%%%
    fl_clearerror;
    Figwsamod = findobj ('Tag','Fig_gui_fl_wsamod');

    input_sig=get(findobj(Figwsamod,'Tag','EditText_sig_nname'),'String');
    if isempty(input_sig)
      fl_warning('Input signal must be initiated: Refresh!');
      fl_waitoff( mon_pointeur_courant);
    else
      eval(['global ' input_sig]);
    end;

    %%%% Get the analyzing wavelet %%%%
    
    edit_wav_h = findobj('Tag','PopupMenu_wsamod_wav');
    string = get(edit_wav_h,'String');
    val_wav = get(edit_wav_h,'Value');
    r=string{val_wav} ;
    var=cell(1);
    i=1;
    while(~isempty(r))
      [var{i},r]=strtok(r) ;
      i=i+1;
    end
    i=i-1;
    if((i>2) | (i==0))
      fl_waitoff(mon_pointeur_courant);
      fl_warning('The wavelet is not catched!');
      return;
    end
    val_name = var{1};
    if(strcmp(val_name,'Haar'))
      filter = 'daubechies' ;
      param = 2 ;
    else
      filter = var{1};
      param = str2num(var{2});
    end
    
    %%%% Get the number of iteration %%%
    
    edit_iter_h = findobj('Tag','EditText_wsamod_iter');
    nb_iter = floor(str2num(get(edit_iter_h,'String'))) ;
    eval(['N=length(' input_sig ');']);
    logsig = floor(log(N)/log(2));
    max_iter = logsig - 1 ;
    if(nb_iter > max_iter)
      fl_waitoff(mon_pointeur_courant);
      fl_warning('The maximal analysis depth is violated!');
      %%%%%%
      nb_iter =max_iter;
      set(findobj(Figwsamod,'Tag','EditText_wsamod_iter'),'String',nb_iter);
      %%%%%
      %return;
    end
    if(nb_iter < 3)
      fl_waitoff(mon_pointeur_courant);
      fl_warning('The analysis depth must be > 2!');	
      return;
    end
    
    %%%% Get the L2 error %%%
    
    edit_err_h = findobj('Tag','EditText_wsamod_err');
    epsilon = str2num(get(edit_err_h,'String')) ;
    
    %%%% Get the C_min %%%
    
    edit_cmin_h = findobj('Tag','EditText_wsamod_cmin');
    cmin = str2num(get(edit_cmin_h,'String')) ;
    
    %%%% Get the C_max %%%
    
    edit_cmax_h = findobj('Tag','EditText_wsamod_cmax');
    cmax = str2num(get(edit_cmax_h,'String')) ;
    if(cmin >= cmax)
      fl_warning('The cmin  must be smaller than cmax!');	
      return;
    end
    
    %%%%% Get a name for the output structure  %%%%%
    
    [varname1 varname2 varname3] = fl_find_mnames(varargin{2},'wsamod_','wsamod_synt','wsamod_newci_');
    eval(['global ' varname1]);
    eval(['global ' varname2]);
    eval(['global ' varname3]);
    
    %%%%%% Test the size of inpiut_sig %%%%
    sizesig = 2^logsig;
    t=(1:sizesig);
    if(N > (sizesig + sizesig/2))
      t=(1:2*sizesig);
      %		fl_message('zeros have been added to the end of the signal!');
    elseif(N > sizesig)
      %                fl_message('only the first 2^n samples have been processed!');
    end
    
    %%%%% Perform the computation %%%%
    eval(['[sigsynt newci marks lambda count] = wsamod(' input_sig ',epsilon,nb_iter,filter,param,cmin,cmax);']);
    
    eval ([varname1 '= struct (''type'',''graph'',''data1'',t,''data2'',sigsynt,''title'',[''Approximating WSA signal''],''xlabel'',''x'',''ylabel'',''y'');']);
    
    %%%%% Get a name for the second output %%%%%
    eval ([varname2 '=sigsynt;']) ;
    fl_addlist(0,varname2);
    
    %%%%% Get a name for the third output %%%%%
    eval ([varname3 '=newci;']) ;
    warning off;
    varargout{1} = [[varname1],' ',[varname2],' ',[varname3]] ;
    fl_addlist(0,varname3);
    fl_addlist(0,varname1);
    
    %%%%% Give the output %%%%
    edit_output_h = findobj('Tag','StaticText_wsamod_output');
    count = (count*100)/100;
    set(edit_output_h,'String',num2str(count));
    
    %% retablit l'ancien pointeur	 
    fl_waitoff(mon_pointeur_courant);	
    
  case 'close'
    fl_clearerror;
    figh = findobj('Tag','graph_segment') ;
    close(figh)
    close(gcf)
    
end


