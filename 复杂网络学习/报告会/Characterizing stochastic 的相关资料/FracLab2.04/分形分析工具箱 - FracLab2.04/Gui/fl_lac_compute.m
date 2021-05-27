function [varargout]=fl_lac_compute(varargin)


% Callback function for lacunarity GUI
% fl_lac_compute
% Karine CHRISTOPHE
% April 2003
% Last Modification Pierrick Legrand January 2005
% 
% Lacunarity 
%
%
%
%   1.  Usage of the corresponding command:
%
%
%       [out]=lacunarity(A,eps_Min,eps_Max,step)
%
%
%
%   1.1.  Input Data
%
%   The input signal could be any highlighted  structure of the input list
%   ListBox of the main fltool  Figure: a real matrix of size [N,M]. 
%      
%   This matrix is selected when opening this  Figure from the corresponding
%   UiMenu of  the main  fltool  Figure, or when the refresh PushButton is used.
%   When the type of the  highlighted structure does not match with the
%   authorized types, an error  message is displayed in the message 
%   StaticText of the main  fltool Figure. The name of the input
%   data is displayed in the StaticText just below.
%
%
%   2.  UIcontrols
%
%   2.1.  Control parameters
%
%
%   o  frame min : edit
%      This parameter displays the minimum size of box for calculating the launarity of the input signal. 
%   o  frame max : edit
%      This parameter displays the maximum size of box for calculating the launarity of the input signal.
%   o  step : edit or slider
%      This parameter displays the step for calculating the lacunarity.
%      
%
%   2.2.  Computation
%
%
%   o  Compute :  PushButton.
%      Computes the  Lacunarity of the input signal 
%      depending on the choice in the edit or slider menu.
%      It calls the  routines lacunarity.m 
%
%   o  Help : PushButton.
%      Calls this help.
%
%   o  Close : PushButton.
%      Closes the Lacunarity Figure and returns
%      to the main fltool Figure.
%
%   3.  Outputs
%
%   o  There is only one output ; a signal which is the lacunarity of the
%   input versus the size of the frames.
%      


switch(varargin{1})

	%% Multiplication param editing
    % case 'frame min'
    case 'edit_param1'
      fl_clearerror;
      eps_min=str2num(get(gcbo,'String'));
      eps_max=get(findobj('Tag','EditText_lac_param2'),'String');
      eps_max=str2num(eps_max);
      step=get(findobj('Tag','EditText_lac_param3'),'String');
      step=str2num(step);
      if isempty(eps_min)|(eps_min~=floor(abs(eps_min)))
         fl_warning('The minimum size must be a positive integer !');
         pause(.3);
         eps_min=1;
         set(gcbo,'String','1');
      else
          set(gcbo,'String',num2str(eps_min));
      end;
      if (eps_min>eps_max)
          fl_warning('The minimum size must be smaller than the maximum !');
          pause(.3);
          eps_min=eps_max-step;
          set(gcbo,'String',num2str(eps_min));
      end
      
      
	% case 'frame max'
    case 'edit_param2'
      fl_clearerror;
      eps_max=str2num(get(gcbo,'String'));
      eps_min=get(findobj('Tag','EditText_lac_param1'),'String');
      eps_min=str2num(eps_min);
      step=get(findobj('Tag','EditText_lac_param3'),'String');
      step=str2num(step);
      InputName=get(findobj('Tag','EditText_sig_nname_lac'),'String');
      eval(['global ' InputName]);
      N = eval(['min(size(',InputName,'))']);
      if isempty(eps_max)|(eps_max~=floor((eps_max)))
         fl_warning('The maximum size must be a positive integer !');
         pause(.2);
         eps_max=(min(max(floor(N/4),50),N));
         set(gcbo,'String',num2str(eps_max));    
      elseif (eps_max<eps_min)|(eps_max <=0)
         fl_warning('The maximum size must be larger than the minimum !');
         pause(.1);
         eps_max=eps_min+step;
         set(gcbo,'String',num2str(eps_max));    
      elseif (eps_max>N)
         fl_warning('The maximum size must be smaller than the input !');
         pause(.3);
         eps_max=(min(max(floor(N/4),50),N));
         set(gcbo,'String',num2str(eps_max));
      else 
		 set(gcbo,'String',num2str(eps_max));
      end;
      
       % case 'step'
    case 'edit_param3'
      fl_clearerror;
      step=str2num(get(gcbo,'String'));
      eps_max=get(findobj('Tag','EditText_lac_param2'),'String');
      eps_max=str2num(eps_max);
      if isempty(step)|(step~=floor(abs(step)))
         fl_warning('The step must be a positive integer !');
         pause(.3);
         step=1;
         set(gcbo,'String','1');
      elseif(step>eps_max)
         fl_warning('The step must inferior to the size of the maximum size !');
		 pause(.3);
         step=1;
         set(gcbo,'String','1');
      end;
      
	

	%% "Compute" callbacks 
   case 'compute'
	p=fl_waiton;

	%%%%% First get the input %%%%%%
	fl_clearerror;
	InputName=get(findobj('Tag','EditText_sig_nname_lac'),'String');
	if isempty(InputName)
	  fl_warning('Input signal must be initiated : Refresh!');
	  fl_waitoff(p);
    else
	  eval(['global ' InputName]);
      if sum(sum(InputName))==0
          fl_warning('Input signal must not be a uniformly black image !')
      end
  end;

%paramètre frame min
	obj=findobj('Tag','EditText_lac_param1');
	eps_min=str2num(get(obj,'String'));
%paramètre frame max
    obj=findobj('Tag','EditText_lac_param2');
    eps_max=str2num(get(obj,'String'));
 %paramètre step
    obj=findobj('Tag','EditText_lac_param3');
    step=str2num(get(obj,'String'));
    
    OutputName=['lac_' InputName];
	varname = fl_findname(OutputName,varargin{2});
        
	varargout{1}=varname;
    eval(['global ' varname]);
    eval(['global ' InputName]);
    eval(['[list_lac,time]=lacunarity(' InputName ',eps_min,eps_max,step);']);

    
     chaine=['[',OutputName,'.data2,',OutputName,'.data1]=lacunarity(', InputName,...
        ',',num2str(eps_min),',',num2str(eps_max),',',num2str(step),');'];
    fl_diary(chaine)
    
    
    eval ([varname '= struct (''type'',''graph'',''data1'',time,''data2'',list_lac,''title'',[''Lacunarity''],''xlabel'',''window size'',''ylabel'',''Lacunarity'');']);
    
   
    
    
	fl_waitoff(p);
	fl_addlist(0,varname) ;
    
    %plot(varname.data1,varname.data2);
   
   case 'refresh'
   fl_clearerror;
   [inputName flag_error]=fl_get_input('matrix');
   
    if flag_error
	  fl_warning('Invalid: input signal must be a 2D matrix !');
	else
      eval(['global ' inputName]);
      N = eval(['min(size(',inputName,'))']);
      if (N <= 1)
	  fl_warning('Invalid: input signal must be a 2D matrix !');
      else
 
    %%%%%%%%%%%%%%% input frame %%%%%%%%%%%
      set(findobj('Tag','EditText_sig_nname_lac'), ... 
	  'String',inputName);
      end 


   end; 
	
	case 'help'
		helpwin('fl_lac_compute');



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
