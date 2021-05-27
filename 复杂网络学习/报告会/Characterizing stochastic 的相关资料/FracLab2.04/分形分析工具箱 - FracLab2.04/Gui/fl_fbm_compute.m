function [varargout]=fl_fbm_compute(varargin)

% Callback functions for FBM GUI - Generation Parameter Window.


Figfbm = gcf;
if ((isempty(Figfbm)) | (~strcmp(get(Figfbm,'Tag'),'Fig_gui_fl_fbm')))
  Figfbm = findobj ('Tag','Fig_gui_fl_fbm');
end

switch(varargin{1})

  %%%%% Creation functions for New Figures %%%%

  %%%%%% Initial H callbacks %%%%%%%
  case 'edit_inith'
	value=str2num(get(gcbo,'String'));
	value=trunc(value,0.0,1.0);
	set(gcbo,'String',value);
	set(findobj(Figfbm,'Tag','Slider_inith'),'Value',value);
  case 'slider_inith'
	SliderValue=get(gcbo,'Value');
	EditHandle=findobj(Figfbm,'Tag','EditText_inith');
	set(EditHandle,'String',SliderValue);

 
  %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
 	EditValue=str2num(get(gcbo,'String'));
	EditValue=floor(EditValue);
	EditValue=trunc(EditValue,1.0,Inf);
	set(gcbo,'String',EditValue);
  case 'ppm_sample'
	NSample=2^(get(gcbo,'Value')+2);
	EditHandle=findobj(Figfbm,'Tag','EditText_sample');
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

		obj=findobj(Figfbm,'Tag','EditText_inith');
		H=str2num(get(obj,'String'));
		obj=findobj(Figfbm,'Tag','EditText_sample');
		N=str2num(get(obj,'String'));
		obj=findobj(Figfbm,'Tag','EditText_tmax');
		tmax = str2num(get(obj,'String'));
		obj=findobj(Figfbm,'Tag','EditText_rseed');
		rseed_string=get(obj,'String');

		varname = fl_findname('fBm',varargin{2});
		varargout{1}=varname;
		eval(['global ' varname]);

		if(strcmp(rseed_string,''))
		  eval([varname '=fbmlevinson(N,H,tmax,1);']);
		else
	          rseed=str2num(rseed_string);
	          eval([varname '=fbmlevinson(N,H,tmax,1,rseed);']);
		end
		fl_addlist(0,varname) ;

	fl_waitoff(current_cursor);
	
  case 'help'	
	 
        helpwin fbmlevinson
	

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
