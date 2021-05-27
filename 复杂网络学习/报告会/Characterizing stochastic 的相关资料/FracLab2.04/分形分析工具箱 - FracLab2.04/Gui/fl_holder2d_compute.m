function [varargout]=fl_holder2d_compute(varargin)

% Callback function for multifractal denoising GUI

switch(varargin{1})

        case 'refresh_input'
		[InputName flag_error]=fl_get_input('matrix');
		if flag_error
		  fl_warning('Input must be a matrix !');
		  return;
		end
		fig = findobj('Tag','Fig_gui_fl_holder2d');
		edit_input = findobj(fig,'Tag','EditText_sig_nname');
		set(edit_input,'String',InputName);
		set(findobj(fig,'Tag','Pushbutton_holder2d_compute'),'Enable','on');
  
	%% Shifting param editing
	case 'slider_res'
		alpha=round(get(gcbo,'Value'));
		LabelHandle=findobj('Tag','StaticText_holder2d_resdisp');
		set(gcbo,'Value',alpha);
		set(LabelHandle,'String',num2str(alpha));

	%% "Compute" callbacks 
      case 'compute'
	
         	myp=fl_waiton;
		fig = findobj('Tag','Fig_gui_fl_holder2d');
		InputName = get(findobj(fig,'Tag','EditText_sig_nname'),'String');
		obj=findobj(fig,'Tag','Slider_holder2d_reso');
		alpha=num2str(get(obj,'Value'));
		
		hpopup =  findobj(fig,'Tag','PopupMenu_fl_holder2d');
		measnum = get(hpopup,'Value');
		OutputName=['hld2d_' InputName];
		varname = fl_findname(OutputName,varargin{2});
		
		varargout{1}=varname;
		eval(['global ' varname ';']);
		eval(['global ' InputName ';']);
		
		measures = {'sum'; 'var'; 'ecart'; 'min'; 'max'};
		meas = measures{measnum};
		eval([varname '=holder2d(' InputName ',''' meas ''',' alpha ');']);
		
		fl_waitoff(myp);
		fl_addlist(0,varname) ;
		

	case 'help'
		helpwin('fl_multden_compute');



end;


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
