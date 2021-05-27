function [varargout]=fl_shrinkden2_compute(varargin)


% Callback function for multifractal denoising GUI
% fl_shrinkden2_compute
% Author : Pierrick Legrand
%
% September , 19th 2002
% Modification P. Legrand, January 2005.
%
% 1D and 2D Denoising by wavelet shrinkage.
%
%
%
%
%   1.  Usage of the corresponding command:
%
%
%       [wtout] = frac_shrinkden(in, trshld, level, wavelet, siz, mode)
%       [wtout] = frac_shrinkden2D(in, trshld, level, wavelet, siz, mode)
%
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
%   o  Treshold Factor : edit or slider
%      This parameter displays the value of the threshold .
%
%   o  Level : This is the level where we start the computation.
%      When level equal 1, all the level of the wavelet decomposition are
%      modified.
%
%   o  wavelet : wavelet used to perform the computation.
%
%   o  Soft/Hard : Soft or hard thresholding.
%
%
%   2.2.  Computation
%
%
%   o  Compute :  PushButton.
%      Computes the  Wavelet Shrinkage of the input signal
%      depending on the choice in the edit or slider menu.
%      It calls the  routines frac_shrinkden.m if the input signal is a vector
%      or frac_shrinkden2D.m if it's a matrix.
%
%   o  Help : PushButton.
%      Calls this help.
%
%   o  Close : PushButton.
%      Closes the Wavelet Shrinkage figure and returns
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
            alpha=0.5;
            set(gcbo,'String','0.5');
        else
            alpha=trunc(alpha,0,inf);
            set(gcbo,'String',alpha);
            if alpha<=1 & alpha>=0
                set(findobj('Tag','Slider_shrinkden2_alphashift'),'Value',alpha);
            end
        end;
    case 'slider_alphashift'
        fl_clearerror;
        alpha=get(gcbo,'Value');
        EditHandle=findobj('Tag','EditText_shrinkden2_alphashift');
        set(EditHandle,'String',alpha);



    case 'radiobutton_univ'

        fl_clearerror;
        univ = get(gcbo,'Value') ;
        if univ == 1
            marqueur= get(gcbo,'Value') ;
            set(gcbo,'String','Specify') ;
            set(findobj('Tag','Slider_shrinkden2_alphashift'),'enable','on');
            set(findobj('Tag','EditText_shrinkden2_alphashift'),'enable','on');
            %%set(findobj(dreg_fig,'Tag','Radiobutton_dreg2'),'value',0);
            %set(findobj(dreg_fig,'Tag','EditText_multden3_lambdashift'),'Position',[0.78 0.33+0.12 0.001 0.001]);
            %set(findobj(dreg_fig,'Tag','StaticText_multden3_lambdashift'),'String',' ');
        elseif univ == 0
            marqueur= get(gcbo,'Value') ;
            set(gcbo,'String','Universal threshold') ;
            set(findobj('Tag','Slider_shrinkden2_alphashift'),'enable','off');
            set(findobj('Tag','EditText_shrinkden2_alphashift'),'enable','off');
            %%set(findobj(dreg_fig,'Tag','Radiobutton_dreg2'),'value',1);
            %set(findobj(dreg_fig,'Tag','EditText_dreg_param3'),'Position',[0.78 0.27+0.12 0.12 0.06],'enable','inactive');
            %set(findobj(dreg_fig,'Tag','StaticText_dreg_param3'),'String','Estimated Standard Deviation');
        end



    case 'edit_level'
        [SigIn_name error_in] = fl_get_input ('vector') ;
        eval(['global ' SigIn_name]) ;
        SigIn = eval(SigIn_name) ;
        N = length(SigIn) ;
        fl_clearerror;
        level=str2num(get(gcbo,'String'));
        if isempty(level) | level<1 | level > log2(N)
            fl_warning('Level is an integer >1 and <log2(length(signal))!');
            pause(.3);
            level=(ceil(log2(N)/2));
            set(gcbo,'String',num2str(level));
        else
            level=floor(level);
            set(gcbo,'String',num2str(level));;
        end

    case 'mode'
        fl_clearerror;
        mode=get(gcbo,'Value');
        if mode==1
            set(gcbo,'String','Hard Thresholding');
        else
            set(gcbo,'String','Soft Thresholding');
        end;

        %% "Compute" callbacks
    case 'compute'
        p=fl_waiton;

        %%%%% First get the input %%%%%%
        fl_clearerror;
        InputName=get(findobj('Tag','EditText_sig_nname_shrinkden2'),'String');
        if isempty(InputName)
            fl_warning('Input signal must be initiated: Refresh!');
            fl_waitoff(p);
        else
            eval(['global ' InputName]);
        end;

        %     obj=findobj('Tag','EditText_shrinkden2_alphashift');
        %     alpha=str2num(get(obj,'String'));

        obj=findobj('Tag','EditText_shrinkden2_level');
        niveau=str2num(get(obj,'String'));

        obj=findobj('Tag','Check_shrinkden2_mode');
        valmode=(get(obj,'Value'));
        if valmode==1
            mode='hard';
        else
            mode='soft';
        end;


        obj=findobj('Tag','Radiobutton_univ');
        univ=(get(obj,'Value'));

        if univ==1
            obj=findobj('Tag','EditText_shrinkden2_alphashift');
            alpha=str2num(get(obj,'String'));
        else
            alpha=[];
        end


        %     obj=findobj('Tag','PopupMenu_shrinkden2_wtype');
        %     ond1=(get(obj,'String'))
        %     whos ond1
        %     ond2=(get(obj,'Value'))
        %     ond1{5}
        %%%%%
        ondelette=(get(findobj('Tag','PopupMenu_shrinkden2_wtype'),'String'));
        type=get(findobj('Tag','PopupMenu_shrinkden2_wtype'),'Value');
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
        %%%%%

        OutputName=['Sden_' InputName];
        varname = fl_findname(OutputName,varargin{2});

        varargout{1}=varname;
        eval(['global ' varname]);
        eval(['global ' InputName])
        % is it a vector or a matrix ?
        eval(['szmin=min(min(size(' InputName ')));']);
        if (szmin==1)
            eval([varname '=frac_shrinkden(' InputName ',alpha,niveau,type_ond,siz1,mode);']);

            if ~isempty(num2str(alpha))
                chaine=[varname '=frac_shrinkden(',InputName,',',num2str(alpha),','...
                    ,num2str(niveau),',''',type_ond,''',',...
                    num2str(siz1),',''',mode,''');'];
            else
                chaine=[varname '=frac_shrinkden(',InputName,',[],'...
                    ,num2str(niveau),',''',type_ond,''',',...
                    num2str(siz1),',''',mode,''');'];
            end
        else
            eval([varname '=frac_shrinkden2D(' InputName ',alpha,niveau,type_ond,siz1,mode);']);
            if ~isempty(num2str(alpha))
                chaine=[varname '=frac_shrinkden2D(',InputName,',',num2str(alpha),','...
                    ,num2str(niveau),',''',type_ond,''',',...
                    num2str(siz1),',''',mode,''');'];
            else
                chaine=[varname '=frac_shrinkden2D(',InputName,',[],'...
                    ,num2str(niveau),',''',type_ond,''',',...
                    num2str(siz1),',''',mode,''');'];
            end
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
            set(findobj('Tag','EditText_sig_nname_shrinkden2'), ...
                'String',inputName);
            [SigIn_name error_in] = fl_get_input ('vector') ;
            eval(['global ' SigIn_name]) ;
            SigIn = eval(SigIn_name) ;
            N = length(SigIn) ;
            level=num2str(ceil(log2(N)/2));
            set(findobj('Tag','EditText_shrinkden2_level'), ...
                'String',level);
        end;

    case 'help'
        helpwin('fl_shrinkden2_compute');



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



