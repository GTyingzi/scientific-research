function [varargout]=fl_multden3_compute(varargin)

% Callback function for Non linear Pumping GUI
% fl_multden3_compute
% Author : Pierrick Legrand
%
% July , 20th 2004
% Modification P. Legrand, January 2005.
%
% 1D and 2D Multifractal Denoising by  non linear multifractal method.
%
%
%
%
%   1.  Usage of the corresponding command:
%
%
%       [out] = frac_NLmultden(in, param, trshld, level, wavelet, siz, mode )
%       [out] = frac_NLmultden2D(in, param, trshld, level, wavelet, siz, mode )
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
%   o  Spectrum Shift Value : edit or slider
%      This parameter displays the increasing of the spectrum value.
%
%   o  Level : This is the level where we start the computation.
%      When level equal 1, all the level of the wavelet decomposition are
%      modified.
%
%   o  wavelet : wavelet used to perform the computation.
%
%
%   2.2.  Computation
%
%
%   o  Compute :  PushButton.
%      Computes the  Multifractal Denoising of the input signal
%      depending on the choice in the edit or slider menu.
%      It calls the  routines frac_multden.m if the input signal is a vector
%      or frac_multden2D.m if it's a matrix.
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
            alpha=0.5;
            set(gcbo,'String','0.5');
        else
            alpha=trunc(alpha,-inf,inf);
            set(gcbo,'String',alpha);
            if alpha<=1 & alpha>=-1
                set(findobj('Tag','Slider_multden3_alphashift'),'Value',alpha);
            end
        end;
    case 'slider_alphashift'
        fl_clearerror;
        alpha=get(gcbo,'Value');
        EditHandle=findobj('Tag','EditText_multden3_alphashift');
        set(EditHandle,'String',alpha);


    case 'edit_lambdashift'
        fl_clearerror;
        lambda=str2num(get(gcbo,'String'));
        if isempty(lambda)
            fl_warning('Threshold must be a positive real !');
            pause(.3);
            lambda=0.5;
            set(gcbo,'String','0.5');
        else
            lambda=trunc(lambda,-inf,inf);
            set(gcbo,'String',lambda);
            if lambda<=1 & lambda>=0
                set(findobj('Tag','Slider_multden3_lambdashift'),'Value',lambda);
            end
        end;
    case 'slider_lambdashift'
        fl_clearerror;
        lambda=get(gcbo,'Value');
        EditHandle=findobj('Tag','EditText_multden3_lambdashift');
        set(EditHandle,'String',lambda);


    case 'radiobutton_univ'

        fl_clearerror;
        univ = get(gcbo,'Value');
        if univ == 1
            marqueur= get(gcbo,'Value') ;
            set(gcbo,'String','Specify') ;
            set(findobj('Tag','Slider_multden3_lambdashift'),'enable','on');
            set(findobj('Tag','EditText_multden3_lambdashift'),'enable','on');
            %%set(findobj(dreg_fig,'Tag','Radiobutton_dreg2'),'value',0);
            %set(findobj(dreg_fig,'Tag','EditText_multden3_lambdashift'),'Position',[0.78 0.33+0.12 0.001 0.001]);
            %set(findobj(dreg_fig,'Tag','StaticText_multden3_lambdashift'),'String',' ');
        elseif univ == 0
            marqueur= get(gcbo,'Value') ;
            set(gcbo,'String','Automatic Universal threshold') ;
            set(findobj('Tag','Slider_multden3_lambdashift'),'enable','off');
            set(findobj('Tag','EditText_multden3_lambdashift'),'enable','off');
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
            start_level=(ceil(log2(N)/3));
            set(gcbo,'String',num2str(start_level));
        else
            start_level=floor(level);
            set(gcbo,'String',num2str(level));
        end

        %% "Compute" callbacks
    case 'compute'
        p=fl_waiton;

        %%%%% First get the input %%%%%%
        fl_clearerror;
        InputName=get(findobj('Tag','EditText_sig_nname_multden3'),'String');
        if isempty(InputName)
            fl_warning('Input signal must be initiated: Refresh!');
            fl_waitoff(p);
        else
            eval(['global ' InputName]);
        end;

        obj=findobj('Tag','EditText_multden3_alphashift');
        alpha=str2num(get(obj,'String'));


        obj=findobj('Tag','Radiobutton_univNLP');
        univ=(get(obj,'Value'));

        if univ==1
            obj=findobj('Tag','EditText_multden3_lambdashift');
            lambda=str2num(get(obj,'String'));
        else
            lambda=[];
        end

        obj=findobj('Tag','EditText_multden3_level');
        start_level=str2num(get(obj,'String'));

        %     obj=findobj('Tag','PopupMenu_multden3_wtype');
        %     ond1=(get(obj,'String'))
        %     whos ond1
        %     ond2=(get(obj,'Value'))
        %     ond1{5}
        %%%%%
        ondelette=(get(findobj('Tag','PopupMenu_multden3_wtype'),'String'));
        type=get(findobj('Tag','PopupMenu_multden3_wtype'),'Value');
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

        OutputName=['NLPden_' InputName];
        varname = fl_findname(OutputName,varargin{2});

        varargout{1}=varname;
        eval(['global ' varname]);
        eval(['global ' InputName])
        % is it a vector or a matrix ?
        eval(['szmin=min(min(size(' InputName ')));']);
        if (szmin==1)
            eval([varname '=frac_NLmultden(' InputName ',alpha, lambda,type_ond,siz1,start_level);']);
            if ~isempty(num2str(lambda))
                chaine=[varname '=frac_NLmultden(',InputName,',',num2str(alpha),','...
                    ,num2str(lambda),',''',type_ond,''',',...
                    num2str(siz1),',',num2str(start_level),');'];
            else
                chaine=[varname '=frac_NLmultden(',InputName,',',num2str(alpha),',[],''',type_ond,''',',...
                    num2str(siz1),',',num2str(start_level),');'];
            end

        else
            eval([varname '=frac_NLmultden2D(' InputName ',alpha,lambda,type_ond,siz1,start_level);']);
            if ~isempty(num2str(lambda))
                chaine=[varname '=frac_NLmultden2D(',InputName,',',num2str(alpha),','...
                    ,num2str(lambda),',''',type_ond,''',',...
                    num2str(siz1),',',num2str(start_level),');'];
            else
                chaine=[varname '=frac_NLmultden2D(',InputName,',',num2str(alpha),',[],''',type_ond,''',',...
                    num2str(siz1),',',num2str(start_level),');'];
            end
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
            set(findobj('Tag','EditText_sig_nname_multden3'), ...
                'String',inputName);
            [SigIn_name error_in] = fl_get_input ('vector') ;
            eval(['global ' SigIn_name]) ;
            SigIn = eval(SigIn_name) ;
            N = length(SigIn) ;
            level=num2str(ceil(log2(N)/3));
            set(findobj('Tag','EditText_multden3_level'), ...
                'String',level);
        end;

    case 'help'
        helpwin('fl_multden3_compute');



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



