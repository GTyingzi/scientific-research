function [dim]=fl_dimR_compute(command,context)
% Callback functions for the dimR GUI.

% Modification P. Legrand, January 2005.
varOutstring=[];

% [objTmp,fig] = gcbo;
dimR_fig = gcf;
if ((isempty(dimR_fig)) | (~strcmp(get(dimR_fig,'Tag'),'Fig_gui_fl_dimR')))
  dimR_fig = findobj ('Tag','Fig_gui_fl_dimR');
end

% dimR_fig

switch(command)


  case 'editNmin'
	value=str2num(get(gcbo,'String'));
	value=floor(value);
	fl_clearerror;
	input_sig=get(findobj(dimR_fig,'Tag','EditText_sig_nname'),'String');
	if isempty(input_sig)
	  fl_warning('Input signal must be initiated: Refresh!');
	else 
	  if(value<2)
	    value=2;
	  else
	    eval(['global ' input_sig]);
	    eval(['N = max(size(' input_sig '));']);
	    if(value>N/3)
	      value=floor(N/3);
	    end 
	  end
	  set(gcbo,'String',num2str(value));
	end
	
  case 'ppm_Nmin'
	index=get(gcbo,'Value');
	values=get(gcbo,'String');
	set(findobj(dimR_fig,'Tag','EditText_Nmin'),'String',values{index});
	  
  case 'editNmax'
	value=str2num(get(gcbo,'String'));
	value=floor(value);
	fl_clearerror;
	input_sig=get(findobj(dimR_fig,'Tag','EditText_sig_nname'),'String');
	if isempty(input_sig)
	  fl_warning('Input signal must be initiated: Refresh!');
	else 
	  eval(['global ' input_sig]);
	  eval(['N = max(size(' input_sig '));']);
	  valuemin=str2num(get(findobj(dimR_fig,'Tag','EditText_Nmin'),'String'));
	  if(value<valuemin)
	    value=valuemin;
	  else
	    if(value>2*N/3)
	      value=floor(2*N/3);
	    end 
	  end
	  set(gcbo,'String',num2str(value));
	end
      
  case 'ppm_Nmax'
	index=get(gcbo,'Value');
	values=get(gcbo,'String');
	set(findobj(dimR_fig,'Tag','EditText_Nmax'),'String',values{index});

  case 'edit_voices'
	value=str2num(get(gcbo,'String'));
	value=floor(value);
	if(value<2) value=2; end
	set(gcbo,'String',num2str(value));

  case 'edit_sigma'
	value=str2num(get(gcbo,'String'));
	if(value<0) value=0; end
	set(gcbo,'String',num2str(value));

  case 'ppm_voices'
	value=get(gcbo,'Value');
	set(findobj(dimR_fig,'Tag','EditText_voices'),'String',num2str(2^value));

  case 'rb_mirror'
	if(get(gco,'Value')==0)
	  set(gco,'String','No mirror');
	else
	  set(gco,'String','Mirror');
	end
	
   case 'refresh'
	fl_clearerror;
	[input_sig flag_error]=fl_get_input('matrix');
	if flag_error
	  fl_warning('Invalid: input signal must be a matrix !');
	else 
	  eval(['global ' input_sig]);
	  eval(['[n,p] = size(' input_sig ');']);
	  
	  %%%%%%%%%%%%%%% input frame %%%%%%%%%%%
	  set(findobj(dimR_fig,'Tag','EditText_size'), ... 
	      'String',[num2str(n),'x',num2str(p)]);
	  set(findobj(dimR_fig,'Tag','EditText_sig_nname'), ... 
	      'String',input_sig);
	  
	  %%%%%%%%%%%%%%% kernel frame %%%%%%%%%%%
	  set(findobj(dimR_fig,'Tag','PopupMenu_ktype'), ... 
	      'Value',1);
	  
	  %%%%%%%%%%%%%%% Nmin/Nmax & voice frame %%%%%%%
	  P=min(n,p);
	  N=max(n,p);
	  if P>1
	    N=P;
	  end
	  
	  ppmh1=findobj(dimR_fig,'Tag','PopupMenu_Nmin');
	  ppmh2=findobj(dimR_fig,'Tag','PopupMenu_Nmax');
	  kmin=floor(linspace(5,max(N/3,10),5));
	  kmax=floor(linspace(max(N/3,10),max(2*N/3,max(N/3,10)+5),5));
	  for i=1:5,
	    varcell1{i}=num2str(kmin(i));
	  end
	  for i=1:5
	    varcell2{i}=num2str(kmax(i));
	  end
	  if P>1
	    set(findobj(dimR_fig,'Tag','EditText_voices'),'String',num2str(16));
	    set(findobj(dimR_fig,'Tag','PopupMenu_voices'),'Value',4);
	    initmax=1;
	    initmin=1;
	  else
	    set(findobj(dimR_fig,'Tag','EditText_voices'),'String',num2str(64));
	    set(findobj(dimR_fig,'Tag','PopupMenu_voices'),'Value',6);
	    initmax=3;
	    initmin=1;
	  end
	  set(ppmh1,'String',varcell1);
	  set(ppmh1,'Value',initmin);
	  set(ppmh2,'String',varcell2);
	  set([ppmh2],'Value',initmax);
	  set(findobj(dimR_fig,'Tag','EditText_Nmin'),'String',varcell1{initmin});
	  set(findobj(dimR_fig,'Tag','EditText_Nmax'),'String',varcell2{initmax});
	  
	  %%%%%%%%%%%%% Noise frame %%%%%%%%%%%%%%%%
	  set(findobj(dimR_fig,'Tag','EditText_sigma'),'String','0');
	  
	  %%%%%%%%%%%%%%% regression frame %%%%%%%%%%%
	  set(findobj(dimR_fig,'Tag','PopupMenu_regtype'), ... 
	      'Value',1);
	  
	  %%%%%%%%%%%%% radiobuttons %%%%%%%%%%%%%%%
	  set(findobj(dimR_fig,'Tag','Radiobutton_reg'),'String','Specify');
	  set(findobj(dimR_fig,'Tag','Radiobutton_reg'),'Value',1);
	  set(findobj(dimR_fig,'Tag','Radiobutton_graphs'),'String','No regularized graphs');
	  set(findobj(dimR_fig,'Tag','Radiobutton_graphs'),'Value',0);
	  set(findobj(dimR_fig,'Tag','Radiobutton_save'),'enable','off');
	  set(findobj(dimR_fig,'Tag','Radiobutton_save'),'String','Forget regularized graphs');
	  set(findobj(dimR_fig,'Tag','Radiobutton_save'),'Value',0);
	  
	end
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute dimR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'compute_dimR'

	current_cursor=fl_waiton;
	
	%%%%% First get the input %%%%%%
	fl_clearerror;
	input_sig=get(findobj(dimR_fig,'Tag','EditText_sig_nname'),'String');
	if isempty(input_sig)
	  fl_warning('Input signal must be initiated: Refresh!');
	  fl_waitoff(current_cursor);
	else
	  eval(['global ' input_sig]);
	  
	  %%%%%% Disable close and compute %%%%%%%%
	  set(findobj(dimR_fig,'Tag','Pushbutton_wclose'),'enable','off');
	  set(findobj(dimR_fig,'Tag','Pushbutton_dimR_compute'),'enable','off');
	  
	  %%%%% Now get the wavelet type %%%%%
	  ppmh=findobj(dimR_fig,'Tag','PopupMenu_ktype');
	  switch(get(ppmh,'Value'))
	    case 1
	      kernel='gauss';
	    case 2
	      kernel='rect';
	    case 3
	      kernel='band';
	  end
	  
	  %%%%% Get Nmin and Nmax %%%%%
	  eth=findobj(dimR_fig,'Tag','EditText_Nmin');
	  Nmin=str2num(get(eth,'String'));
	  eth=findobj(dimR_fig,'Tag','EditText_Nmax');
	  Nmax=str2num(get(eth,'String'));
	  
	  %%%%% Get the number of voices %%%%%
	  eth=findobj(dimR_fig,'Tag','EditText_voices');
	  voices=str2num(get(eth,'String'));
	  
	  %%%%% Get sigma %%%%%
	  eth=findobj(dimR_fig,'Tag','EditText_sigma');
	  sigma=str2num(get(eth,'String'));
	  
	  %%%%% See or don't see graphs %%%%%
	  graphs=get(findobj(dimR_fig,'Tag','Radiobutton_graphs'),'Value');
	  %(graph==0):no graph
	  
	  %%%%% Specify or don't specify regression %%%%%
	  reg=get(findobj(dimR_fig,'Tag','Radiobutton_reg'),'Value');
	  
	  %%%%% Where to display the result %%%%%
	  obj=findobj(dimR_fig,'Tag','EditText_dimR') ;
	  
	  %%%%% regression argument %%%%%
	  RegType=get(findobj(dimR_fig,'Tag','PopupMenu_regtype'),'Value');
	  RegParam = fl_getregparam(RegType,voices);
	  
	  
	  %%%%% Perform the computation %%%%%
	  
	  eval(['[dim, handlefig,a,L,Kreg,R,regX]=regdim(', input_sig,...
          ',sigma,voices,Nmin,Nmax,kernel,reg,graphs,RegParam{:});']);
	  
      chaine=['dim=regdim(',input_sig,',',num2str(sigma),',',num2str(voices)...
          ',',num2str(Nmin),',',num2str(Nmax),',''',num2str(kernel),...
          ''',',num2str(reg),',',num2str(graphs),',''',num2str(RegParam{:}),''');'];
      fl_diary(chaine)
      
	  %%%%% store the figure handles %%%%%
	  %global handlefig_dimR
	  %handlefig_dimR=[handlefig_dimR,handlefig];
	  
	  
	  %%%%% Display the result %%%%%%%%%
	  set(obj,'String',num2str(dim)) ;
	  if reg
          	h=guidata(handlefig);
          	h.HandleOut=obj;
          	guidata(handlefig,h);
          end
	  
	  
	  %%%%% Save or don't save the regularized graphs %%%%%%%%%
	  if get(findobj(dimR_fig,'Tag','Radiobutton_graphs'),'Value')
	    if get(findobj(dimR_fig,'Tag','Radiobutton_save'),'Value')
	      if iscell(regX)
		for i=1:length(regX)
		  varname=fl_findname([input_sig,num2str(i),'reg'],context);
		  eval(['global ' varname ';']);
		  eval([varname,'=regX{i};']);
		  fl_addlist(0,varname);
		end
	      else
		varname=fl_findname([input_sig,'reg'],context);
		eval(['global ' varname ';']);
		eval([varname,'=regX;']);
		fl_addlist(0,varname);
	      end
	    end
	  end
	  
	  
	  fl_waitoff(current_cursor);
	  %%%%%% Enable close and compute %%%%%%%%
	  set(findobj(dimR_fig,'Tag','Pushbutton_wclose'),'enable','on');
	  set(findobj(dimR_fig,'Tag','Pushbutton_dimR_compute'),'enable','on');
	  
	end
   
%%%%%%%%% LOCAL SCALING PARAMETERS %%%%%%%%%%%%

  case 'radiobutton_reg'
	Reg = get(gcbo,'Value') ;
	if Reg == 1 
	  set(gcbo,'String','Specify') ;
	elseif Reg == 0
	  set(gcbo,'String','Automatic') ;
	end
	
  case 'radiobutton_see'
	Reg = get(gcbo,'Value') ;
	if Reg == 1 
	  set(gcbo,'String','Regularized graphs') ;
	  set(findobj(dimR_fig,'Tag','Radiobutton_save'),'enable','on');
	elseif Reg == 0
	  set(gcbo,'String','No regularized graphs') ;
	  set(findobj(dimR_fig,'Tag','Radiobutton_save'),'enable','off');
	end
	
  case 'close'
	%global handlefig_dimR
        %for i=1:length(handlefig_dimR)
	  %%%%%%check for non already closed handle%%%
	  %if ishandle(handlefig_dimR(i))
	   % close(handlefig_dimR(i));
	  %end
	%end
	%clear handlefig_dimR
	close(gcf);
	
  case 'help'
        helpwin gui_fl_dimR_help

  case 'radiobutton_save'
	Reg = get(gcbo,'Value') ;
	if Reg == 0 
	  set(gcbo,'String','Forget regularized graphs') ;
	elseif Reg == 1
	  set(gcbo,'String','Save regularized graphs') ;
	end 
        
end













