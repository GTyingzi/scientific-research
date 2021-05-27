function [varargout]=fl_ebp_compute(varargin)
	

%Modified By W.Arroum

Figebp = gcf;
if ((isempty(Figebp)) | (~strcmp(get(Figebp,'Tag'),'Fig_gui_fl_ebp')))
    Figebp = findobj ('Tag','Fig_gui_fl_ebp');
end

switch(varargin{1})


case 'radiobutton_geom'
	set(findobj(Figebp,'Tag','Radiobutton_geom'),'Value',1) ;
	set(findobj(Figebp,'Tag','Radiobutton_2valued'),'Value',0) ;
	
	set(findobj(Figebp,'Tag','StaticText_h_geom'),'enable','on');
	set(findobj(Figebp,'Tag','EditText_h_geom'),'enable','on');
	set(findobj(Figebp,'Tag','Slider_inith'),'enable','on');
	set(findobj(Figebp,'Tag','StaticText_h_2valued'),'enable','off');
	set(findobj(Figebp,'Tag','EditText_h_2valued'),'enable','off');
	set(findobj(Figebp,'Tag','StaticText_k_2valued'),'enable','off');
	set(findobj(Figebp,'Tag','EditText_k_2valued'),'enable','off');

case 'radiobutton_2valued'
	set(findobj(Figebp,'Tag','Radiobutton_geom'),'Value',0) ;
	set(findobj(Figebp,'Tag','Radiobutton_2valued'),'Value',1) ;
	
	set(findobj(Figebp,'Tag','StaticText_h_geom'),'enable','off');
	set(findobj(Figebp,'Tag','EditText_h_geom'),'enable','off');
	set(findobj(Figebp,'Tag','Slider_inith'),'enable','off');
	set(findobj(Figebp,'Tag','StaticText_h_2valued'),'enable','on');
	set(findobj(Figebp,'Tag','EditText_h_2valued'),'enable','on');
	set(findobj(Figebp,'Tag','StaticText_k_2valued'),'enable','on');
	set(findobj(Figebp,'Tag','EditText_k_2valued'),'enable','on');


        %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
        
case 'edittext_h_geom'
    value=str2num(get(gcbo,'String'));
    value=trunc(value,0.01,1.0);
    set(gcbo,'String',value);
    set(findobj(Figebp,'Tag','Slider_inith'),'Value',value);
			
case 'slider_inith'
    SliderValue=get(gcbo,'Value');
    if SliderValue==0
        SliderValue=0.01;
    end
    EditHandle=findobj(Figebp,'Tag','EditText_h_geom');
    set(EditHandle,'String',SliderValue);        
		        
case 'edit_sample'
    EditValue=str2num(get(gcbo,'String'));
    EditValue=floor(EditValue);
    set(gcbo,'String',EditValue);
        
case 'ppm_sample'
    NSample=2^(get(gcbo,'Value')+2);
    EditHandle=findobj(Figebp,'Tag','EditText_ebp_sample');
    set(EditHandle,'String',NSample);

case 'randstate_auto'
    randstate_auto = get(gcbo,'Value') ;
    if randstate_auto == 1
        set(findobj('tag','EditText_ebp_randstate'),'String','');
        set(findobj('tag','EditText_ebp_randstate'),'enable','off');
    else
        set(findobj('tag','EditText_ebp_randstate'),'enable','on');
    end



        
        %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
case 'compute'

        current_cursor=fl_waiton;
        
        if get(findobj(Figebp,'Tag','Radiobutton_geom'),'Value') == 1
        	H = str2num(get(findobj(Figebp,'Tag','EditText_h_geom'),'string'));
        	a = 2^((H-1)/H);
        	offspringftn = ['geom(' num2str(a) ')'];
        	samplingftn = ['geom_sample(' num2str(a) ')'];
        end
        if get(findobj(Figebp,'Tag','Radiobutton_2valued'),'Value') == 1
        	H = str2num(get(findobj(Figebp,'Tag','EditText_h_2valued'),'string'));
            if ~(0<H & H<=1)
                fl_error('H must be in]0,1]') ;
                fl_waitoff(current_cursor);
                varname = fl_findname('EBP',varargin{2}) ;
                varargout{1}=varname ;
                return ;
            end
            k = floor(str2num(get(findobj(Figebp,'Tag','EditText_k_2valued'),'string')));
            if k<0
                fl_error('k must be positive') ;
                varname = fl_findname('EBP',varargin{2}) ;
                varargout{1}=varname ;
                fl_waitoff(current_cursor);
                return ;
            end
        	a = (2^(1/H)-2*k)/(2-2*k);
        	offspringftn = ['two_valued(' num2str(a) ',' num2str(k) ')'];
        	samplingftn = ['two_valued_sample(' num2str(a)  ',' num2str(k) ')'];
        end
        
        x2 = 0;
        n = str2num(get(findobj(Figebp,'Tag','EditText_ebp_sample'),'String')) ;
        randstate_auto = get(findobj(Figebp,'Tag','randstate_auto'),'Value');
        X = Initialise(samplingftn);

        if ~randstate_auto
        	randstate = str2num(get(findobj(Figebp,'Tag','EditText_ebp_randstate'),'String')) ;
        end
        
        varname = fl_findname('EBP',varargin{2}) ;
        varargout{1}=varname ;

        eval(['global ' varname]);

        if ~randstate_auto
        	chaine = [varname '= Simulate([' num2str(X) '],' num2str(x2) ',' num2str(n) ',''' offspringftn ''',''' samplingftn ''',' num2str(randstate) ');'];
        else
        	chaine = [varname '= Simulate([' num2str(X) '],' num2str(x2) ',' num2str(n) ',''' offspringftn ''',''' samplingftn ''');'];
        end
        eval(chaine);
        fl_diary(chaine);
        fl_addlist(0,varname) ;
        fl_waitoff(current_cursor);

case 'help'

        helpwin


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