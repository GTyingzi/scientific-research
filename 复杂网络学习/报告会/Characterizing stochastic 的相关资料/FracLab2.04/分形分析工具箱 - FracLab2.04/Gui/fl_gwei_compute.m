function [varargout]=fl_gwei_compute(varargin)

% Callback functions for Generalized Weierstrass GUI -
%	Generation Parameter Window.

% Last review Pierrick Legrand january 2005


Figgwei = gcf;
if ((isempty(Figgwei)) | (~strcmp(get(Figgwei,'Tag'),'Fig_gui_fl_gwei')))
    Figgwei = findobj ('Tag','Fig_gui_fl_gwei');
end

switch(varargin{1})

    %%%%% Creation functions for New Figures %%%%

    %%%%%% Function H callbacks %%%%%%%
    case 'edit_funch'

        func=get(gcbo,'String');
        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_sample');
        N = str2num(get(EditHandle,'String')) ;
        t = linspace(0,1,N) ;
        Ht = eval(func) ;
        %Modif L-infinity error
        obj=findobj(Figgwei,'Tag','EditText_gwei_lambda');
        lambda = str2num(get(obj,'String')) ;
        lambda = max(0,lambda);
        eps=abs(min(Ht));
        obj=findobj(Figgwei,'Tag','EditText_gwei_kmax');
        kmax = get(obj,'String');
        kmax=str2num(kmax);warning off;
        Linfinity=lambda^(-(kmax+1)*eps)/(1-lambda^(-eps));warning backtrace;
        %     sth=findobj('Tag','StaticText_Linfinity');
        %     set(sth,'String',['Linfinity error order = ' num2str(Linfinity)]);
        %     set(sth,'Visible','on');
        fl_warning(['Linfinity error = ' num2str(Linfinity)],'black','')
        %%%%%%%%%%%%%%%%%%%%%%

    case 'ppm_funch'
        ppmValue=get(gcbo,'Value');
        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_sample');
        N = str2num(get(EditHandle,'String')) ;
        t = linspace(0,1,N) ;
        switch ppmValue
            case 1, 	Ht = [ones(1,N/2)*0.2 ones(1,N/2)*0.8] ;
                EditHandle=findobj(Figgwei,'Tag','EditText_gwei_funch');
                set(EditHandle,'String', ...
                    '[ones(1,N/2)*0.2 ones(1,N/2)*0.8]') ;
            case 2, 	Ht = linspace(0,1,N) ;
                EditHandle=findobj(Figgwei,'Tag','EditText_gwei_funch');
                set(EditHandle,'String', ...
                    't') ;
            case 3, 	EditHandle=findobj(Figgwei,'Tag','EditText_gwei_funch');
                set(EditHandle,'String','example: abs(sin(10*t)), then press RETURN') ;
        end


        %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
    case 'edit_sample'
        EditValue=str2num(get(gcbo,'String'));
        EditValue=floor(EditValue);
        EditValue=trunc(EditValue,1.0,Inf);
        set(gcbo,'String',EditValue);
    case 'ppm_sample'
        NSample=2^(get(gcbo,'Value')+2);
        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_sample');
        set(EditHandle,'String',NSample);


        %%%%%%%%%% lambda callbacks %%%%%%%%%%%%%%%%
    case 'edit_lambda'
        lambda_value = str2num(get(gcbo,'String')) ;
        lambda_value = max(0,lambda_value) ;
        if lambda_value == 1
            lambda_value = 2 ;
            fl_warning('Lambda = 1 is not allowed') ;
        end
        set(gcbo,'String',num2str(lambda_value)) ;
        %Modif L-infinity error
        obj=findobj(Figgwei,'Tag','EditText_gwei_funch');
        func=get(obj,'String');
        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_sample');
        N = str2num(get(EditHandle,'String')) ;
        t = linspace(0,1,N) ;
        Ht = eval(func) ;
        obj=findobj(Figgwei,'Tag','EditText_gwei_lambda');
        lambda = str2num(get(obj,'String')) ;
        lambda = max(0,lambda);
        eps=abs(min(Ht));
        obj=findobj(Figgwei,'Tag','EditText_gwei_kmax');
        kmax = get(obj,'String');
        kmax=str2num(kmax);warning off;
        Linfinity=lambda^(-(kmax+1)*eps)/(1-lambda^(-eps));warning backtrace;
        %     sth=findobj('Tag','StaticText_Linfinity');
        %     set(sth,'String',['Linfinity error order = ' num2str(Linfinity)]);
        %     set(sth,'Visible','on');
        fl_warning(['Linfinity error = ' num2str(Linfinity)],'black','')
        %%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%% kmax callbacks %%%%%%%%%%%%%%%%
    case 'edit_kmax'
        kmax_value = get(gcbo,'String') ;
        if isempty(str2num(kmax_value))
            set(gcbo,'String','50')
        else
            kmax_value = str2num(kmax_value) ;
            set(gcbo,'String',num2str(kmax_value)) ;
        end
        %Modif L-infinity error
        obj=findobj(Figgwei,'Tag','EditText_gwei_funch');
        func=get(obj,'String');
        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_sample');
        N = str2num(get(EditHandle,'String')) ;
        t = linspace(0,1,N) ;
        Ht = eval(func) ;
        obj=findobj(Figgwei,'Tag','EditText_gwei_lambda');
        lambda = str2num(get(obj,'String')) ;
        lambda = max(0,lambda);
        eps=abs(min(Ht));
        obj=findobj(Figgwei,'Tag','EditText_gwei_kmax');
        kmax = get(obj,'String');
        kmax=str2num(kmax);warning off;
        Linfinity=lambda^(-(kmax+1)*eps)/(1-lambda^(-eps));warning backtrace;
        %     sth=findobj('Tag','StaticText_Linfinity');
        %     set(sth,'String',['Linfinity error order = ' num2str(Linfinity)]);
        %     set(sth,'Visible','on');
        fl_warning(['Linfinity error = ' num2str(Linfinity)],'black','')
        %%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%% Nyquiest callbacks %%%%%%%%%%%%%%%%
        %   case 'nyquiest'
        %     nyquiest_value = get(gcbo,'Value') ;
        %     if nyquiest_value == 1
        %        N_tmp=get(findobj('Tag','EditText_sample'),'String');
        %       N_tmp=str2num(N_tmp);
        %       tmax_tmp=get(findobj('tag','EditText_gwei_tmax'),'String');
        %       tmax_tmp=str2num(tmax_tmp);
        %       l_tmp=get(findobj('tag','EditText_gwei_lambda'),'String');
        %       l_tmp=str2num(l_tmp);
        %       nyq = floor(log(N_tmp/(2*tmax_tmp))/log(l_tmp)) ;
        %       aff_nyq=['Default : ', num2str(nyq)];
        %       set(findobj('tag','EditText_gwei_kmax'),'String',aff_nyq);
        %     else
        %       set(findobj('tag','EditText_gwei_kmax'),'String','50');
        %       set(findobj('tag','EditText_gwei_kmax'),'enable','on');
        %     end

        %%%%%%%%%% tmax callbacks %%%%%%%%%%%%%%%%
    case 'edit_tmax'
        tmax_value = str2num(get(gcbo,'String')) ;
        tmax_value = max(0,tmax_value) ;
        set(gcbo,'String',num2str(tmax_value)) ;


        %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
    case 'compute'

        current_cursor=fl_waiton;

        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_funch');
        func = get(EditHandle,'String') ;
        EditHandle=findobj(Figgwei,'Tag','EditText_gwei_sample');
        N = str2num(get(EditHandle,'String')) ;
        t = linspace(0,1,N) ;

        BadFormat = 0 ;
        eval([func ,';'],'BadFormat = 1 ; ') ;
        if BadFormat ,
            fl_error('Bad Function Format! Use H(t) = t,  instead') ;
            Ht = t ;
        elseif ~BadFormat ,
            Ht = eval(func) ;
        end

        randflag = get(Figgwei,'UserData') ;
        obj=findobj(Figgwei,'Tag','EditText_gwei_lambda');
        lambda = str2num(get(obj,'String')) ;
        lambda = max(0,lambda) ;
        set(obj,'String',num2str(lambda)) ;
        obj=findobj(Figgwei,'Tag','EditText_gwei_tmax');
        tmax = str2num(get(obj,'String')) ;
        tmax = max(0,tmax) ;
        set(obj,'String',num2str(tmax)) ;
        obj=findobj(Figgwei,'Tag','EditText_gwei_kmax');
        kmax = get(obj,'String') ;

        varname = fl_findname('GWei',varargin{2}) ;
        graphname = [ 'Graph'  varname];
        varargout{1}=varname ;
        varargout{2}=graphname ;

        eval(['global ' varname]);
        eval(['global ' graphname]);

        if isempty(str2num(kmax))
            theWei=GeneWei(N,Ht,lambda,tmax,randflag);
            chaine_temp=['=GeneWei(',num2str(N),',''',func,''',',...
                num2str(lambda),',',num2str(tmax),',',num2str(randflag),');'];
        else
            kmax = str2num(kmax) ;
            theWei=GeneWei(N,Ht,lambda,tmax,randflag,kmax);
             chaine_temp=['=GeneWei(',num2str(N),',''',func,''',',...
                num2str(lambda),',',num2str(tmax),',',...
                num2str(randflag),',',num2str(kmax),');'];
        end
        theTime = linspace(0,tmax,N);
        if randflag==1
            type = 'Stochastic ';
        else
            type = '';
        end;

        eval([graphname '= struct (''type'',''graph'', ''data1'',theTime,  ''data2'',theWei, ''title'',[type ''Generalized Weierstrass Function''], ''xlabel'',''t'', ''ylabel'','' ''); ']);
        eval([varname '= theWei; ']);
        
        chaine=[varname chaine_temp];
        fl_diary(chaine);
        
        fl_addlist(0,varname) ;
        %fl_addlist(0,graphname) ;
        %Modif L-infinity error
        eps=abs(min(Ht));warning off;
        Linfinity=lambda^(-(kmax+1)*eps)/(1-lambda^(-eps));warning backtrace;
        %      sth=findobj('Tag','StaticText_Linfinity');
        %      set(sth,'String',['Linfinity error order = ' num2str(Linfinity)]);
        %      set(sth,'Visible','on');

        fl_warning(['Linfinity error = ' num2str(Linfinity)],'black','')

        fl_waitoff(current_cursor);

    case 'help'

        helpwin GeneWei


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
