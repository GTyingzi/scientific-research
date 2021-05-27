function [varargout]=fl_wei_compute(varargin)

% Callback functions for Weierstrass GUI - Generation Parameter Window.

% Modification P. Legrand, January 2005.

Figwei = gcf;
if ((isempty(Figwei)) | (~strcmp(get(Figwei,'Tag'),'Fig_gui_fl_wei')))
  Figwei = findobj('Tag','Fig_gui_fl_wei');
end

switch(varargin{1})
  
  %%%%% Creation functions for New Figures %%%%
  
  %%%%%% Initial H callbacks %%%%%%%
  case 'edit_inith'
    value=str2num(get(gcbo,'String'));
    value=trunc(value,0.0,1.0);
    set(gcbo,'String',value);
    set(findobj(Figwei,'Tag','Slider_inith'),'Value',value);
  case 'slider_inith'
    SliderValue=get(gcbo,'Value');
    EditHandle=findobj(Figwei,'Tag','EditText_inith');
    set(EditHandle,'String',SliderValue);
    
 
    %%%%%%%%%% Sample callbacks %%%%%%%%%%%%%%%
  case 'edit_sample'
    EditValue=str2num(get(gcbo,'String'));
    EditValue=floor(EditValue);
    EditValue=trunc(EditValue,1.0,Inf);
    set(gcbo,'String',EditValue);
    %%%%%%%%%%%%%%%
    nyquiest_value = get(findobj('Tag','Nyquist'),'Value');
    if nyquiest_value == 1
      N_tmp=get(findobj('Tag','EditText_sample'),'String');
      N_tmp=str2num(N_tmp);
      tmax_tmp=get(findobj('tag','EditText_wei_tmax'),'String');
      tmax_tmp=str2num(tmax_tmp);
      l_tmp=get(findobj('tag','EditText_wei_lambda'),'String');
      l_tmp=str2num(l_tmp);
      nyq = floor(log(N_tmp/(2*tmax_tmp))/log(l_tmp)) ;
      aff_nyq=['Default : ', num2str(nyq)];
      set(findobj('tag','EditText_wei_kmax'),'String',aff_nyq);
    end;  
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
  case 'ppm_sample'
    NSample=2^(get(gcbo,'Value')+2);
    EditHandle=findobj(Figwei,'Tag','EditText_sample');
    set(EditHandle,'String',NSample);
    %%%%%%%%%%%%%%%
    nyquiest_value = get(findobj('Tag','Nyquist'),'Value');
    if nyquiest_value == 1
      N_tmp=get(findobj('Tag','EditText_sample'),'String');
      N_tmp=str2num(N_tmp);
      tmax_tmp=get(findobj('tag','EditText_wei_tmax'),'String');
      tmax_tmp=str2num(tmax_tmp);
      l_tmp=get(findobj('tag','EditText_wei_lambda'),'String');
      l_tmp=str2num(l_tmp);
      nyq = floor(log(N_tmp/(2*tmax_tmp))/log(l_tmp)) ;
      aff_nyq=['Default : ', num2str(nyq)];
      set(findobj('tag','EditText_wei_kmax'),'String',aff_nyq);
    end;  
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%% lambda callbacks %%%%%%%%%%%%%%%%
  case 'edit_lambda'
    lambda_value = str2num(get(gcbo,'String')) ;
    lambda_value = max(0,lambda_value) ;
    if lambda_value == 1 
      lambda_value = 2 ;
      fl_warning('Lambda = 1 is not allowed') ;
    end
    set(gcbo,'String',num2str(lambda_value)) ;
    %%%%%%%%%%%%%%%
    nyquiest_value = get(findobj('Tag','Nyquist'),'Value');
    if nyquiest_value == 1
      N_tmp=get(findobj('Tag','EditText_sample'),'String');
      N_tmp=str2num(N_tmp);
      tmax_tmp=get(findobj('tag','EditText_wei_tmax'),'String');
      tmax_tmp=str2num(tmax_tmp);
      l_tmp=get(findobj('tag','EditText_wei_lambda'),'String');
      l_tmp=str2num(l_tmp);
      nyq = floor(log(N_tmp/(2*tmax_tmp))/log(l_tmp)) ;
      aff_nyq=['Default : ', num2str(nyq)];
      set(findobj('tag','EditText_wei_kmax'),'String',aff_nyq);
    end;  
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
  %%%%%%%%%% kmax callbacks %%%%%%%%%%%%%%%%
  case 'edit_kmax'
	kmax_value = get(gcbo,'String') ;
	if isempty(str2num(kmax_value))
	  set(gcbo,'String','50')
	else
	  kmax_value = str2num(kmax_value) ;
	  set(gcbo,'String',num2str(kmax_value)) ;
	end
	    
   
    
    %%%%%%%%%% tmax callbacks %%%%%%%%%%%%%%%%
  case 'edit_tmax'
    tmax_value = str2num(get(gcbo,'String')) ;
    tmax_value = max(0,tmax_value) ;
    set(gcbo,'String',num2str(tmax_value)) ;
    %%%%%%%%%%%%%%%
    nyquiest_value = get(findobj('Tag','Nyquist'),'Value');
    if nyquiest_value == 1
      N_tmp=get(findobj('Tag','EditText_sample'),'String');
      N_tmp=str2num(N_tmp);
      tmax_tmp=get(findobj('tag','EditText_wei_tmax'),'String');
      tmax_tmp=str2num(tmax_tmp);
      l_tmp=get(findobj('tag','EditText_wei_lambda'),'String');
      l_tmp=str2num(l_tmp);
      nyq = floor(log(N_tmp/(2*tmax_tmp))/log(l_tmp)) ;
      aff_nyq=['Default : ', num2str(nyq)];
      set(findobj('tag','EditText_wei_kmax'),'String',aff_nyq);
    end;  
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
      %%%%%%%%%% Nyquiest callbacks %%%%%%%%%%%%%%%%
  case 'nyquist'
    nyquiest_value = get(gcbo,'Value') ;
    if nyquiest_value == 1
      N_tmp=get(findobj('Tag','EditText_sample'),'String');
      N_tmp=str2num(N_tmp);
      tmax_tmp=get(findobj('tag','EditText_wei_tmax'),'String');
      tmax_tmp=str2num(tmax_tmp);
      l_tmp=get(findobj('tag','EditText_wei_lambda'),'String');
      l_tmp=str2num(l_tmp);
      nyq = floor(log(N_tmp/(2*tmax_tmp))/log(l_tmp)) ;
      aff_nyq=['Default : ', num2str(nyq)];
      set(findobj('tag','EditText_wei_kmax'),'String',aff_nyq);
      set(findobj('tag','EditText_wei_kmax'),'enable','off');
    else
      set(findobj('tag','EditText_wei_kmax'),'String','50');
      set(findobj('tag','EditText_wei_kmax'),'enable','on');
    end  

    %%%%%%%%% "Compute" callbacks %%%%%%%%%%%%%%%%%%%%%%
  case 'compute'
    
    current_cursor=fl_waiton;
    
    obj=findobj(Figwei,'Tag','EditText_inith');
    H=str2num(get(obj,'String'));
    obj=findobj(Figwei,'Tag','EditText_sample');
    N=str2num(get(obj,'String')) ;
    randflag = get(Figwei,'UserData') ;
    obj=findobj(Figwei,'Tag','EditText_wei_lambda') ;
    lambda = str2num(get(obj,'String')) ;
    lambda = max(0,lambda) ;
    if lambda==0; lambda=1;end;
    set(obj,'String',num2str(lambda)) ;
    obj=findobj(Figwei,'Tag','EditText_wei_tmax');
    tmax = str2num(get(obj,'String')) ;
    tmax = max(0,tmax) ;
    set(obj,'String',num2str(tmax)) ;
    obj=findobj(Figwei,'Tag','EditText_wei_kmax');
    kmax = get(obj,'String') ;
		
    varname = fl_findname('Wei',varargin{2});
    graphname = [ 'Graph'  varname];
    varargout{1}=varname ;
    varargout{2}=graphname ;
    
    eval(['global ' varname]);
    eval(['global ' graphname]);
    
    
    if isempty(str2num(kmax))
      theWei=GeneWei(N,H,lambda,tmax,randflag);
      chaine=['=GeneWei(',num2str(N),',',num2str(H),',',...
          num2str(lambda),',',num2str(tmax),',',num2str(randflag),');'];
      
    else
      kmax = str2num(kmax) ;
      theWei=GeneWei(N,H,lambda,tmax,randflag,kmax);
      chaine=['=GeneWei(',num2str(N),',',num2str(H),',',...
          num2str(lambda),',',num2str(tmax),',',num2str(randflag),...
          ',',num2str(kmax),');'];
     
    end
    theTime = linspace(0,tmax,N);
    if randflag==1
      type = 'Stochastic ';
    else
      type = '';
    end;
    eval([graphname '= struct (''type'',''graph'', ''data1'',theTime,  ''data2'',theWei, ''title'',[type ''Weierstrass Function''], ''xlabel'',''t'', ''ylabel'','' ''); ']);
    eval([varname '= theWei; ']);
    fl_addlist(0,varname) ;
    %fl_addlist(0,graphname) ;
    chaine=[varname,chaine];
    fl_diary(chaine);
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

