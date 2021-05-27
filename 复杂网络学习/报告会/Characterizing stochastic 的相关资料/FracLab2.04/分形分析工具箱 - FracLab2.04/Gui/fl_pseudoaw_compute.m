function [varargout]=fl_pseudoaw_compute(varargin)

% Callback functions for pseudo aw GUI

%Modification P. Legrand, January 2005.
  
Figpseudoaw = gcf;
if ((isempty(Figpseudoaw)) | (~strcmp(get(Figpseudoaw,'Tag'),'Fig_gui_fl_pseudoaw')))
  Figpseudoaw = findobj ('Tag','Fig_gui_fl_pseudoaw');
end

switch(varargin{1})

  case 'edit_aw_k'
        K = str2num(get(gcbo,'String')) ;
	if isempty(K)
	  K = 0 ;
	  set(gcbo,'String',num2str(K)) ;
	  obj = findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_k') ;
	  set(obj,'Value',2) ;
	elseif K == -1
	  obj = findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_k') ;
	  set(obj,'Value',1) ;
	elseif K == 0
	  obj = findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_k') ;
	  set(obj,'Value',2) ;
	elseif K == 0.5
	  obj = findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_k') ;
	  set(obj,'Value',3) ;
	elseif K == 2
	  obj = findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_k') ;
	  set(obj,'Value',4) ;	  
	else 
	  obj = findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_k') ;
	  set(obj,'Value',5) ;
	end
	
  case 'ppm_aw_k'
	value_k = get(gcbo,'Value') ;
	switch value_k
	  case 1,
	    obj = findobj(Figpseudoaw,'Tag','EditText_pseudoaw_k') ;
	    set(obj,'String','-1') ;
	  case 2,
	    obj = findobj(Figpseudoaw,'Tag','EditText_pseudoaw_k') ;
	    set(obj,'String','0') ;	    
	  case 3,
	    obj = findobj(Figpseudoaw,'Tag','EditText_pseudoaw_k') ;
	    set(obj,'String','0.5') ;
	  case 4,
	    obj = findobj(Figpseudoaw,'Tag','EditText_pseudoaw_k') ;
	    set(obj,'String','2') ;
	  case 5,
	    obj = findobj(Figpseudoaw,'Tag','EditText_pseudoaw_k') ;
	    set(obj,'String','') ;
	end
	    
  case 'aw_editf'
	value=str2num(get(gcbo,'String'));
	if(value<0.0)
	  N = get(Figpseudoaw,'UserData') ;
	  value=1.0/N;
	else
	  if(value>0.5)
	    value=0.5;
	  end 
	end
	set(gcbo,'String',value);

  case 'aw_ppm_fmin'
	N = get(Figpseudoaw,'UserData') ;
	logN=floor(log2(N))-4;
	if(logN<=1.0) logN=2; end
	value=get(gcbo,'Value');
	pow=2^(-1*(logN-value+1));
	set(findobj(Figpseudoaw,'Tag','EditText_pseudoaw_fmin'),'String',num2str(pow));

  case 'aw_ppm_fmax'
	value=get(gcbo,'Value');
	pow=2^(-1*value);
	set(findobj(Figpseudoaw,'Tag','EditText_pseudoaw_fmax'),'String',num2str(pow));

  case 'aw_edit_voices'
	value=str2num(get(gcbo,'String'));
	value=floor(value);
	if(value<=1.0) value=2.0; end
	set(gcbo,'String',value);

  case 'aw_ppm_voices'
	value=get(gcbo,'Value');
	set(findobj(Figpseudoaw,'Tag','EditText_pseudoaw_voices'),'String',num2str(2^value));

  case 'aw_edit_wsize'
	value=str2num(get(gcbo,'String'));
	value=floor(value);
	if(value<=1.0) value=2.0; end
	set(gcbo,'String',value);

  case 'aw_ppm_wtype'
	ppmh=findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_wtype');
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_wsize');
	if(get(ppmh,'Value')==1)
	  set(findobj(Figpseudoaw,'Tag','EditText_pseudoaw_wsize'),'Enable','off');
	else
	  set(findobj(Figpseudoaw,'Tag','EditText_pseudoaw_wsize'),'Enable','on');
	end
	
  case 'aw_edit_smooth'
        
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_wsize');
	wave = str2num(get(eth,'String')) ;
	if wave == 0
	    wvlt_width = 8 ;
	else
	    wvlt_width = 2*wave ;
	end
	smooth = str2num(get(gcbo,'String')) ;
	if smooth > wvlt_width
	  fl_warning('Maximum time smoothing reached!') ;
	end
	smooth = min(wvlt_width,smooth) ;
	set(gcbo,'String',num2str(smooth)) ;
	
	

  case 'aw_compute'
	  %%%%% Fisrt get the input %%%%%%
	 
	current_cursor=fl_waiton; 
	  
	fl_clearerror;
	
	SigIn_Name=get(findobj(Figpseudoaw,'Tag','EditText_sig_nname'),'String') ;
	
	eval(['global ' SigIn_Name]);
	  %%%%% Now get the wavelet type %%%%%
	ppmh=findobj(Figpseudoaw,'Tag','PopupMenu_pseudoaw_wtype');
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_wsize');
	switch(get(ppmh,'Value'))
	  case 1
	    wave=0;
	  case 2
	    wave=str2num(get(eth,'String'));
	  case 3
	    i = sqrt(-1) ;
	    wave=i*str2num(get(eth,'String'));
	end
	  %%%%% Get fmin and fmax %%%%%
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_fmin');
	fmin=str2num(get(eth,'String'));
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_fmax');
	fmax=str2num(get(eth,'String'));
	  %%%%% Get the number of voices %%%%%
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_voices');
	voices=str2num(get(eth,'String')) ;
	  %%%%% Get K %%%%%
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_k');
	K = str2num(get(eth,'String')) ;
	  %%%%% Get smooth  %%%%%
	eth=findobj(Figpseudoaw,'Tag','EditText_pseudoaw_smooth');  
	smooth = str2num(get(eth,'String')) ;  
	  %%%%% Get a name for the output var %%%%%
	prefix=['paw_' SigIn_Name];
	varname=fl_findname(prefix,varargin{2});
	varargout{1}=varname;
	eval(['global ' varname]);
	  %%%%% Perform the computation %%%%%
	  
	SigIn = eval(SigIn_Name) ;
	  [tfr,scale,f] = pseudoAW(SigIn,K,wave,smooth,fmin,fmax,voices) ;

	eval ([varname '= struct (''type'',''cwt'',''coeff'',tfr,''scale'',scale,''frequency'',f);']);
	 
    
    chaine=[varname,'=pseudoAW(',SigIn_Name,',',num2str(K),',',...
        num2str(wave),',',num2str(smooth),',',num2str(fmin),','...
        ,num2str(fmax),',',num2str(voices),') ;'];
    
        fl_diary(chaine);
    
    %%%%% Update the cwt list %%%%%
	fl_addlist(0,varname);
	
	fl_waitoff(current_cursor);
	

      case 'help'
	
	helpwin gui_fl_pseudoaw

end





