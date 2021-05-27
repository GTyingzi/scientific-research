function varargout=fl_dwt_compute(varargin)

% Callback functions for the FRACLAB Toolbox GUI DWT.

% Modification P. Legrand, January 2005.


Figdwt = gcf ;
if ((isempty(Figdwt)) | (~strcmp(get(Figdwt,'Tag'),'Fig_gui_fl_dwt')))
  Figdwt = findobj ('Tag','Fig_gui_fl_dwt');
end

switch(varargin{1})

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%  Discrete WT Window %%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'dwt_edit_octave'	
	value=str2num(get(gcbo,'String'));
	value=floor(value);
	if(value<1.0) value=1.0; end
	set(gcbo,'String',value);

  case 'dwt_ppm_octave'
	value=get(gcbo,'Value') ;
	set(findobj(Figdwt,'Tag','EditText_dwt_octave'),'String',num2str(value));
    
    
    
  
  case 'dwt_compute'
      
    modul=findobj(Figdwt,'Tag','checkbox_dwt_modulus');
    modul_value=get(modul,'Value');
	
	p=fl_waiton;
	fl_clearerror;
	SigIn_name = get(findobj(Figdwt,'Tag','EditText_sig_nname'),'String') ;
%	[input_sig flag_error]=fl_get_input('matrix');
%	if flag_error
%	  varargout{1}=input_sig;
%	  fl_warning('Input must be a matrix!');
%	  fl_waitoff(p);
%	  return;
%	end
	eval(['global ' SigIn_name]);
          %%%%% Get the octave %%%%
	edith=findobj(Figdwt,'Tag','EditText_dwt_octave');
	octave=str2num(get(edith,'String'));%+1;%%%%%Attention!!!!!!!!!
	  %%%%% Now get the wavelet type %%%%%
	ppmh=findobj(Figdwt,'Tag','PopupMenu_dwt_type');
	wt_order=get(ppmh,'Value');
	eval(['dim = min(min(size(' SigIn_name ')));']);
	  %%%%% Get a name for the output var %%%%%
	if (dim==1)
		prefix=['dwt_' SigIn_name];
        prefix1=['mwt_' SigIn_name];
	else
		prefix=['dwt2d_' SigIn_name];
        prefix1=['mwt2d_' SigIn_name];
	end;

	varname=fl_findname(prefix,varargin{2});
    varname1=fl_findname(prefix1,varargin{2});
	%varargout{1}=varname;
    %varargout{2}=varname1;
    
    if modul_value==1
    varargout{1}=[varname ' ' varname1];
    else
        varargout{1}=varname;
    end    
	%eval(['global ' varname ' ' varname1]);
    eval(['global ' varname]);
    if modul_value==1
      eval(['global ' varname1]);
    end;


	  %%%%% Perform the computation %%%%%
	if (wt_order<=10)
		f1=MakeQMF('daubechies',wt_order*2);
	else
	switch(wt_order)
		case 11
		f1=MakeQMF('coiflet',6);
		case 12
		f1=MakeQMF('coiflet',12);
		case 13
		f1=MakeQMF('coiflet',18);
		case 14
		f1=MakeQMF('coiflet',24);
	end;
	end;

	
	if (dim==1)		
		eval(['[wt wti wtl ff]= FWT(' SigIn_name ',octave,f1);']);
		eval([varname '= struct (''type'',''dwt'',''wt'',wt,''index'',wti,''length'',wtl,''size'',ff);']);
        
        chaine=['[',varname,'.wt,',varname,'.wti,',...
             varname,'.wtl,',varname,'.size]=FWT(',SigIn_name,...
             ',[',num2str(octave),'],[',num2str(f1),']);'];
         fl_diary(chaine);
        
        
        if modul_value==1
        eval([varname1 '= struct (''type'',''dwt'',''wt'',abs(wt),''index'',wti,''length'',wtl,''size'',ff);']);
        
        chaine=['[',varname1,'.wt,',varname1,'.wti,',...
             varname1,'.wtl,',varname1,'.size]=FWT(',SigIn_name,...
             ',[',num2str(octave),'],[',num2str(f1),']);',...
             varname1,'.wt=abs(',varname1,'.wt);'];
         fl_diary(chaine);
        end
        
        
         
        
	else
		eval(['[wt wti wtl ff]= FWT2D(' SigIn_name ',octave,f1);']);
		eval([varname '= struct (''type'',''dwt2d'',''wt'',wt,''index'',wti,''length'',wtl,''size'',ff);']);
        
        chaine=['[',varname,'.wt,',varname,'.wti,',...
             varname,'.wtl,',varname,'.size]=FWT2D(',SigIn_name,...
             ',[',num2str(octave),'],[',num2str(f1),']);'];
         fl_diary(chaine);
        
        if modul_value==1
        eval([varname1 '= struct (''type'',''dwt2d'',''wt'',abs(wt),''index'',wti,''length'',wtl,''size'',ff);']);
        
        chaine=['[',varname1,'.wt,',varname1,'.wti,',...
             varname1,'.wtl,',varname1,'.size]=FWT2D(',SigIn_name,...
             ',[',num2str(octave),'],[',num2str(f1),']);',...
             varname1,'.wt=abs(',varname1,'.wt);'];
         fl_diary(chaine);
        end
	end;
	
	  %%%%% Add to ouput list %%%%%
    
	fl_addlist(0,varname);
    if modul_value==1  
	fl_addlist(0,varname1);
    end
	fl_waitoff(p);
      
  case 'help'
	
        helpwin FWT
	
	
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function closewindow(tag)
figh=findobj(fig,'Tag',tag);
close(figh);



