function varargout=fl_mbm_Levinson_compute(varargin)

% Callback functions for MBM GUI - Generation Parameter Window.


Figmbm = gcf;
if ((isempty(Figmbm)) | (~strcmp(get(Figmbm,'Tag'),'Fig_gui_fl_mbm_Levinson')))
  Figmbm = findobj ('Tag','Fig_gui_fl_mbm_Levinson');
end

switch(varargin{1})
  
  %%%%% Creation functions for New Figures %%%%
  
  %%%%%% Function H callbacks %%%%%%%
  
  case 'edit_funch'
    
    func=get(gcbo,'String');
    EditHandle=findobj(Figmbm,'Tag','EditText_mbm_sample');
    N = str2num(get(EditHandle,'String')) ;
    t = linspace(0,1,N) ;
    Ht = eval(func,'fl_error(''Bad function format'')') ;
    
  case 'ppm_funch'
    
    ppmValue=get(gcbo,'Value');
    EditHandle=findobj(Figmbm,'Tag','EditText_mbm_sample');
    N = str2num(get(EditHandle,'String')) ;
    t = linspace(0,1,N) ;
    switch ppmValue
      case 1, 	Ht = [ones(1,N/2)*0.2 ones(1,N/2)*0.8] ;
	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '[ones(1,N/2)*0.2 ones(1,N/2)*0.8]') ;
      case 2, 	Ht = linspace(0,1,N) ;
	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    't') ;
      case 3, 	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
	set(EditHandle,'String','example: abs(sin(t)), then press RETURN') ;
    end
    
    
    %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
    EditValue=str2num(get(gcbo,'String'));
    EditValue=floor(EditValue);
    EditValue=trunc(EditValue,1.0,Inf);
    set(gcbo,'String',EditValue);
  case 'ppm_sample'
    NSample=2^(get(gcbo,'Value')+2);
    EditHandle=findobj(Figmbm,'Tag','EditText_mbm_sample');
    set(EditHandle,'String',NSample);

    %%%%%%%%%% tmax callbacks %%%%%%%%%%%%%%%%
  case 'edit_tmax'
    tmax_value = str2num(get(gcbo,'String')) ;
    tmax_value = max(0,tmax_value) ;
    set(gcbo,'String',num2str(tmax_value)) ;	

    
    %%%%%%%%%% Random Seed callbacks %%%%%%%%%%%%%%%%
  case 'edit_rseed'
    EditValue=str2num(get(gcbo,'String'));
    EditValue=floor(EditValue);
    EditValue=trunc(EditValue,0.0,16777216.0);
    set(gcbo,'String',EditValue);
    
    
    %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
  case 'compute'
    
    current_cursor=fl_waiton;
    
    EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
    func = get(EditHandle,'String') ;
    EditHandle=findobj(Figmbm,'Tag','EditText_mbm_sample');
    N = str2num(get(EditHandle,'String')) ;
    EditHandle=findobj(Figmbm,'Tag','EditText_tmax');
    tmax = str2num(get(EditHandle,'String'));

    t = linspace(0,tmax,N) ;
    
    BadFormat = 0 ;
    eval([func,';'],'BadFormat = 1 ; ') ;
    if BadFormat , 
      fl_error('Bad Function Format! Use H(t) = t,  instead') ;
      Ht = t ;
      chaine = ['Ht=linspace(0,', num2str(tmax), ',', num2str(N),  ');'];
    elseif ~BadFormat ,
      Ht = eval(func) ;
      chaine = ['N=', num2str(N), '; t=linspace(0,', num2str(tmax), ',', num2str(N),  '); Ht=eval(''' func ''');'];
    end
    
    fl_diary(chaine);
    
    obj=findobj(Figmbm,'Tag','EditText_mbm_rseed') ;
    rseed_string=get(obj,'String') ;
    
    varname = fl_findname('mBm',varargin{2});
    varargout{1}=varname ;
    eval(['global ' varname]);
    
    if isempty(rseed_string)
      eval([varname '=mbmlevinson(N,Ht,tmax,1);']);
      chaine=[varname '=mBmlevinson(',num2str(N),...
          ',Ht,',num2str(tmax),',1);'];
    else
      rseed=str2num(rseed_string);
      eval([varname '=mbmlevinson(N,Ht,tmax,1,rseed);']);
      chaine=[varname '=mBmlevinson(',num2str(N),...
          ',Ht,',num2str(tmax),',1,',num2str(rseed),');'];
    end
    
    
    fl_diary(chaine);
    
    fl_addlist(0,varname) ;
    
    fl_waitoff(current_cursor);
    
  case 'help'	
    
    helpwin mbmlevinson
    
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% trunc %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function o=trunc(i,a,b)
if(i<a)
  o=a;
else
  if(i>b)
    o=b;
  else
    o=i;
  end 
end
