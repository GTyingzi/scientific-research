function [varargout]=fl_lacunary_compute(varargin)
% Callback functions for LACUNARY GUI - Generation Parameter Window.

% Modification P. Legrand, January 2005.


Figlacunary = gcf;
if ((isempty(Figlacunary)) | (~strcmp(get(Figlacunary,'Tag'),'Fig_gui_fl_lacunary')))
  Figlacunary = findobj ('Tag','Fig_gui_fl_lacunary');
end

switch(varargin{1})
  
  %%%%% Creation functions for New Figures %%%%
  
  %%%%%% Initial H callbacks %%%%%%%
  case 'edit_inith'
    value=str2num(get(gcbo,'String'));
    value=trunc(value,0.0,1.0);
    set(gcbo,'String',value);
    set(findobj(Figlacunary,'Tag','Slider_inith'),'Value',value);
  case 'slider_inith'
    SliderValue=get(gcbo,'Value');
    EditHandle=findobj(Figlacunary,'Tag','EditText_inith');
    set(EditHandle,'String',SliderValue);
    
    %%%%%% Initial LACUNARY callbacks %%%%%%%
  case 'edit_initlac'
    value=str2num(get(gcbo,'String'));
    value=trunc(value,0.0,1.0);
    set(gcbo,'String',value);
    set(findobj(Figlacunary,'Tag','Slider_initlac'),'Value',value);
  case 'slider_initlac'
    SliderValue=get(gcbo,'Value');
    EditHandle=findobj(Figlacunary,'Tag','EditText_initlac');
    set(EditHandle,'String',SliderValue);
    
    
    %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
    EditValue=str2num(get(gcbo,'String'));
    EditValue=floor(EditValue);
    EditValue=trunc(EditValue,1.0,Inf);
    if log2(EditValue)~=floor(log2(EditValue))
       EditValue=2^floor(log2(EditValue));
    end;   
    set(gcbo,'String',EditValue);
    EditHandle=findobj(Figlacunary,'Tag','PopupMenu_sample');
    set(EditHandle,'Value',min(floor(log2(EditValue))-2,10));
    
  case 'ppm_sample'
    NSample=2^(get(gcbo,'Value')+2);
    EditHandle=findobj(Figlacunary,'Tag','EditText_sample');
    set(EditHandle,'String',NSample);
    
    %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
  case 'compute'
	
    current_cursor=fl_waiton;
    
    obj=findobj(Figlacunary,'Tag','EditText_inith');
    H=str2num(get(obj,'String'));
    obj=findobj(Figlacunary,'Tag','EditText_initlac');
    eta=str2num(get(obj,'String'));		
    obj=findobj(Figlacunary,'Tag','EditText_sample');
    N=str2num(get(obj,'String'));
    ppmh=findobj(Figlacunary,'Tag','PopupMenu_dwt_type');
    wt_order=get(ppmh,'Value');
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
    
    varname = fl_findname('lacunary',varargin{2});
    varargout{1}=varname;
    eval(['global ' varname]);
    
    eval([varname '=lacunary(N,eta,H,f1);']);
    
    chaine=[varname,'=lacunary(',num2str(N),',',num2str(eta),',',...
        num2str(H),',[',num2str(f1),']);'];
    
    fl_diary(chaine);
    
    fl_addlist(0,varname) ;
    
    fl_waitoff(current_cursor);
    
  case 'help'	
    
    helpwin lacunary
    
    
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



