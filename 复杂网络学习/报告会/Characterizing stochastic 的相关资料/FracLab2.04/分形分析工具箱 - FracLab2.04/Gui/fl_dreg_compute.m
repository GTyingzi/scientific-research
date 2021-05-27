function [varargout]=fl_dreg_compute(varargin)

% Callback function for Multifractal Denoising GUI
% 
% fl_dreg_compute
% Pierrick Legrand
% January 2005
%
% 1D and 2D Multifractal Denoising by multiplication by a scalar 
% between 0 and 1 at each scale .    
%
%
%
%   1.  Usage of the corresponding command:
%
%
%       [out]=fracden(in,trshld,sigma,1)
%       [out]=fracden2d(in,trshld,sigma,1)
%       sigma : Standard deviation
%
%
%   1.1.  Input Data
%
%   The input signal could be any highlighted  structure of the input list
%   ListBox of the main fltool  Figure: a real vector of size [M1,M2]. 
%      
%   It is selected when opening this  Figure from the corresponding
%   UiMenu of  the main  fltool  Figure, or by using the refresh PushButton.
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
%   o  Holder Exponent Shift : edit or slider
%      This parameter displays the difference between the Holder
%      exponent of the input signal and of the result.   
%
%   o  Standard Deviation : edit or slider
%      This parameter displays the estimated standard deviation of 
%      the noise that the user want remove.
%
%   o  Specify / Automatic : RadioButton
%      When specify is activated , the user can set the standard deviation
%      value as he wants . 
%      When Automatic is actived , the program finds an estimation of 
%      the standard deviation when testing the input signal .
%      In this case an other window is open where the user can 
%      read the estimated standard deviation .
%
%
%   2.2.  Computation
%
%
%   o  Compute :  PushButton.
%      Computes the  Multifractal denoising of the input signal 
%      depending on the choice in the edit or slider menus.
%      It calls the  routines fracden.m if the input signal is a vector
%      or fracden2d.m if it's a matrix.
%
%   o  Help : PushButton.
%      Calls this help.
%
%   o  Close : PushButton.
%      Closes the Multifractal Denoising Figure and returns
%      to the main fltool Figure.
%
%   3.  Outputs
%
%   o  There is only one output ; the signal after denoising .
%      

dreg_fig = gcf;
switch(varargin{1})

	%% Multiplication param editing
	case 'edit_param'
      fl_clearerror;
      alpha=str2num(get(gcbo,'String'));
      if isempty(alpha)
         fl_warning('Holder exponent shift must be a real !');
         pause(.3);
         alpha=1;
         set(gcbo,'String','1');
      else 
		alpha=trunc(alpha,-inf,inf);
		set(gcbo,'String',alpha);
        if alpha<=5 & alpha>=0
               set(findobj('Tag','Slider_dreg_param'),'Value',alpha);
        end       
      end;
     
	case 'edit_param2'
      fl_clearerror;
      sigma=str2num(get(gcbo,'String'));
      if isempty(sigma)
         fl_warning('Standard Deviation must be a real !');
         pause(.3);
         sigma=1;
         set(gcbo,'String','1');
      else 
		sigma=trunc(sigma,0,30000);
		set(gcbo,'String',sigma);
        
        if sigma>5
            set(findobj('Tag','Slider_dreg_param2'),'Value',5);
            %set(findobj('Tag','Slider_dreg_param2'),'Enable','off');
        else        
            set(findobj('Tag','Slider_dreg_param2'),'Value',sigma);
        end;    
      end;
   	
	case 'slider_param'
      fl_clearerror;
      alpha=get(gcbo,'Value');
		EditHandle=findobj('Tag','EditText_dreg_param');
		set(EditHandle,'String',alpha);
   case 'slider_param2'
      fl_clearerror;
      sigma=get(gcbo,'Value');
		EditHandle=findobj('Tag','EditText_dreg_param2');
      set(EditHandle,'String',sigma);
      
      
%       case 'edit_level' 
%       [SigIn_name error_in] = fl_get_input ('vector') ;
%       eval(['global ' SigIn_name]) ;
%       SigIn = eval(SigIn_name) ;
%       N = length(SigIn) ;
%       fl_clearerror;
%       level=str2num(get(gcbo,'String'));
%        if isempty(level) | level<1 | level > log2(N)
%          fl_warning('Level is an integer >1 and <log2(length(signal))!');
%          pause(.3);
%          level=(ceil(log2(N)/3));
%          set(gcbo,'String',num2str(level));
%        else 
%        level=floor(level);
%        set(gcbo,'String',num2str(level));
%    end
      
      %%%%%%%%% LOCAL SCALING PARAMETERS %%%%%%%%%%%
  case 'radiobutton_dreg'
     fl_clearerror;
     Reg = get(gcbo,'Value') ;     
	if Reg == 1 
      marqueur= get(gcbo,'Value') ;
      set(gcbo,'String','Specify') ;
      set(findobj(dreg_fig,'Tag','Slider_dreg_param2'),'enable','on');
      set(findobj(dreg_fig,'Tag','EditText_dreg_param2'),'enable','on');      
      %set(findobj(dreg_fig,'Tag','Radiobutton_dreg2'),'value',0);
      set(findobj(dreg_fig,'Tag','EditText_dreg_param3'),'Position',[0.78 0.33+0.12 0.001 0.001]);
      set(findobj(dreg_fig,'Tag','StaticText_dreg_param3'),'String',' ');
   elseif Reg == 0
      marqueur= get(gcbo,'Value') ;
      set(gcbo,'String','Automatic') ;
      set(findobj(dreg_fig,'Tag','Slider_dreg_param2'),'enable','off');
      set(findobj(dreg_fig,'Tag','EditText_dreg_param2'),'enable','off');      
      %set(findobj(dreg_fig,'Tag','Radiobutton_dreg2'),'value',1);
      set(findobj(dreg_fig,'Tag','EditText_dreg_param3'),'Position',[0.78 0.17+0.12 0.12 0.06],'enable','inactive');
      set(findobj(dreg_fig,'Tag','StaticText_dreg_param3'),'String','Estimated Standard Deviation');
   end
   
   
  %case 'radiobutton_dreg2'
   %  Reg = get(gcbo,'Value') ;     
	%if Reg == 1 
   %   set(findobj(dreg_fig,'Tag','Slider_dreg_param2'),'enable','off');
    %  set(findobj(dreg_fig,'Tag','EditText_dreg_param2'),'enable','off');      
     % set(findobj(dreg_fig,'Tag','Radiobutton_dreg'),'value',0);
   %elseif Reg == 0
    %  set(findobj(dreg_fig,'Tag','Slider_dreg_param2'),'enable','on');
    %  set(findobj(dreg_fig,'Tag','EditText_dreg_param2'),'enable','on');      
     % set(findobj(dreg_fig,'Tag','Radiobutton_dreg'),'value',1);
   %end
%%%%%%%%%%%%%%%%%%%%%

   case 'edit_level' 
      [SigIn_name error_in] = fl_get_input ('vector') ;
      eval(['global ' SigIn_name]) ;
      SigIn = eval(SigIn_name) ;
      N = length(SigIn) ;
      fl_clearerror;
      level=str2num(get(gcbo,'String'));
       if isempty(level) | level<1 | level > log2(N)
         fl_error('Level is an integer >1 and <log2(length(signal))!');
         pause(.3);
         level=(floor(log2(N))-floor((log2(N))/2)+1);
         set(gcbo,'String',num2str(level));
       else 
       level=floor(level);
       set(gcbo,'String',num2str(level));
       end
   
        if  level < (floor(log2(N))-floor((log2(N))/2)+1)
             fl_warning('Level is higher than floor(log2(N))-floor((log2(N))/2)+1','black');
             pause(.3);
             level=(floor(log2(N))-floor((log2(N))/2)+1);
             set(gcbo,'String',num2str(level));
         end
   
   %% "Compute" callbacks 
   case 'compute'
	p=fl_waiton;

	%%%%% First get the input %%%%%%
	fl_clearerror;
	InputName=get(findobj('Tag','EditText_sig_nname_dreg'),'String');
	if isempty(InputName)
	  fl_warning('Input signal must be initiated: Refresh!');
	  fl_waitoff(p);
	else
	  eval(['global ' InputName]);
	end;


   obj=findobj('Tag','EditText_dreg_param');
   obj2=findobj('Tag','EditText_dreg_param2');
   obj3=findobj('tag','Radiobutton_dreg');
   marqueur=get(obj3,'value');
   alpha=str2num(get(obj,'String'));
   sigma=str2num(get(obj2,'String'));
   OutputName=['mden_' InputName];
   
   obj=findobj('Tag','EditText_dreg_level');
   level=str2num(get(obj,'String'));
   
   
   %%%%%%%%%%%
    SigIn = eval(InputName) ;
    N = length(SigIn) ;
   if isempty(level) | level<1 | level > log2(N)
         fl_error('Level is an integer >1 and <log2(length(signal))!');
         pause(.3);
         level=(floor(log2(N))-floor((log2(N))/2)+1);
         set(findobj('Tag','EditText_dreg_level'),'String',num2str(level));
       else 
       level=floor(level);
       set(findobj('Tag','EditText_dreg_level'),'String',num2str(level));
       end
   
        if  level < (floor(log2(N))-floor((log2(N))/2)+1)
             fl_warning('Level is higher than floor(log2(N))-floor((log2(N))/2)+1','black');
             pause(.3);
             level=(floor(log2(N))-floor((log2(N))/2)+1);
             set(findobj('Tag','EditText_dreg_level'),'String',num2str(level));
         end
   
   
   %%%%%%%%%
   
   
   
   ondelette=(get(findobj('Tag','PopupMenu_dreg_wtype'),'String'));
   type=get(findobj('Tag','PopupMenu_dreg_wtype'),'Value');
   if type>=11
       type_ond='coiflet';
       siz=ondelette(type);
       siz1=siz{1}(9:10);
       siz1=str2num(siz1);
   else
       type_ond='daubechies';
       siz=ondelette(type);
       siz1=siz{1}(12:13);
       siz1=str2num(siz1);
   end;
   
   
   
   
	varname = fl_findname(OutputName,varargin{2});
	
	varargout{1}=varname;
	eval(['global ' varname]);
	eval(['global ' InputName]);
	% is it a vector or a matrix ?
	eval(['szmin=min(min(size(' InputName ')));']);
   if (szmin==1)
	  eval([varname '=fracden(' InputName ',alpha,sigma,marqueur,level,type_ond,siz1);']);
	
   chaine=[varname '=fracden(',InputName,',',num2str(alpha),','...
          ,num2str(sigma),',',num2str(marqueur),...
          ',',num2str(level),',''',type_ond,''',',...
          num2str(siz1),');'];
   
   else
	  eval([varname '=fracden2d(' InputName ',alpha,sigma,marqueur,level,type_ond,siz1);']);
  
      chaine=[varname '=fracden2d(',InputName,',',num2str(alpha),','...
          ,num2str(sigma),',',num2str(marqueur),...
          ',',num2str(level),',''',type_ond,''',',...
          num2str(siz1),');']; 
   
   end;
  
  fl_diary(chaine);
 	fl_waitoff(p);
   fl_addlist(0,varname) ;
  
	
   case 'refresh'
   fl_clearerror;
   [inputName flag_error]=fl_get_input('matrix');
   if flag_error
	  fl_warning('Invalid: input signal must be a matrix !');
	else
      eval(['global ' inputName]);
      
    
    %%%%%%%%%%%%%%% input frame %%%%%%%%%%%
      set(findobj('Tag','EditText_sig_nname_dreg'), ... 
	   'String',inputName);
   end;
    
	
	case 'help'
		helpwin('fl_dreg_compute');



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
