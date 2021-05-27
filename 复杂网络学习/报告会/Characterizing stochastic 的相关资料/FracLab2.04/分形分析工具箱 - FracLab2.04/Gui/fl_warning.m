function fl_warning(string,ForegroundColor,Prefix)
%		FRACLAB function
%
% Usage: fl_warning(string,ForegroundColor)
%
% Print the string "string" on the StaticText dedicated to error messages.

sth=findobj('Tag','StaticText_error');
if isempty(sth); sth=findobj(findobj('Tag','FRACLAB Toolbox'),'Tag','StaticText_error'); end

if nargin<3;Prefix='Error : ';end
if nargin<2;ForegroundColor=[];end
if isempty(ForegroundColor);ForegroundColor=[1 0 0];end

if ischar(ForegroundColor)
    switch(ForegroundColor)
    case 'black'
        set(sth,'ForegroundColor',[0 0 0]);
    case 'white'
        set(sth,'ForegroundColor',[1 1 1]);
    case 'red'
        set(sth,'ForegroundColor',[1 0 0]);
    case 'green'
        set(sth,'ForegroundColor',[0 1 0]);
    case 'blue'
        set(sth,'ForegroundColor',[0 0 1]);
    otherwise
        Warning('Unknown ForeGroundColor Option')
        set(sth,'ForegroundColor',[0 0 0]);
    end
else
    set(sth,'ForegroundColor',ForegroundColor);
end

set(sth,'String',[Prefix,string]);

%No more beeps for a simple warning if it's not an error
if strcmp(Prefix,'Error : ')
    beep;
end
