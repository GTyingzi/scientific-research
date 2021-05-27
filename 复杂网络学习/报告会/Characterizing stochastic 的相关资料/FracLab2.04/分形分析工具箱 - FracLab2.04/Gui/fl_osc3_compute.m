function [varargout]=fl_osc3_compute(varargin)

% Callback functions for osc3 GUI

% Modification P. Legrand, January 2005.
% Modification O. Barrière, September 2005.

varOutstring=[];
%warning off;
%osc3_fig = gcf;
[objTmp,osc3_fig] = gcbo;

if ((isempty(osc3_fig)) | (~strcmp(get(osc3_fig,'Tag'),'Fig_gui_fl_osc3')))
  osc3_fig = findobj ('Tag','Fig_gui_fl_osc3');
end

% osc3_fig

%   [SigIn_name error_in] = fl_get_input('vector') ;
%	eval(['global ',SigIn_name]) ;
%	if error_in
%	  fl_warning('Input must be a vector !') ;
%	  fl_waitoff(current_cursor);
%	  return ;
%	end
%	SigIn = eval(SigIn_name) ;
%	N = length(SigIn) ;
%  set(findobj(osc3_fig,'Tag','EditText_adv_osc3_time'),'String',num2str(floor(N/2)));

switch(varargin{1})

  case 'editRmin'
	value=str2num(get(gcbo,'String'));
    %%%%%%%%%%%%%%%%%%%%%
    valueMax=str2num(get(findobj(osc3_fig,'Tag','EditText_Rmax_osc3'),'String'));
    if value>valueMax
        value=valueMax-1;
        set(gcbo,'String',num2str(value));
    end
	
	  
  case 'editRmax'
	value=str2num(get(gcbo,'String'));
    %%%%%%%%%%%%%%%%%%%%%%
    valueMin=str2num(get(findobj(osc3_fig,'Tag','EditText_Rmin_osc3'),'String'));
    if value<valueMin
        value=valueMin+1;
        set(gcbo,'String',num2str(value));
    end;
      
    
 case 'edit_time'
   fl_clearerror;  
	[SigIn_name error_in] = fl_get_input('vector') ;
	eval(['global ',SigIn_name]) ;
	if error_in
	  fl_warning('Input must be a vector !') ;
	  fl_waitoff(current_cursor);
	  return ;
	end
	SigIn = eval(SigIn_name) ;
	N = length(SigIn) ;
   time=str2num(get(gcbo,'String'));
   if isempty(time) 
         fl_warning('Time instant must be an integer !');
         pause(.3);
         time=floor(N/2);
         set(gcbo,'String',num2str(time));
   elseif size(time,1)>1 |  size(time,2)>1 
       fl_warning('Time instant must be an integer !');
       pause(.3);
       time=time(end);
       set(gcbo,'String',num2str(time));
   else
      time = floor(trunc(time,1,N)) ;
      set(gcbo,'String',num2str(time)) ;
   end;
	
 case 'refresh'
	fl_clearerror;
	[inputName flag_error]=fl_get_input('matrix');
	if flag_error
	  fl_warning('Invalid: input signal must be a matrix !');
	else 
	  eval(['global ' inputName]);
	  %eval(['[n,p] = size(' inputName ');']);
	  
	  %%%%%%%%%%%%%%% input frame %%%%%%%%%%%
	  set(findobj(osc3_fig,'Tag','EditText_sig_nname_osc3'),'String',inputName);
	  
	  %%%%%%%%%%%%%%% regression frame %%%%%%%%%%%
	  %set(findobj(osc3_fig,'Tag','PopupMenu_regtype_osc3'),'Value',1);
	    
	end
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute osc3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  case 'compute_osc3'

	current_cursor=fl_waiton;
	
	%%%%% First get the input %%%%%%
	fl_clearerror;
	inputName=get(findobj(osc3_fig,'Tag','EditText_sig_nname_osc3'),'String');
	if isempty(inputName)
	  fl_warning('Input signal must be initiated: Refresh!');
	  fl_waitoff(current_cursor);
	else
	  eval(['global ' inputName]);
	  
	  %%%%%% Disable close and compute %%%%%%%%
	  set(findobj(osc3_fig,'Tag','Pushbutton_wclose_osc3'),'enable','off');
	  set(findobj(osc3_fig,'Tag','Pushbutton_osc3_compute_osc3'),'enable','off');
	  
	  
	  %%%%% Get Rmin and Rmax %%%%%
	  eth=findobj(osc3_fig,'Tag','EditText_Rmin_osc3');
	  Rmin=str2num(get(eth,'String'));
	  eth=findobj(osc3_fig,'Tag','EditText_Rmax_osc3');
	  Rmax=str2num(get(eth,'String'));
	  base=str2num(get(findobj(osc3_fig,'Tag','EditText_base_osc3'),'String'));
	  
	  
	  %%%%% regression argument %%%%%
	  RegType=get(findobj(osc3_fig,'Tag','PopupMenu_regtype_osc3'),'Value');
      SigIn_name = get(findobj(osc3_fig,'Tag','EditText_sig_nname_osc3'),'String') ;
      eval(['global ' SigIn_name]) ;
      SigIn = eval(SigIn_name) ;
      N = length(SigIn) ;
      scale=ones(1,log2(N));
      RegParam = fl_getregparam(RegType,length(scale)) ;
	  
     %%%%% Perform the computation %%%%%
     Hldfct=get(findobj(osc3_fig,'Tag','Radiobutton_adv_track_time'),'Value');
     timeinstant=str2num(get(findobj(osc3_fig,'Tag','EditText_adv_osc3_time'),'String'));
     if Hldfct==1  
       OutputName=['pht_' inputName];
	     varname = fl_findname(OutputName,varargin{2});
	     eval(['global ' varname]);
	     varargout{1}=varname;
	     eval([varname '=exposc3(', inputName, ',base,Rmin,Rmax,{RegParam{:}});']);
         chaine=[varname '=exposc3(', inputName,...
              ',',num2str(base),',',num2str(Rmin),',',num2str(Rmax),...
              ',{''',num2str(RegParam{:}),'''});'];
         fl_diary(chaine);
         fl_addlist(0,varname) ;
     else
       OutputName=['pht_' inputName];
	     varname = fl_findname(OutputName,varargin{2});
	     eval(['global ' varname]);
	     varargout{1}=varname;
	     eval([varname '=exposc3(', inputName, ',base,Rmin,Rmax, {RegParam{:}},timeinstant);']);
         chaine=[varname '=exposc3(', inputName,...
              ',',num2str(base),',',num2str(Rmin),',',num2str(Rmax),...
              ',{''',num2str(RegParam{:}),'''},',num2str(timeinstant),');'];
         fl_diary(chaine);
         fl_addlist(0,varname) ;  
     end;           

	  %%%%% store the figure handles %%%%%
	  %global handlefig_osc3
	  %handlefig_osc3=[handlefig_osc3,handlefig];
	  
	  %%%%% Enable to print the new figures %%%%%
	  %if ~isempty(handlefig)
	  %  set(findobj(osc3_fig,'Tag','Pushbutton_wprint_osc3'),'enable','on');
	  %  set(findobj(osc3_fig,'Tag','EditFigHandle_osc3'),'enable','on');
	  %  set(findobj(osc3_fig,'Tag','EditFigHandle_osc3'),'String',num2str(handlefig(1)));
	  %end
	  
	  %%%%% Display the result %%%%%%%%%
	  %set(obj,'String',num2str(dim)) ;
	  
	  fl_waitoff(current_cursor);
	  %%%%%% Enable close and compute %%%%%%%%
	  set(findobj(osc3_fig,'Tag','Pushbutton_wclose_osc3'),'enable','on');
	  set(findobj(osc3_fig,'Tag','Pushbutton_osc3_compute_osc3'),'enable','on');
	  
	end
   
%%%%%%%%% LOCAL SCALING PARAMETERS %%%%%%%%%%%%

  case 'radiobutton_reg'
	Reg = get(gcbo,'Value') ;
	if Reg == 1 
	  set(gcbo,'String','Specify') ;
	elseif Reg == 0
	  set(gcbo,'String','Automatic') ;
  end
  
  case 'radiobutton_time'
	Reg = get(gcbo,'Value') ;
	if Reg == 1 
      set(gcbo,'String','Holder Function') ;
      set(findobj(osc3_fig,'Tag','StaticText1'),'enable','off');
      set(findobj(osc3_fig,'Tag','EditText_adv_osc3_time'),'enable','off');
	elseif Reg == 0
      set(gcbo,'String','Single time exponent') ;
      set(findobj(osc3_fig,'Tag','StaticText1'),'enable','on');
      set(findobj(osc3_fig,'Tag','EditText_adv_osc3_time'),'enable','on');
	end
	
	
  case 'close'
	h=findobj('tag', 'Fig_gui_fl_osc3');
	close(h);%warning backtrace;
	
  case 'help'
        helpwin exposc3

        
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









