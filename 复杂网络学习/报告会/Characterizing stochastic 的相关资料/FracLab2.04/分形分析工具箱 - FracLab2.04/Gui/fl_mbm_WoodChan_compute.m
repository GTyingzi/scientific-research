function varargout=fl_mbm_WoodChan_compute(varargin)

% Callback functions for MBM GUI - Generation Parameter Window.


Figmbm = gcf;
if ((isempty(Figmbm)) | (~strcmp(get(Figmbm,'Tag'),'Fig_gui_fl_mbm_WoodChan')))
  Figmbm = findobj ('Tag','Fig_gui_fl_mbm_WoodChan');
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
      case 1, 	
	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '0.1+0.8*t') ;
      case 2,
	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '0.5+0.3*sin(4*pi*t)') ;
      case 3,
	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '0.3+0.3./(1+exp(-100*(t-0.7)))') ;    
      case 4, 	EditHandle=findobj(Figmbm,'Tag','EditText_mbm_funch');
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


    %%%%%%%%%% K-means callbacks %%%%%%%%%%%%%%%%
  case 'edit_kmeans'
    kmeans_value = str2num(get(gcbo,'String')) ;
    kmeans_value = max(0,kmeans_value) ;
    set(gcbo,'String',num2str(kmeans_value)) ;	

    
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
    EditHandle=findobj(Figmbm,'Tag','EditText_kmeans');
    k = str2num(get(EditHandle,'String'));

    t = linspace(0,tmax,N) ;
    
    BadFormat = 0 ;
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
      eval([varname '=mBmQuantifKrigeage(N,k,Ht,tmax,1);']);
      chaine=[varname '=mBmQuantifKrigeage(',num2str(N),',',num2str(k),...
          ',Ht,',num2str(tmax),',1);'];
    else
      rseed=str2num(rseed_string);
      eval([varname '=mBmQuantifKrigeage(N,k,Ht,tmax,1,rseed);']);
      chaine=[varname '=mBmQuantifKrigeage(',num2str(N),',',num2str(k),...
          ',Ht,',num2str(tmax),',1,',num2str(rseed),');'];
    end
    
    fl_diary(chaine);
    fl_addlist(0,varname) ;
    
    fl_waitoff(current_cursor);
    
  case 'help'	
    
    helpwin mBmQuantifKrigeage
    
    
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
