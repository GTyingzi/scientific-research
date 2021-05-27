function [varargout]=fl_mbm2d_compute(varargin)

% Callback functions for MBM GUI - Generation Parameter Window.


Figmbm2d = gcf;
if ((isempty(Figmbm2d)) | (~strcmp(get(Figmbm2d,'Tag'),'Fig_gui_fl_mbm2d')))
  Figmbm2d = findobj ('Tag','Fig_gui_fl_mbm');
end

switch(varargin{1})
  
  %%%%% Creation functions for New Figures %%%%
  
  %%%%%% Function H callbacks %%%%%%%
  
  case 'edit_funch'
    
    func=get(gcbo,'String');
    EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_sample');
    N = str2num(get(EditHandle,'String')) ;
    
  case 'ppm_funch'
    
    ppmValue=get(gcbo,'Value');
    EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_sample');
    N = str2num(get(EditHandle,'String')) ;
    t = linspace(0,1,N) ;
    switch ppmValue
      case 1, 	
	EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '0.1+0.8*x.*y') ;
      case 2,
	EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '0.5+0.2*sin(2*pi*x).*cos(3/2*pi*y)') ;
      case 3,
	EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_funch');
	set(EditHandle,'String', ...
	    '0.3+0.3./(1+exp(-100*(x-0.7)))') ;    
      case 4, 	EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_funch');
	set(EditHandle,'String','example: abs(sin(x*y)), then press RETURN') ;
    end
    
    
    %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
    EditValue=str2num(get(gcbo,'String'));
    EditValue=floor(EditValue);
    EditValue=trunc(EditValue,1.0,Inf);
    set(gcbo,'String',EditValue);
  case 'ppm_sample'
    NSample=2^(get(gcbo,'Value')+2);
    EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_sample');
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
    
    EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_funch');
    func = get(EditHandle,'String') ;
    EditHandle=findobj(Figmbm2d,'Tag','EditText_mbm_sample');
    N = str2num(get(EditHandle,'String')) ;
    EditHandle=findobj(Figmbm2d,'Tag','EditText_kmeans');
    k = str2num(get(EditHandle,'String'));

    x = linspace(0,1,N);
    y = linspace(0,1,N);
        
    %BadFormat = 0 ;
    %eval([func,';'],'BadFormat = 1 ; ') ;
    %if BadFormat , 
    %  fl_error('Bad Function Format! Use H(x,y) = x*y,  instead') ;
    %  	Hxy = x'*y
    %elseif ~BadFormat ,
    try
	[X,Y]=meshgrid(x,y);
	f = inline(func,'x','y');
	Hxy = f(X,Y);
     catch
     	fl_error('Bad Function Format! Use H(x,y) = x.*y,  instead') ;
     	return;
     end
    
    chaine = ['x = linspace(0,1,', num2str(N), '); y = linspace(0,1,', num2str(N), '); [X,Y]=meshgrid(x,y); f = inline(''', func, ''',''x'',''y''); Hxy = f(X,Y);'];
    fl_diary(chaine);
    
    %end
    
    obj=findobj(Figmbm2d,'Tag','EditText_mbm_rseed') ;
    rseed_string=get(obj,'String') ;
    
    varname = fl_findname('mBm2D',varargin{2});
    varargout{1}=varname ;
    eval(['global ' varname]);
    
    if isempty(rseed_string)
      eval([varname '=mBm2DQuantifKrigeage(N,k,Hxy);']);
      chaine=[varname,'=mBm2DQuantifKrigeage(',num2str(N),',',num2str(k),',Hxy);'];
    else
      rseed=str2num(rseed_string);
      eval([varname '=mBm2DQuantifKrigeage(N,k,Hxy,rseed);']);
      chaine=[varname,'=mBm2DQuantifKrigeage(',num2str(N),',',num2str(k),',Hxy,',num2str(rseed),');'];
    end
    fl_diary(chaine);
    
    fl_addlist(0,varname) ;
    
    fl_waitoff(current_cursor);
    
  case 'help'	
    
    helpwin mBm2DQuantifKrigeage
    
    
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
