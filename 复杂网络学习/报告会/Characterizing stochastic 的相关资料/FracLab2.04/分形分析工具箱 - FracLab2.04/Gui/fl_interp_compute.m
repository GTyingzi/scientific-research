function [varargout]=fl_interp_compute(varargin)


% Callback function for Hölderian Interpolation GUI
% fl_interp_compute
% Pierrick Legrand
% January , 6th 2005
%



switch(varargin{1})

    %% Multiplication param editing
    case 'edit_param'
        fl_clearerror;
        alpha=str2num(get(gcbo,'String'));
        if isempty(alpha)
            fl_warning('Number of interpolation must be an integer !');
            pause(.3);
            alpha=1;
            set(gcbo,'String','1');
        else
            alpha=floor(abs(alpha));
            if alpha==0;
                alpha=1;
            end
            set(gcbo,'String',num2str(alpha));
            if alpha>3
                fl_error('More than 3 interpolation will take a long time')
            end;
        end;

        
        
        
        case 'edit_param_debut'
        fl_clearerror;
        debut=str2num(get(gcbo,'String'));
        if isempty(debut)
            fl_warning('Give a start level higher than 2 !');
            pause(.3);
            debut=2;
            set(gcbo,'String','2');
        else
            debut=floor(abs(debut));
            if debut<=1;
                fl_error('Give a start level higher than 2 !');
                pause(.3);
                debut=2;
            end
            set(gcbo,'String',num2str(debut));
            fin=get(findobj('Tag','EditText_interp_param_fin'),'String');
            fin=str2num(fin);
            if debut>=fin
                fl_error('Give a start level lower than end level !')
                pause(.3);
                debut=2;
            end
            set(gcbo,'String',num2str(debut));
          
        end;

        
        
        case 'edit_param_fin'
        fl_clearerror;
        fin=str2num(get(gcbo,'String'));
        
        
        [inputName flag_error]=fl_get_input('matrix');
        if flag_error
            fl_warning('Invalid: input signal must be a matrix !');
        else
            eval(['global ' inputName]);
            SigIn = eval(inputName) ;
            [N M] = size(SigIn) ;
            L=max(N,M);
            default_max=floor(log2(L));
        end
        
        if isempty(fin)
            fl_error('Give an End level higher than Start Level !');
            pause(.3);
            fin=default_max;
            set(gcbo,'String',num2str(fin));
        else
            fin=floor(abs(fin));
            
            debut=get(findobj('Tag','EditText_interp_param_debut'),'String');
            debut=str2num(debut);
            
            if fin<=debut;
                fl_error('Give an End level higher than Start Level !');
                pause(.3);
                fin=default_max;
            end
            set(gcbo,'String',num2str(fin));
            
            if fin>default_max
                fl_error('Give an End Level lower than log2(N)')
                pause(.3);
                fin=default_max;
            end
            set(gcbo,'String',num2str(fin));
          
        end;
        
        
        % 	case 'slider_param'
        %       fl_clearerror;
        %       alpha=get(gcbo,'Value');
        % 		EditHandle=findobj('Tag','EditText_interp_param');
        % 		set(EditHandle,'String',alpha);


        %      case 'edit_level'
        %       [SigIn_name error_in] = fl_get_input ('vector') ;
        %       eval(['global ' SigIn_name]) ;
        %       SigIn = eval(SigIn_name) ;
        %       N = length(SigIn) ;
        %       fl_clearerror;
        %       level=str2num(get(gcbo,'String'));
        %        if isempty(level) | level<1 | level > log2(N)
        %          fl_warning('Level is an integer >1 and <log2(length(signal))!');
        %          pause(.3);
        %          level=(ceil(log2(N)/2));
        %          set(gcbo,'String',num2str(level));
        %        else
        %        level=floor(level);
        %        set(gcbo,'String',num2str(level));
        %    end




        %% "Compute" callbacks
    case 'compute'
        p=fl_waiton;
        %%%%% First get the input %%%%%%
        fl_clearerror;
        InputName=get(findobj('Tag','EditText_sig_nname_interp'),'String');
        if isempty(InputName)
            fl_warning('Input signal must be initiated: Refresh!');
            fl_waitoff(p);
        else
            eval(['global ' InputName]);
        end;


        obj=findobj('Tag','EditText_interp_param');
        alpha=str2num(get(obj,'String'));

        
        obj=findobj('Tag','EditText_interp_param_debut');
        debut=str2num(get(obj,'String'));
        
        obj=findobj('Tag','EditText_interp_param_fin');
        fin=str2num(get(obj,'String'));
        
        %     obj=findobj('Tag','EditText_interp_level');
        %     level=str2num(get(obj,'String'));


        ondelette=(get(findobj('Tag','PopupMenu_interp_wtype'),'String'));
        type=get(findobj('Tag','PopupMenu_interp_wtype'),'Value');
        siz1=0;
%         if (type>=11)&(type<15)
%             type_ond='coiflet';
%             siz=ondelette(type);
%             siz1=siz{1}(9:10);
%             siz1=str2num(siz1);
%         end;
%         if (type<11)
%             type_ond='daubechies';
%             siz=ondelette(type);
%             siz1=siz{1}(12:13);
%             siz1=str2num(siz1);
%         end;
        if type==1%5
            type_ond='Triangle';
        end


        OutputName=['interp_x',num2str(alpha),'_', InputName];
        varname = fl_findname(OutputName,varargin{2});

        varargout{1}=varname;
        eval(['global ' varname]);
        eval(['global ' InputName]);
        % is it a vector or a matrix ?
        eval(['szmin=min(min(size(' InputName ')));']);
        if (szmin==1)
            eval([varname '=fracinterp(' InputName...
                ',debut,fin,1,type_ond,alpha,siz1);']);
            chaine=[varname,'=fracinterp(',InputName,',',num2str(debut),',',...
                num2str(fin),',1,''',type_ond,''',',num2str(alpha),...
                ',',num2str(siz1),');'];
            fl_diary(chaine);
        
        else
            eval([varname '=fracinterp2d(' InputName ',debut,fin,1,type_ond,alpha,siz1);']);
            chaine=[varname,'=fracinterp2d(',InputName,',',num2str(debut),',',...
                num2str(fin),',1,''',type_ond,''',',num2str(alpha),...
                ',',num2str(siz1),');'];
            fl_diary(chaine);        
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
            SigIn = eval(inputName) ;
            [N M] = size(SigIn) ;
            L=max(N,M);
            default_min=2;
            default_max=floor(log2(L));
            set(findobj('Tag','EditText_interp_param_fin'), ...
                'String',num2str(default_max));
            set(findobj('Tag','EditText_interp_param_debut'), ...
                'String',num2str(default_min));

            %%%%%%%%%%%%%%% input frame %%%%%%%%%%%
            set(findobj('Tag','EditText_sig_nname_interp'), ...
                'String',inputName);
        end;

    case 'help'
        helpwin('fl_interp_compute');



end;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%% trunc %%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function o=trunc(i,a,b)
% if(i<a)
%   o=a;
% else
%   if(i>b)
%     o=b;
%   else
%     o=i;
%   end
% end
