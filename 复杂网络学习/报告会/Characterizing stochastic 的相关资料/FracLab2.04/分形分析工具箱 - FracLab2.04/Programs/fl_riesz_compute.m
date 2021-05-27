function [varargout]=fl_riesz_compute(varargin)

% Callback function for Generalized Riesz Products GUI
%
%
%
%
%
%
% 2.1 Legendre Spectrum
%     Non positive functions are not covered by the theory. Use at your own risk !
%
% Revision 1.3 O.Meunier, INRIA, Fractales, 4 April 2002

%load gui_fl_riesz;
S=which('gui_fl_riesz.mat');
load(S);
fl_clearerror;

switch(varargin{1})        
      
    case 'slider_base'
        b=get(gcbo,'Value');
        b = round(b);
        ws.b = b;
        set(gcbo, 'Value', b);
		set(findobj('Tag','EditText_riesz_base'),'String',num2str(b));
		set(findobj('Tag','EditText_riesz_rf'),'String',num2str(b*ws.N));
        check_all(ws);
        
    case 'edit_base'
        b = str2num(get(gcbo, 'String'));
        if b < ws.b_min, b = ws.b_min; end
        if b > ws.b_max, b = ws.b_max; end
        ws.b = b;
        set(gcbo, 'String', num2str(b));
        set(findobj('Tag','Slider_riesz_base'), 'Value', b);
		set(findobj('Tag','EditText_riesz_rf'),'String',num2str(b*ws.N));
        check_all(ws);
        
    case 'slider_order'
        K=get(gcbo,'Value');
        K = round(K);
        ws.K = K;
        set(gcbo, 'Value', K);
		set(findobj('Tag','EditText_riesz_order'),'String',num2str(K));
        check_all(ws);
        
    case 'edit_order'
        K = str2num(get(gcbo, 'String'));
        if K < ws.K_min, K = ws.K_min; end
        if K > ws.K_max, K = ws.K_max; end
        ws.K = K;
        set(gcbo, 'String', num2str(K));
        set(findobj('Tag','Slider_riesz_order'), 'Value', K);
        check_all(ws);

    case 'slider_depth'
        N=get(gcbo,'Value');
        N = round(N);
        ws.N = N;
        set(gcbo, 'Value', N);
		set(findobj('Tag','EditText_riesz_res'),'String',num2str(N));
		set(findobj('Tag','EditText_riesz_rf'),'String',num2str(ws.b*N));
        check_all(ws);
        
    case 'edit_depth'
        N = str2num(get(gcbo, 'String'));
        if N < ws.N_min, N = ws.N_min; end
        if N > ws.N_max, N = ws.N_max; end
        ws.N = N;
        set(gcbo, 'String', num2str(N));
        set(findobj('Tag','Slider_riesz_res'), 'Value', N);
        set(findobj('Tag','EditText_riesz_rf'),'String',num2str(ws.b*N));
        check_all(ws);

        
    case 'edit_function'
        x = rand(5,5);
        func = get(h,'String');
        try
            eval(['y=' func ';'])
            x+y;
            ws.func = func;
        catch
            fl_warning('Invalid function syntax. See samples.')
        end

        
    case 'listbox_function'
        s=get(gcbo,'String');
        n=get(gcbo,'Value');
        set(findobj('Tag', 'EditText_riesz_function'), 'String',  s{n})
        ws.func = s{n};
        
    case 'check_spectrum'
        if 0 == check_all(ws) return; end
        if get(gcbo,'Value') == 1
            set(findobj('Tag','Checkbox_riesz_tauq'),'Enable','on')
        else
            set(findobj('Tag','Checkbox_riesz_tauq'),'Enable','off')
        end
            

    case 'compute'
        if 0 == check_all(ws), return; end
        current_cursor=fl_waiton;
        no_phase = get(findobj('Tag','Checkbox_riesz_no_phase'),'Value');
        keep_phase = get(findobj('Tag','Checkbox_riesz_keep_phase'),'Value');
        Nxb = ws.N * ws.b;
        z = [];
        Z = [];
        z = zeros(1,Nxb);
        % Variables used by calc_riesz_int
        if no_phase == 1
            z = calc_riesz_int(ws.func, ws.K, ws.N, ws.b, zeros(ws.K,1));
        else
            if keep_phase == 0
                ws.phase = rand(ws.K_max,1);
            end
            z = calc_riesz_int(ws.func, ws.K, ws.N, ws.b, ws.phase(1:ws.K));
        end
        Z = z(Nxb);
        %Normalisation
        z = z./Z;
        varname = fl_findname('Riesz',varargin{2});
        varargout{1} = varname;
        eval(['global ' varname]);
        eval([varname '= z; ']);
        fl_addlist(0,varname);
        
        %Compute Spectrum
        if get(findobj('Tag','Checkbox_riesz_spectrum'),'Value') == 1
            %Check that the function does not take zero values
            x = (0:Nxb)./Nxb;
            eval(['y = ' ws.func ';'])
            zval=find(y == 0);
            if ~isempty(zval)
                msg ='Function takes zero values on [0;1]: results are unpredictable.';
                set(findobj('Tag','StaticText_error'),'String',msg);
            end
            %Computation of spectrum
            if no_phase == 1
                [u,s,tauq,q]=calc_riesz_spec(ws.func, ws.K, ws.N, ws.b, zeros(ws.K,1));
            else
                [u,s,tauq,q]=calc_riesz_spec(ws.func, ws.K, ws.N, ws.b, ws.phase(1:ws.K));
            end
            graphname = [ 'GraphSpec'  varname];
            varargout{2} = graphname;
            eval(['global ' graphname]);
            eval([graphname '= struct (''type'',''graph'', ''data1'',s,  ''data2'',u, ''title'',''Riesz Product Multifractal Spectrum'', ''xlabel'',''Exponent \alpha'', ''ylabel'',''F(\alpha)''); ']);
            fl_addlist(0,graphname);
            if get(findobj('Tag','Checkbox_riesz_tauq'),'Value') == 1 %Trace de tau(q)
                graphname = [ 'GraphTauq'  varname];
                varargout{3} = graphname;
                eval(['global ' graphname]);
                eval([graphname '= struct (''type'',''graph'', ''data1'',q,  ''data2'',tauq, ''title'',''Riesz Product - \tau(q)'', ''xlabel'',''q'', ''ylabel'',''\tau(q)''); ']);
                fl_addlist(0,graphname);
            end
        end
        fl_waitoff(current_cursor);

        
    case 'close'
        close(findobj('Tag','Fig_gui_fl_riesz'));
        fl_clearerror;
                
    case 'help'
        helpwin fl_riesz_compute

end

save(S, 'mat0', 'ws')


function ret=check_all(ws)
Nxb_max_spec = 20000;
K_max_spec = 50;
ret = 1;
if get(findobj('Tag','Checkbox_riesz_spectrum'),'Value') == 1
    %K
    if ws.K > K_max_spec
        fl_warning(sprintf('Decrease order under %i to compute spectrum.',K_max_spec))
        ret = 0;
    end
    %Nxb
    if ws.N*ws.b > Nxb_max_spec
        fl_warning(sprintf('Decrease resolution under %i to compute spectrum.',Nxb_max_spec))
        ret = 0;
    end
    if 0 == ret
        set(findobj('Tag','Checkbox_riesz_spectrum'),'Value', 0);
    end
else
    %K
    if ws.K > ws.K_max
        fl_warning(sprintf('Decrease order under %i.',K_max_spec))
        ret = 0;
    end
    %N
    if ws.N > ws.N_max
        fl_warning(sprintf('Decrease depth under %i.',ws.N_max))
        ret = 0;
    end    
    if ws.b > ws.b_max
        fl_warning(sprintf('Decrease base under %i.',ws.b_max))
        ret = 0;
    end    
end


