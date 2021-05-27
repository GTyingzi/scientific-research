function [varargout]=fl_stinc2d_compute(varargin)

% Callback functions for FBM GUI - Generation Parameter Window.

% Modification P. Legrand, January 2005.

Figstinc2d = gcf;
if ((isempty(Figstinc2d)) | (~strcmp(get(Figstinc2d,'Tag'),'Fig_gui_fl_stinc2d')))
  Figstinc2d = findobj('Tag','Fig_gui_fl_stinc2d');
end

switch(varargin{1})

  %%%%% Creation functions for New Figures %%%%

  %%%%%% Initial H callbacks %%%%%%%
  case 'edit_inith'
	value=str2num(get(gcbo,'String'));
	value=trunc(value,0.0,1.0);
	set(gcbo,'String',value);
	set(findobj(Figstinc2d,'Tag','Slider_inith'),'Value',value);
  case 'slider_inith'
	SliderValue=get(gcbo,'Value');
	EditHandle=findobj(Figstinc2d,'Tag','EditText_inith');
	set(EditHandle,'String',SliderValue);

 
  %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
 	EditValue=str2num(get(gcbo,'String'));
	EditValue=floor(EditValue);
	EditValue=trunc(EditValue,1.0,Inf);
	set(gcbo,'String',EditValue);
  case 'ppm_sample'
	NSample=2^(get(gcbo,'Value')+2);
	EditHandle=findobj(Figstinc2d,'Tag','EditText_sample');
	set(EditHandle,'String',NSample);
	
%%%%%%%%%% Structure Function callbacks %%%%%%%%%%%%%%%

  case 'ppm_strfcn'
	core=get(gcbo,'Value') ;	
 
  %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
  case 'compute'

	current_cursor=fl_waiton;

		obj=findobj(Figstinc2d,'Tag','EditText_inith');
		H=str2num(get(obj,'String'));
		obj=findobj(Figstinc2d,'Tag','EditText_sample');
		N=str2num(get(obj,'String'));
		obj=findobj(Figstinc2d,'Tag','PopupMenu_strfcn');
		core_choice = get(obj,'Value') ;
		switch core_choice
		  case 1, 	
		    core = 'strfbm' ;
		  end
		varname = fl_findname('fBm2D',varargin{2});
		varargout{1}=varname;
		eval(['global ' varname]);
		  
		eval([varname ' = synth2(N,H,core);']);
        
        fl_diary([varname,'=synth2(',num2str(N),',',num2str(H),',''',core,''');'])

		fl_addlist(0,varname) ;

	fl_waitoff(current_cursor);
	
  case 'help'	
	 
        helpwin synth2
	

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
