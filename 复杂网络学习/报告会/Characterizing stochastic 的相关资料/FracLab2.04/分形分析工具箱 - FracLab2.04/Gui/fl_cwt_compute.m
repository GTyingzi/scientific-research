function [varargout]=fl_cwt_compute(varargin)

Figcwt = gcf;
if ((isempty(Figcwt)) | (~strcmp(get(Figcwt,'Tag'),'Fig_gui_fl_cwt')))
  Figcwt = findobj ('Tag','Fig_gui_fl_cwt');
end

switch(varargin{1})
  
  case 'cwt_editf'
    value=str2num(get(gcbo,'String'));
    if(value<0.0)
      N=get(gcf,'UserData');
      value=1.0/N;
    else
      if(value>0.5)
	value=0.5;
      end 
    end
    set(gcbo,'String',value);
    
  case 'cwt_ppm_fmin'
    N=get(gcf,'UserData');
    logN=floor(log2(N))-4;
    if(logN<=1.0) logN=2; end
    value=get(gcbo,'Value');
    pow=2^(-1*(logN-value+1));
    obj = findobj(Figcwt,'Tag','EditText_cwt_fmin') ;
    set(obj,'String',num2str(pow));
    
  case 'cwt_ppm_fmax'
    value=get(gcbo,'Value');
    pow=2^(-1*value);
    obj = findobj(Figcwt,'Tag','EditText_cwt_fmax') ;
    set(obj,'String',num2str(pow));
    
  case 'cwt_edit_voices'
    value=str2num(get(gcbo,'String'));
    value=floor(value);
    if(value<=1.0) value=2.0; end
    set(gcbo,'String',value);
    
  case 'cwt_ppm_voices'
    value=get(gcbo,'Value');
    obj = findobj(Figcwt,'Tag','EditText_cwt_voices') ;
    set(obj,'String',num2str(2^value));
    
  case 'cwt_edit_wsize'
    value=str2num(get(gcbo,'String'));
    value=floor(value);
    if(value<=1.0) value=2.0; end
    set(gcbo,'String',value);
    
  case 'cwt_ppm_wtype'
    ppmh=findobj(Figcwt,'Tag','PopupMenu_cwt_wtype');
    eth=findobj(Figcwt,'Tag','EditText_cwt_wsize');
    if(get(ppmh,'Value')==1)
      obj = findobj(Figcwt,'Tag','EditText_cwt_wsize') ;
      set(obj,'Enable','off');
    else
      obj = findobj(Figcwt,'Tag','EditText_cwt_wsize') ;
      set(obj,'Enable','on');
    end
    
  case 'cwt_rb_l1l2'
    if(get(gco,'Value')==0)
      set(gco,'String','L2 normalization');
      obj = findobj(Figcwt,'Tag','Radiobutton_cwt_mirror') ;
      set(obj,'Enable','on');
      obj=findobj(Figcwt,'Tag','PopupMenu_cwt_wtype');
      string=get(obj,'String');
      set(obj,'string',{string{1};'Morlet (real)';string{2}});
    else
      set(gco,'String','L1 normalization');
      obj=findobj(Figcwt,'Tag','Radiobutton_cwt_mirror');
      set(obj,'Value',1);
      set(obj,'String','Mirror');	  
      set(obj,'Enable','off');
      obj=findobj(Figcwt,'Tag','EditText_cwt_wsize');
      set(obj,'Enable','off');
      obj=findobj(Figcwt,'Tag','PopupMenu_cwt_wtype');
      set(obj,'Value',1);
      string=get(obj,'String');
      set(obj,'string',{string{1};string{3}});
    end
    
  case 'cwt_rb_mirror'
    if(get(gco,'Value')==0)
      set(gco,'String','No mirror');
    else
      set(gco,'String','Mirror');
    end
    
  case 'cwt_compute'
    
    
    %%%%% Fisrt get the input %%%%%%
    
    current_cursor=fl_waiton; 
    
    fl_clearerror;
    obj=findobj(Figcwt,'Tag','EditText_sig_nname');
    input_sig=get(obj,'String') ;
    eval(['global ' input_sig]);
    
    %%%%% Now get the wavelet type %%%%%
    ppmh=findobj(Figcwt,'Tag','PopupMenu_cwt_wtype');
    eth=findobj(Figcwt,'Tag','EditText_cwt_wsize');
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
    eth=findobj(Figcwt,'Tag','EditText_cwt_fmin');
    fmin=str2num(get(eth,'String'));
    eth=findobj(Figcwt,'Tag','EditText_cwt_fmax');
    fmax=str2num(get(eth,'String'));
    %%%%% Get the number of voices %%%%%
    eth=findobj(Figcwt,'Tag','EditText_cwt_voices');
    voices=str2num(get(eth,'String'));
    %%%%% L2 or L1? %%%%%
    l1l2=get(findobj(Figcwt,'Tag','Radiobutton_cwt_l1l2'),'Value');
    if(l1l2==0)
      mirror=get(findobj(Figcwt,'Tag','Radiobutton_cwt_mirror'),'Value');
      if(mirror==0)
	command='contwt';
      else
	command='contwtmir';
      end
    else
      command='cwt1D';	
    end
    %%%%% Get a name for the output var %%%%%
    prefix=['cwt_' input_sig];
    varname=fl_findname(prefix,varargin{2});
    varargout{1}=varname;
    eval(['global ' varname]);
    %%%%% Perform the computation %%%%%
    eval(['[wt scale f]=' command '(' input_sig ',fmin,fmax,voices,wave);']);
    eval ([varname ' = struct(''type'',''cwt'',''coeff'',wt,''scale'',scale,''frequency'',f);']);
    
    
    %%%%% Update the cwt list %%%%%
    fl_addlist(0,varname);
    
    fl_waitoff(current_cursor);
    
  case 'cwt_button_help'
    
    helpwin gui_fl_cwt
    
end
