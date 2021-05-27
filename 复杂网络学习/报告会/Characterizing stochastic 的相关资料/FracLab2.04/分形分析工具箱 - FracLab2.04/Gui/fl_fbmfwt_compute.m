function [varargout]=fl_fbm_compute(varargin)

% Callback functions for FBM GUI - Generation Parameter Window.

Figfbmfwt = gcf;
if ((isempty(Figfbmfwt)) | (~strcmp(get(Figfbmfwt,'Tag'),'Fig_gui_fl_fbmfwt')))
  Figfbmfwt = findobj ('Tag','Fig_gui_fl_fbmfwt');
end

switch(varargin{1})

  %%%%% Creation functions for New Figures %%%%

  %%%%%% Initial H callbacks %%%%%%%
  case 'edit_inith'
	value=str2num(get(gcbo,'String'));
	value=trunc(value,0.0,1.0);
	set(gcbo,'String',value);
	set(findobj(Figfbmfwt,'Tag','Slider_inith'),'Value',value);
  case 'slider_inith'
	SliderValue=get(gcbo,'Value');
	EditHandle=findobj(Figfbmfwt,'Tag','EditText_inith');
	set(EditHandle,'String',SliderValue);

 
  %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
 	EditValue=str2num(get(gcbo,'String'));
	EditValue=floor(EditValue);
	EditValue=trunc(EditValue,1.0,Inf);
	set(gcbo,'String',EditValue);
  case 'ppm_sample'
	NSample=2^(get(gcbo,'Value')+2);
	EditHandle=findobj(Figfbmfwt,'Tag','EditText_sample');
	set(EditHandle,'String',NSample);

  %%%%%%%%%% Random Seed callbacks %%%%%%%%%%%%%%%%
  case 'edit_rseed'
	EditValue=str2num(get(gcbo,'String'));
	EditValue=floor(EditValue);
	EditValue=trunc(EditValue,0.0,16777216.0);
	set(gcbo,'String',EditValue);

 
  %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
  case 'compute'

	current_cursor=fl_waiton;

		obj=findobj(Figfbmfwt,'Tag','EditText_inith');
		H=str2num(get(obj,'String'));
		obj=findobj(Figfbmfwt,'Tag','EditText_sample');
		N=str2num(get(obj,'String'));
		obj=findobj(Figfbmfwt,'Tag','EditText_rseed');
		rseed_string=get(obj,'String');	
		ppmh=findobj(Figfbmfwt,'Tag','PopupMenu_dwt_type');
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
	
		varname = fl_findname('Wfbm',varargin{2});
		varargout{1}=varname;
		eval(['global ' varname]);

		if(strcmp(rseed_string,''))
		  eval([varname '=fbmfwt(N,H,floor(log2(N)),f1);']);
		else
	          rseed=str2num(rseed_string);
	          eval([varname '=fbmfwt(N,H,floor(log2(N)),f1,rseed);']);
		end
		fl_addlist(0,varname) ;

	fl_waitoff(current_cursor);
	
  case 'help'	
	 
        helpwin fbmfwt
	

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



