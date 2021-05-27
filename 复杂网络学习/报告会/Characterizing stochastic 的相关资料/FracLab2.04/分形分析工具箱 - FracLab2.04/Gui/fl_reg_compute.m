function [varargout]=fl_reg_compute(varargin)


% Callback function for multifractal regularization GUI
% fl_reg_compute
% Pierrick Legrand
% February , 5th 2001
% Modification P. Legrand, January 2005.
%
% 1D and 2D Multifractal Regularization by multiplication by a scalar 
% between 0 and 1 at each scale .    
%
%
%
%   1.  Usage of the corresponding command:
%
%
%       [out]=fracreg(in, trshld, start_level)
%       [out]=fracreg2d(in, trshld, start_level)
%
%
%
%   1.1.  Input Data
%
%   The input signal could be any highlighted  structure of the input list
%   ListBox of the main fltool  Figure: a real matrix of size [M1,M2]. 
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
%   o  Holder Exponent Shift : edit or slider
%      This parameter displays the difference between the Holder
%      exponent of the input signal and of the result.   
%
%
%   2.2.  Computation
%
%
%   o  Compute :  PushButton.
%      Computes the  Multifractal Regularization of the input signal 
%      depending on the choice in the edit or slider menu.
%      It calls the  routines fracreg.m if the input signal is a vector
%      or fracreg2d.m if it's a matrix.
%
%   o  Help : PushButton.
%      Calls this help.
%
%   o  Close : PushButton.
%      Closes the Multifractal Regularisation Figure and returns
%      to the main fltool Figure.
%
%   3.  Outputs
%
%   o  There is only one output ; a signal which has a Holder exponent H
%      H=(Holder exponent of the input+Holder exponent shift defined by user)
%      everywhere.
%      


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
          set(findobj('Tag','Slider_reg_param'),'Value',alpha);
        end;          
      end;
		
	case 'slider_param'
      fl_clearerror;
      alpha=get(gcbo,'Value');
		EditHandle=findobj('Tag','EditText_reg_param');
	 set(EditHandle,'String',alpha);

        
     case 'edit_level' 
         [SigIn_name error_in] = fl_get_input ('vector') ;
         eval(['global ' SigIn_name]) ;
         SigIn = eval(SigIn_name) ;
         N = length(SigIn); 
         fl_clearerror;
         level=str2num(get(gcbo,'String'));
         if isempty(level) | level<1 | level > log2(N)
             pause(.3);
             level=floor(log2(N))-floor((log2(N))/2)+1;
             set(gcbo,'String',num2str(level));
             fl_error('Level is an integer >1 and <log2(length(signal))!');

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
	InputName=get(findobj('Tag','EditText_sig_nname_reg'),'String');
	if isempty(InputName)
	  fl_warning('Input signal must be initiated: Refresh!');
	  fl_waitoff(p);
	else
	  eval(['global ' InputName]);
	end;


	obj=findobj('Tag','EditText_reg_param');
	alpha=str2num(get(obj,'String'));
    
    obj=findobj('Tag','EditText_reg_level');
    level=str2num(get(obj,'String'));
    
    
     SigIn = eval(InputName) ;
         N = length(SigIn); 
         
         if isempty(level) | level<1 | level > log2(N)
             pause(.3);
             level=floor(log2(N))-floor((log2(N))/2)+1;
             set(findobj('Tag','EditText_reg_level'),'String',num2str(level));
             fl_error('Level is an integer >1 and <log2(length(signal))!');

         else
             level=floor(level);
             set(findobj('Tag','EditText_reg_level'),'String',num2str(level));
         end

         if  level < (floor(log2(N))-floor((log2(N))/2)+1)
             fl_warning('Level is higher than floor(log2(N))-floor((log2(N))/2)+1','black');
             pause(.3);
             level=(floor(log2(N))-floor((log2(N))/2)+1);
             set(findobj('Tag','EditText_reg_level'),'String',num2str(level));
         end
    
    
    
    ondelette=(get(findobj('Tag','PopupMenu_reg_wtype'),'String'));
   type=get(findobj('Tag','PopupMenu_reg_wtype'),'Value');
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
    
    
	OutputName=['mreg_' InputName];
	varname = fl_findname(OutputName,varargin{2});
	
	varargout{1}=varname;
	eval(['global ' varname]);
	eval(['global ' InputName]);
	% is it a vector or a matrix ?
	eval(['szmin=min(min(size(' InputName ')));']);
	if (szmin==1)
	  eval([varname '=fracreg(' InputName ',alpha,level,type_ond,siz1);']);
      chaine=[varname '=fracreg(',InputName,',',num2str(alpha),','...
          ,num2str(level),',''',type_ond,''',',...
          num2str(siz1),');'];
	else
	  eval([varname '=fracreg2d(' InputName ',alpha,level,type_ond,siz1);']);
	 chaine=[varname '=fracreg2d(',InputName,',',num2str(alpha),','...
          ,num2str(level),',''',type_ond,''',',...
          num2str(siz1),');'];
    end;
	
    fl_diary(chaine)
    
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
   set(findobj('Tag','EditText_sig_nname_reg'), ... 
	'String',inputName);
   end; 
	
	case 'help'
		helpwin('fl_reg_compute');



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
