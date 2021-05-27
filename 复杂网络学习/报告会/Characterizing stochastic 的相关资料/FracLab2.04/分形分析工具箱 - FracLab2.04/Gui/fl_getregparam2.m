function [paramOut]=fl_getregparam2(varargin)


if varargin{1}==1
  paramOut{1}='ls';
  return;
elseif varargin{1}==2
   paramOut{1}='ml';
   return;
elseif varargin{1}==3
  paramOut{1}='lapls';
  return;
elseif varargin{1}==4
  paramOut{1}='linf';
  return;
elseif varargin{1}==5
  paramOut{1}='lsup';
  return;  
end

param=0;

%getparam_fig=gui_fl_getregparam;
%static=findobj(getparam_fig,'Tag','StaticText1');
%edit=findobj(getparam_fig,'Tag','EditText1');

%if varargin{1}==2
  %set(static,'String',['Weihted Least Square: Enter the weights vector of length ',num2str(varargin{2}),':']);
%end
%if varargin{1}==3
  %set(static,'String','Penalized Least Square:Enter the number of iterations:'); 
%end
current_cursor=fl_waiton;
while (param==0)
  uiwait(getparam_fig);
  input=get(edit,'String');
  if isempty(input)
    fl_warning('Regression Parameter must be initiated!');
  %elseif varargin{1}==3
    %param=floor(str2num(input));
    %param=max([param,0]);
  else
    if exist(input)
      eval(['global ',input,';']);
      eval(['param= ',input,'(:);']);
    else
      eval(['param= ',input,';'],'disp(lasterr);param=0;');
    end
    %if (length(param)~=varargin{2})
      %param=0;
      %fl_warning(['the weights vector must be of length ' ...
	   % ,num2str(varargin{2}),'!']);
    %end
  end
end
fl_waitoff(current_cursor);
close(getparam_fig);
paramOut{2}=param;




