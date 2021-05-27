function [varargout]=fl_multden_compute(varargin)

% Callback function for multifractal denoising GUI
% fl_multden_compute
% Author : 
% Last Modifications : Pierrick Legrand
% February , 5th 2001
%
% 1D and 2D Multifractal Denoising by multiplication by a scalar 
% between 0 and 1 at each scale .    
%
%
%
%   1.  Usage of the corresponding command:
%
%
%       [wtout] = WTPump(wtin, trshld, mode)
%       [wtout] = WT2DPump(wtin, trshld, mode)
%       wtin : wavelet transform
%       mode : 's' (single) or 'm' (multi) 
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
%   o  Spectrum Shift Value : edit or slider
%      This parameter displays the increasing of the spectrum value.   
%
%
%   2.2.  Computation
%
%
%   o  Compute :  PushButton.
%      Computes the  Multifractal Denoising of the input signal 
%      depending on the choice in the edit or slider menu.
%      It calls the  routines WTPump.m if the input signal is a vector
%      or WT2DPump.m if it's a matrix.
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

switch(varargin{1})

  %% Shifting param editing
  case 'edit_alphashift'
    fl_clearerror;
    alpha=str2num(get(gcbo,'String'));
    if isempty(alpha)
         fl_warning('Spectrum shift value must be a real !');
         pause(.3);
         alpha=1;
         set(gcbo,'String','1');
    else 
    alpha=trunc(alpha,-5.0,5.0);
    set(gcbo,'String',alpha);
    set(findobj('Tag','Slider_multden_alphashift'),'Value',alpha);
    end;
  case 'slider_alphashift'
    fl_clearerror; 
    alpha=get(gcbo,'Value');
    EditHandle=findobj('Tag','EditText_multden_alphashift');
    set(EditHandle,'String',alpha);
    
    %% "Compute" callbacks 
  case 'compute'
    p=fl_waiton;

    %%%%% First get the input %%%%%%
    fl_clearerror;
    InputName=get(findobj('Tag','EditText_sig_nname_multden'),'String');
    if isempty(InputName)
      fl_warning('Input signal must be initiated: Refresh!');
      fl_waitoff(p);
    else
      eval(['global ' InputName]);
    end;

    obj=findobj('Tag','EditText_multden_alphashift');
    alpha=str2num(get(obj,'String'));
    
    OutputName=['den_' InputName];
    varname = fl_findname(OutputName,varargin{2});
    
    varargout{1}=varname;
    eval(['global ' varname]);
    eval(['global ' InputName])
    % is it a vector or a matrix ?
    eval(['szmin=min(min(size(' InputName ')));']);
    if (szmin==1)
      eval([varname '=denois(' InputName ',alpha);']);
    else
      eval([varname '=denois2D(' InputName ',alpha);']);
    end;
    
    
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
      set(findobj('Tag','EditText_sig_nname_multden'), ... 
	   'String',inputName);
   end; 
    
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



