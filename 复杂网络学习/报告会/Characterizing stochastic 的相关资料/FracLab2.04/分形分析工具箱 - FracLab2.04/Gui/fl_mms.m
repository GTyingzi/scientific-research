%   fl_mms
%   Christophe Canus
%   March, 2nd 1998
%
%   Multifractal measures synthesis fltool Figure.
%
%
%
%   1.  UIcontrols
%
%   1.1.  Control parameters
%
%
%   o  resolution: strictly positive real (integer) scalar
%      It is initialized to n=7 (or to n=5 when 2d RadioButton is on) and
%      be changed by  selecting any particular value within bounds 1 and
%      n_max,  where  n_max is  such that the  resulting number of
%      intervals is not too big,  using the corresponding Slider or
%      directly by  editing the EditText.   The resulting number of
%      intervals is displayed  in  the subsequent StaticText.  When it  is
%      too big, an error message is displayed in the  message StaticText
%      of the main fltool Figure.
%
%   o  dimension: binary choice.
%      It is initialized to 1d RadioButton  on. When 2d RadioButton is on,
%      base y EditText and Slider are enabled.
%
%   o  base x: strictly positive real (integer) scalar.
%      It  is   initialized to  b_x=3  (or  to  b_x=2  when 2d RadioButton
%      is  on) and  can be  changed by  selecting  any particular value
%      within bounds  1 and 10.     The resulting number  of intervals  is
%      displayed in the preceeding  StaticText.  When it is too big, an
%      error message is  displayed in the message StaticText of the main
%      fltool Figure.
%
%   o  base y: strictly positive real (integer) scalar.
%      When 2d RadioButton  is on, it  is initialized to b_y=2  and can be
%      be changed by  selecting  any particular  value within bounds 1 and
%      10.  The resulting number of intervals is displayed in the
%      precceding StaticText.   When it is too  big, an error message  is
%      displayed in   the  message StaticText  of the   main fltool
%      Figure.
%
%   o  weights: strictly positive vector or matrix.
%      It is initialized to [.1 .3  .6] (or to  [.1 .2; .3 .4] when 2d
%      RadioButton is on) and can be changed to any particular vector of
%      length     b_x   (or    matrix   of    size  [b_xX b_y]). When the
%      vector length does not match to b_x (or when the matrix  size does
%      not match to[b_xX b_y]) , an error message is displayed  in the
%      message StaticText of the main fltool Figure.
%
%   o  deterministic - stochastic: binary choice.
%      It  is   initialized   to  deterministic  RadioButton  on.   When
%      stochastic  RadioButton   is  on,   canonical   CheckBox and
%      PopupMenu are enabled.
%
%   o  micro-canonical -  canonical: binary choice.
%
%      When  stochastic  RadioButton   is  on, it   is    initialized to
%      canonical CheckBox on.  In that case, canonical PopupMenu is
%      intialized to  'pertubated' and micro-canonical PopupMenu is
%      disabled.  It can be changed to  micro-canonical CheckBox on.  In
%      that case,   micro-canonical   PopupMenu     is  initialized to
%      'shuffled' and canonical PopupMenu is disabled.
%
%
%   o  micro-canonical: string.
%      When micro-canonical   CheckBox  is  on,  it    is    initialized
%      to 'shuffled' and can be  changed to 'stratified', using the
%      corresponding PopupMenu.
%
%   o  canonical: string.
%      When  canonical   CheckBox     is  on, it    is       initialized
%      to 'pertubated'   and   can  be    changed   to    'uniform' or
%      'lognormal', using the corresponding PopupMenu.
%
%   o  perturbation: stricly positive real scalar.
%      When    canonical  CheckBox   is    on    and  PopupMenu  is on
%      'pertubated', it  is initialized to 0.01  and can be changed by
%      selecting any particular value within bounds 0.0 and 1.0, using the
%      corresponding Slider or directly by editing the EditText.
%
%   o  standard deviation: stricly positive real scalar.
%      When    canonical   CheckBox   is   on    and  PopupMenu  is on
%      'lognormal',  it is initialized to 1   and can be changed by
%      selecting any particular value within  bounds 1e-05 and 5.0, using
%      the corresponding Slider or directly by editing the EditText.
%
%   o  theoretical partition function - Reyni exponents - multifractal
%      spectrum: choice.
%      In some   cases, theoretical partition   function, Reyni exponents
%      and multifractal  spectrum can be  computed, when corresponding
%      CheckBoxes are on.
%
%   1.2.  Computation
%
%
%   o  Compute:  PushButton.
%      Runs   multifractal measures  synthesis   with  parameters set as
%      described above.   It calls the  built-in C-LAB routines multim1d
%      if  RadioButton deterministic   (or  multim2d if RadioButton 2d is
%      on) or  smultim1d if RadioButton stochastic is on (or smultim2d if
%      RadioButton 2d is on).
%
%   o  Help: PushButton.
%      Calls this help.
%
%   o  Close: PushButton.
%      Closes the multifractal measures synthesis Figure and returns to
%      the main fltool Figure.
%
%   2.  Output Data
%
%   The output of the multifractal  measures synthesis is a vector of
%   length    b_x^n         (or       a   matrix       of        size
%   [b_x^nXb_y^n]). The output of the multifractal measures synthesis
%   theoretical  partition function, Reyni exponents or spectrum
%   computation is a graph structure.
%
%   3.  See also
%
%   binom,sbinom,multim1d,smulti1d,multim2d,smultim2d.
%
%   4.  References
%
%   "Multifractal Measures", Carl J. G. Evertsz and Benoit B. MandelBrot.
%   In Chaos and Fractals, New Frontiers of Science, Appendix B. Edited by
%   Peitgen, Juergens and Saupe, Springer Verlag, 1992 pages 921-953.
%
%   "A class of Multinomial Multifractal Measures with negative (latent)
%   values for the "Dimension" f(alpha)", Benoit B. MandelBrot. In
%   Fractals' Physical Origins and Properties, Proceeding of the Erice
%   Meeting, 1988. Edited by L. Pietronero, Plenum Press, New York, 1989
%   pages 3-29.
%
function [varargout]=fl_mms(fl_string,fl_who)
% Callback functions for GUI - Multifractal Measures Synthesis (mms)

fl_clearerror;

switch(fl_string)
    % deterministic
    case 'deterministic'
        fl_callwindow('Fig_gui_fl_mms','gui_fl_mms');
        deterministicbasicsettings;
        % stochastic
    case 'stochastic'
        fl_callwindow('Fig_gui_fl_mms','gui_fl_mms');
        stochasticbasicsettings;
        % resolution: n
    case 'edittext_resolution'
        n=str2num(get(gcbo,'String'));
        if isempty(n)
            n=10;
        end
        n=gui_fl_mm_trunc(n,1.,20.);
        set(gcbo,'String',n);
        set(findobj('Tag','Slider_resolution'),'Value',n);
        if get(findobj('Tag','RadioButton_1d'),'Value')==1
            b=str2num(get(findobj('Tag','EditText_base'),'String'));
            set(findobj('Tag','StaticText_intervals_nb'),'String',b^n);
            % test # of intervals
            if b^n>65536
                fl_warning('# of intervals too large');
            end
        else
            b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
            b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
            set(findobj('Tag','StaticText_intervals_nb'),'String',b_x^n*b_y^n);
            % test # of intervals
            if b_x^n*b_y^n>65536
                fl_warning('# of intervals too large');
            end
        end
    case 'slider_resolution'
        n=get(gcbo,'Value');
        n=gui_fl_mm_fix(n,1);
        set(findobj('Tag','EditText_resolution'),'String',n);
        if get(findobj('Tag','RadioButton_1d'),'Value')==1
            b=str2num(get(findobj('Tag','EditText_base'),'String'));
            set(findobj('Tag','StaticText_intervals_nb'),'String',b^n);
            % test # of intervals
            if b^n>65536
                fl_warning('# of intervals too large');
            end
        else
            b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
            b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
            set(findobj('Tag','StaticText_intervals_nb'),'String',b_x^n*b_y^n);
            % test # of intervals
            if b_x^n*b_y^n>65536
                fl_warning('# of intervals too large');
            end
        end
        % base: b
    case 'edittext_base'
        b=str2num(get(gcbo,'String'));
        if isempty(b)
            b=3;
        end
        b=gui_fl_mm_trunc(b,2.,10.);
        set(gcbo,'String',b);
        set(findobj('Tag','Slider_base'),'Value',b);
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        if get(findobj('Tag','RadioButton_1d'),'Value')==1
            set(findobj('Tag','StaticText_intervals_nb'),'String',b^n);
            % test # of intervals
            if b^n>65536
                fl_warning('# of intervals too large');
            end
        else
            b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
            set(findobj('Tag','StaticText_intervals_nb'),'String',b^n*b_y^n);
            % test # of intervals
            if b^n*b_y^n>65536
                fl_warning('# of intervals too large');
            end
        end
    case 'slider_base'
        b=get(gcbo,'Value');
        b=gui_fl_mm_fix(b,1);
        set(findobj('Tag','EditText_base'),'String',b);
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        if get(findobj('Tag','RadioButton_1d'),'Value')==1
            set(findobj('Tag','StaticText_intervals_nb'),'String',b^n);
            % test # of intervals
            if b^n>65536
                fl_warning('# of intervals too large');
            end
        else
            b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
            set(findobj('Tag','StaticText_intervals_nb'),'String',b^n*b_y^n);
            % test # of intervals
            if b^n*b_y^n>65536
                fl_warning('# of intervals too large');
            end
        end
        % dimension: 1d
    case 'radiobutton_1d'
        if get(findobj('Tag','RadioButton_1d'),'Value')==0
            set(findobj('Tag','RadioButton_1d'),'Value',1);
        end
        set(findobj('Tag','RadioButton_2d'),'Value',0);
        set(findobj('Tag','EditText_base_y'),'Enable','off');
        set(findobj('Tag','Slider_base_y'),'Enable','off');
        set(findobj('Tag','EditText_base'),'String','3');
        set(findobj('Tag','Slider_base'),'Value',3);
        set(findobj('Tag','EditText_resolution'),'String','10');
        % set(findobj('Tag','EditText_resolution'),'Max',16);
        set(findobj('Tag','Slider_resolution'),'Value',10);
        set(findobj('Tag','Slider_resolution'),'Max',16);
        set(findobj('Tag','EditText_weights'),'String','[.1 .3 .6]');
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        b=str2num(get(findobj('Tag','EditText_base'),'String'));
        set(findobj('Tag','StaticText_intervals_nb'),'String',b^n);
        % test # of intervals
        if b^n>65536
            fl_warning('# of intervals too large');
        end
        
        %%% Modif Pierrick Legrand March 2005
        if get(findobj('Tag','RadioButton_1d'),'Value')==1 ...
                & get(findobj('Tag','PopupMenu_canonical'),'Value')~=1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','on')
            set(findobj('Tag','CheckBox_spectrum'),'Value',0)
            set(findobj('Tag','CheckBox_spectrum'),'String',' No')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        
    case 'radiobutton_2d'
        if get(findobj('Tag','RadioButton_2d'),'Value')==0
            set(findobj('Tag','RadioButton_2d'),'Value',1);
        end
        set(findobj('Tag','RadioButton_1d'),'Value',0);
        set(findobj('Tag','EditText_base_y'),'Enable','on');
        set(findobj('Tag','Slider_base_y'),'Enable','on');
        set(findobj('Tag','EditText_base'),'String','2');
        set(findobj('Tag','Slider_base'),'Value',2);
        set(findobj('Tag','EditText_resolution'),'String','5');
        %set(findobj('Tag','EditText_resolution'),'Max',8);
        set(findobj('Tag','Slider_resolution'),'Value',5);
        set(findobj('Tag','Slider_resolution'),'Max',8);
        set(findobj('Tag','EditText_weights'),'String','[.1 .2; .3 .4]');
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
        b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
        set(findobj('Tag','StaticText_intervals_nb'),'String',b_x^n*b_y^n);
        % test # of intervals
        if b_x^n*b_y^n>65536
            fl_warning('# of intervals too large');
        end
        
         %%% Modif Pierrick Legrand March 2005
        if get(findobj('Tag','RadioButton_2d'),'Value')==1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','off')
            set(findobj('Tag','CheckBox_spectrum'),'Value',0)
            set(findobj('Tag','CheckBox_spectrum'),'String',' No')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        % base_y: b_y
    case 'edittext_base_y'
        b_y=str2num(get(gcbo,'String'));
        if isempty(b_y)
            b_y=3;
        end
        b_y=gui_fl_mm_trunc(b_y,2.,10.);
        set(gcbo,'String',b_y);
        set(findobj('Tag','Slider_base'),'Value',b_y);
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
        set(findobj('Tag','StaticText_intervals_nb'),'String',b_x^n*b_y^n);
        % test # of intervals
        if b_x^n*b_y^n>65536
            fl_warning('# of intervals too large');
        end
    case 'slider_base_y'
        b_y=get(gcbo,'Value');
        b_y=gui_fl_mm_fix(b_y,1);
        set(findobj('Tag','EditText_base_y'),'String',b_y);
        b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        set(findobj('Tag','StaticText_intervals_nb'),'String',b_x^n*b_y^n);
        % test # of intervals
        if b_x^n*b_y^n>65536
            fl_warning('# of intervals too large');
        end
        % weights: p
    case 'edittext_weights'
        error=0;
        eval(['p=' get(gcbo,'String') ';'],'error=1;');
        if error==1
            fl_warning('Weights vector or matrix invalid: Modify weights');
            set(gcbo,'String','[ ]');
            return;
        end
        % 1d
        if get(findobj('Tag','RadioButton_1d'),'Value')==1
            b=str2num(get(findobj('Tag','EditText_base'),'String'));
            if min(size(p))~=1
                fl_warning('Weights can not be a matrix: Modify weights');
                set(gcbo,'String','[ ]');
            elseif max(size(p))~=b
                fl_warning(['Weights must be of width or height ',num2str(b),': Modify weights']);
                set(gcbo,'String','[ ]');
            elseif sum(p)~=1
                fl_warning('Weights must be normalized: Modify weights');
                set(gcbo,'String','[ ]');
            end
        end
        % 2d
        if get(findobj('Tag','RadioButton_2d'),'Value')==1
            [height width]=size(p);
            b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
            b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
            if b_x~=height | b_y~=width
                fl_warning(['Weights matrix must be ',num2str(b_x),'X',num2str(b_y),': Modify weights']);
                set(gcbo,'String','[ ]');
            elseif sum(sum(p))~=1
                fl_warning('Weights must be normalized: Modify weights');
                set(gcbo,'String','[ ]');
            end
        end
        % deterministic
    case 'radiobutton_deterministic'
        if get(findobj('Tag','Radiobutton_deterministic'),'Value')==0
            set(findobj('Tag','Radiobutton_deterministic'),'Value',1);
        end
        deterministicbasicsettings;
        % stochastic
    case 'radiobutton_stochastic'
        if get(findobj('Tag','Radiobutton_stochastic'),'Value')==0
            set(findobj('Tag','Radiobutton_stochastic'),'Value',1);
        end
        stochasticbasicsettings;
        if get(findobj('Tag','PopupMenu_canonical'),'Value')==1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','off')
            set(findobj('Tag','CheckBox_spectrum'),'Value',0)
            set(findobj('Tag','CheckBox_spectrum'),'String',' No')
        end
        % microcanonical
    case 'checkbox_microcanonical'
        if get(findobj('Tag','CheckBox_microcanonical'),'Value')==0
            set(findobj('Tag','CheckBox_microcanonical'),'Value',1)
        else
            set(findobj('Tag','CheckBox_canonical'),'Value',0)
            set(findobj('Tag','PopupMenu_canonical'),'Enable','off')
            set(findobj('Tag','PopupMenu_microcanonical'),'Enable','on')
            set(findobj('Tag','CheckBox_spectrum'),'Enable','off')
            set(findobj('Tag','EditText_perturbation'),'Enable','off')
            set(findobj('Tag','Slider_perturbation'),'Enable','off')
            set(findobj('Tag','EditText_standard_deviation'),'Enable','off')
            set(findobj('Tag','Slider_standard_deviation'),'Enable','off')
        end
    case 'popupmenu_microcanonical'
        if get(findobj('Tag','PopupMenu_microcanonical'),'Value')==2
            fl_warning('Not implemented yet: Choose another');
        end
        % canonical
    case 'checkbox_canonical'
        
        %%% Modif Pierrick Legrand March 2005
        if get(findobj('Tag','RadioButton_2d'),'Value')==1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','off')
            set(findobj('Tag','CheckBox_spectrum'),'Value',0)
            set(findobj('Tag','CheckBox_spectrum'),'String',' No')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if get(findobj('Tag','CheckBox_canonical'),'Value')==0
            set(findobj('Tag','CheckBox_canonical'),'Value',1)
        else
            set(findobj('Tag','CheckBox_microcanonical'),'Value',0)
            set(findobj('Tag','PopupMenu_microcanonical'),'Enable','off')
            set(findobj('Tag','PopupMenu_canonical'),'Enable','on')
        end
    case 'popupmenu_canonical'
        
         
        
        
        if get(findobj('Tag','PopupMenu_canonical'),'Value')==1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','off')
            set(findobj('Tag','CheckBox_spectrum'),'Value',0)
            set(findobj('Tag','CheckBox_spectrum'),'String',' No')
        elseif get(findobj('Tag','Radiobutton_stochastic'),'Value')==1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','on')
        end
        if get(findobj('Tag','PopupMenu_canonical'),'Value')~=3
            set(findobj('Tag','EditText_perturbation'),'Enable','on')
            set(findobj('Tag','Slider_perturbation'),'Enable','on')
            set(findobj('Tag','EditText_standard_deviation'),'Enable','off')
            set(findobj('Tag','Slider_standard_deviation'),'Enable','off')
        else
            set(findobj('Tag','EditText_perturbation'),'Enable','off')
            set(findobj('Tag','Slider_perturbation'),'Enable','off')
            set(findobj('Tag','EditText_standard_deviation'),'Enable','on')
            set(findobj('Tag','Slider_standard_deviation'),'Enable','on')
        end
        
        
        %%% Modif Pierrick Legrand March 2005
        if get(findobj('Tag','RadioButton_2d'),'Value')==1
            set(findobj('Tag','CheckBox_spectrum'),'Enable','off')
            set(findobj('Tag','CheckBox_spectrum'),'Value',0)
            set(findobj('Tag','CheckBox_spectrum'),'String',' No')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        % perturbation: e
    case 'edittext_perturbation'
        e=str2num(get(gcbo,'String'));
        if isempty(e)
            n=0.01;
        end
        e=gui_fl_mm_trunc(e,0.,.5);
        eval(['p=' get(findobj('Tag','EditText_weights'),'String') ';']);
        if min(p)<e
            fl_warning('Perturbation is too large')
        end
        set(gcbo,'String',e);
        set(findobj('Tag','Slider_perturbation'),'Value',e)
    case 'slider_perturbation'
        e=get(gcbo,'Value');
        e=gui_fl_mm_fix(e,1000);
        eval(['p=' get(findobj('Tag','EditText_weights'),'String') ';']);
        if min(p)<e
            fl_warning('Perturbation is too large')
        end
        set(findobj('Tag','EditText_perturbation'),'String',e);
        % standard deviation: s
    case 'edittext_standard_deviation'
        s=str2num(get(gcbo,'String'));
        if isempty(s)
            s=1.;
        end
        s=gui_fl_mm_trunc(s,0.00001,5.);
        set(gcbo,'String',s);
        set(findobj('Tag','Slider_standard_deviation'),'Value',s)
    case 'slider_standard_deviation'
        s=get(gcbo,'Value');
        s=gui_fl_mm_fix(s,100);
        s=gui_fl_mm_trunc(s,0.00001,5.);
        set(findobj('Tag','EditText_standard_deviation'),'String',s)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'checkbox_spectrum_compute'
        spect=get(gcbo,'Value');
        if spect==1
            set(findobj('Tag','CheckBox_spectrum'),'String',' Yes');
        else
            set(findobj('Tag','CheckBox_spectrum'),'String',' No');
        end;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % compute
    case 'compute'
        % set resolution: n
        n=str2num(get(findobj('Tag','EditText_resolution'),'String'));
        if get(findobj('Tag','RadioButton_1d'),'Value')==1
            % case 1d
            % set base: b
            b=str2num(get(findobj('Tag','EditText_base'),'String'));
            % set weigths: p
            eval(['p=' get(findobj('Tag','EditText_weights'),'String') ';']);
            % deterministic
            if min(size(p))~=1 | max(size(p))~=b | sum(p)~=1
                fl_warning('Weights vector invalid: Modify weights');
                return
            end
            if get(findobj('Tag','Radiobutton_deterministic'),'Value')==1
                % deterministic
                % call of the C_LAB routine
                current_mouse_ptr=fl_waiton;
                [mu_n,I_n]=multim1d(b,p,'meas',n);

                chaine=['[mu_n,I_n]=multim1d(',num2str(b),',[',num2str(p),'],''meas'',',num2str(n),');'];


                fl_waitoff(current_mouse_ptr);
                % partition function
                %if get(findobj('Tag','CheckBox_partition'),'Value')==1
                % call of the C_LAB routine
                %vn=[1:1:8];
                %q=[-5:.1:+5];
                %current_mouse_ptr=fl_waiton;
                %znq=multim1d(b,p,'part',vn,q);
                %     fl_waitoff(current_mouse_ptr);
                %logznq=log(znq);
                % set stitle
                %ptitle=['Multinomial 1d measure Multifractal partition function (b= ',num2str(b),', p= ',num2str(p),')'];
                %end
                % reyni exponents
                %if get(findobj('Tag','CheckBox_reyni'),'Value')==1
                % call of the C_LAB routine
                %q=[-5:.1:+5];
                %     current_mouse_ptr=fl_waiton;
                %tq=multim1d(b,p,'Reyni',q);
                %fl_waitoff(current_mouse_ptr);
                % set stitle
                %ttitle=['Multinomial 1d measure Multifractal Reyni exponents (b= ',num2str(b),', p= ',num2str(p),')'];
                %end
                if get(findobj('Tag','CheckBox_spectrum'),'Value')==1
                    % call of the C_LAB routine
                    current_mouse_ptr=fl_waiton;
                    [a,f]=multim1d(b,p,'spec',200);
                    chaine=['[a,f]=multim1d(',num2str(b),',[',num2str(p),'],''spec'',',num2str(200),');'];
                    fl_waitoff(current_mouse_ptr);
                    % set stitle
                    stitle=['Multinomial 1d measure Multifractal spectrum (b= ',num2str(b),', p= ',num2str(p),')'];
                end
            else
                % stochastic
                if get(findobj('Tag','CheckBox_microcanonical'),'Value')==1
                    % micro-canonical
                    if get(findobj('Tag','PopupMenu_microcanonical'),'Value')==1
                        % shuffled
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_n]=multim1d(b,p,'shufmeas',n);
                        chaine=['[mu_n,I_n]=multim1d(',num2str(b),',[',num2str(p),'],''shufmeas'',',num2str(n),');'];
                        fl_waitoff(current_mouse_ptr);
                    else
                        % stratified
                        fl_warning('Not implemented yet: Please choose another');
                        return
                    end
                else
                    % canonical
                    if get(findobj('Tag','PopupMenu_canonical'),'Value')==1
                        % pertubated
                        % set perturbation
                        e=str2num(get(findobj('Tag','EditText_perturbation'),'String'));
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_n]=multim1d(b,p,'pertmeas',n,e);


                        chaine=['[mu_n,I_n]=multim1d(',num2str(b),',[',num2str(p),'],''pertmeas'',',num2str(n),',',num2str(e),');'];

                        fl_waitoff(current_mouse_ptr);
                    elseif get(findobj('Tag','PopupMenu_canonical'),'Value')==2
                        % uniform
                        % set perturbation
                        e=0.;
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_n]=smultim1d(b,'unifmeas',n,e);

                        chaine=['[mu_n,I_n]=smultim1d(',num2str(b),',''unifmeas'',',num2str(n),',',num2str(e),');'];

                        fl_waitoff(current_mouse_ptr);
                        % spectrum
                        if get(findobj('Tag','CheckBox_spectrum'),'Value')==1
                            % call of the C_LAB routine
                            current_mouse_ptr=fl_waiton;
                            [a,f]=sbinom('unifspec',200);

                            chaine=['[a,f]=sbinom(''unifspec'',200);'];

                            fl_waitoff(current_mouse_ptr);
                            % set stitle
                            stitle='Uniform Law 1d measure Multifractal spectrum';
                        end
                    elseif get(findobj('Tag','PopupMenu_canonical'),'Value')==3
                        % lognormal
                        % set standard deviation
                        s=str2num(get(findobj('Tag','EditText_standard_deviation'),'String'));
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_n]=smultim1d(b,'lognmeas',n,s);

                        chaine=['[mu_n,I_n]=smultim1d(',num2str(b),...
                            ',''lognmeas'',',num2str(n),',',num2str(s),');'];

                        fl_waitoff(current_mouse_ptr);
                        % spectrum
                        if get(findobj('Tag','CheckBox_spectrum'),'Value')==1
                            % call of the C_LAB routine
                            current_mouse_ptr=fl_waiton;
                            [a,f]=smultim1d(b,'lognspec',200,s);

                            chaine=['[a,f]=smultim1d(',num2str(b),',''lognspec'',200,',num2str(s),');'];

                            fl_waitoff(current_mouse_ptr);
                            % set stitle
                            stitle='Lognormal Law 1d measure Multifractal spectrum';
                        end
                    end
                end
            end
        else
            % case 2d
            % set base_x and base_y: b_x b_y
            b_x=str2num(get(findobj('Tag','EditText_base'),'String'));
            b_y=str2num(get(findobj('Tag','EditText_base_y'),'String'));
            % set weigths: p
            eval(['p=' get(findobj('Tag','EditText_weights'),'String') ';']);
            if get(findobj('Tag','Radiobutton_deterministic'),'Value')==1
                % deterministic
                % call of the C_LAB routine
                current_mouse_ptr=fl_waiton;
                [mu_n,I_nx,I_ny]=multim2d(b_x,b_y,p,'meas',n);
                chaine=['[mu_n,I_nx,I_ny]=multim2d(',num2str(b_x),...
                    ',',num2str(b_y),',[',num2str(p(1,:)),';',...
                    num2str(p(2,:)),'],''meas'',',num2str(n),');'];


                fl_waitoff(current_mouse_ptr);
                % partition function
                %if get(findobj('Tag','CheckBox_partition'),'Value')==1
                % call of the C_LAB routine
                %vn=[1:1:8];
                %q=[-5:.1:+5];
                %     current_mouse_ptr=fl_waiton;
                %znq=multim2d(b_x,b_y,p,'part',vn,q);
                %     fl_waitoff(current_mouse_ptr);
                %logznq=log(znq);
                % set stitle
                %ptitle=['Multinomial 2d measure Multifractal partition function (b_x= ',num2str(b_x),', b_y=',num2str(b_y) ,')'];
                %end
                % reyni exponents
                %if get(findobj('Tag','CheckBox_reyni'),'Value')==1
                % call of the C_LAB routine
                %q=[-5:.1:+5];
                %     current_mouse_ptr=fl_waiton;
                %tq=multim2d(b_x,b_y,p,'Reyni',q);
                %     fl_waitoff(current_mouse_ptr);
                % set stitle
                %ttitle=['Multinomial 2d measure Multifractal Reyni exponents (b= ',num2str(b_x),', b_y=',num2str(b_y),')'];
                %end
                % spectrum
                if get(findobj('Tag','CheckBox_spectrum'),'Value')==1
                    % call of the C_LAB routine
                    current_mouse_ptr=fl_waiton;
                    [a,f]=multim2d(b_x,b_y,p,'spec',200);

                    chaine=['[a,f]=multim2d(',num2str(b_x),...
                        ',',num2str(b_y),',[',num2str(p(1,:)),';',...
                        num2str(p(2,:)),'],''spec'',200);'];

                    fl_waitoff(current_mouse_ptr);

                    % set stitle
                    stitle=['Multinomial 2d measure Multifractal spectrum (b_x=',num2str(b_x),', b_y=',num2str(b_y),')'];
                end
            else
                % stochastic
                if get(findobj('Tag','CheckBox_microcanonical'),'Value')==1
                    % micro-canonical
                    if get(findobj('Tag','PopupMenu_microcanonical'),'Value')==1
                        % shuffled
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_nx,I_ny]=multim2d(b_x,b_y,p,'shufmeas',n);

                        chaine=['[mu_n,I_nx,I_ny]=multim2d(',num2str(b_x),...
                            ',',num2str(b_y),',[',num2str(p(1,:)),';',...
                            num2str(p(2,:)),'],''shufmeas'',',num2str(n),');'];

                        fl_waitoff(current_mouse_ptr);
                        % set mtitle
                        mtitle=['Shuffled Multinomial 2d measure (b_x= ',num2str(b_x),', b_y= ',num2str(b_y),', n= ',num2str(n),')'];
                    else
                        % stratified
                        fl_warning('Not implemented yet: Choose another');
                        return
                    end
                else
                    % canonical
                    if get(findobj('Tag','PopupMenu_canonical'),'Value')==1
                        % pertubated
                        % set perturbation
                        e=str2num(get(findobj('Tag','EditText_perturbation'),'String'));
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_nx,I_ny]=multim2d(b_x,b_y,p,'pertmeas',n,e);

                        chaine=['[mu_n,I_nx,I_ny]=multim2d(',num2str(b_x),...
                            ',',num2str(b_y),',[',num2str(p(1,:)),';',...
                            num2str(p(2,:)),'],''pertmeas'',',num2str(n),',',num2str(e),');'];

                        
                            
                            
                        fl_waitoff(current_mouse_ptr);
                    elseif get(findobj('Tag','PopupMenu_canonical'),'Value')==2
                        % uniform
                        % set perturbation
                        e=0.;
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_nx,I_ny]=smultim2d(b_x,b_y,'unifmeas',n,e);

                        chaine=['[mu_n,I_nx,I_ny]=smultim2d(',num2str(b_x),...
                            ',',num2str(b_y),',''unifmeas'',',num2str(n),',',num2str(e),');'];

                        fl_waitoff(current_mouse_ptr);
                    elseif get(findobj('Tag','PopupMenu_canonical'),'Value')==3
                        % lognormal
                        % set standard deviation
                        s=str2num(get(findobj('Tag','EditText_standard_deviation'),'String'));
                        % call of the C_LAB routine
                        current_mouse_ptr=fl_waiton;
                        [mu_n,I_nx,I_ny]=smultim2d(b_x,b_y,'lognmeas',n,s);

                        chaine=['[mu_n,I_nx,I_ny]=smultim2d(',num2str(b_x),...
                            ',',num2str(b_y),',''lognmeas'',',num2str(n),',',num2str(s),');'];

                        fl_waitoff(current_mouse_ptr);
                    end
                end
            end
        end
        % make mu_nname
        prefix=['mu_n'];
        mu_nname=fl_findname(prefix,fl_who);
        varargout{1}=mu_nname;
        eval(['global ' mu_nname]);
        % make global var and put it in mu_nname
        eval([mu_nname '= mu_n ;']);
        % add mu_nname to list
        fl_addlist(0,mu_nname);

        fl_diary(chaine);
        ouputindex=2;
        % partition
        %if get(findobj('Tag','CheckBox_partition'),'Value')==1
        % set nlabel, logznqlabel
        %nlabel='resolution: -n';
        %logznqlabel='log-partition function: log Z_n(q)';
        % make varname
        %prefix='theoznq';
        %varname=fl_findname(prefix,fl_who);
        %varargout{ouputindex}=varname;
        % make global struct and put it in varname
        %eval(['global ' varname]);
        %eval ([varname '= struct(''type'',''graph'',''data1'',-vn,''data2'',logznq,''title'',ptitle,''xlabel'',nlabel,''ylabel'',logznqlabel);']);
        % add varname to list
        %fl_addlist(0,varname);
        %ouputindex=ouputindex+1;
        %end
        % reyni
        %if get(findobj('Tag','CheckBox_reyni'),'Value')==1
        % set qlabel, tqlabel
        %qlabel='exponents: q';
        %tqlabel='Reyni exponents: \tau(q)';
        % make varname
        %prefix='theotq';
        %varname=fl_findname(prefix,fl_who);
        %varargout{ouputindex}=varname;
        % make global struct and put it in varname
        %eval(['global ' varname]);
        %eval ([varname '= struct(''type'',''graph'',''data1'',q,''data2'',tq,''title'',ttitle,''xlabel'',qlabel,''ylabel'',tqlabel);']);
        % add varname to list
        %fl_addlist(0,varname);
        %end
        % spectrum
        if get(findobj('Tag','CheckBox_spectrum'),'Value')==1
            % set alabel, alabel
            alabel='Hoelder exponents: \alpha';
            flabel='spectrum: f(\alpha)';
            % make varname
            prefix='theof';
            varname=fl_findname(prefix,fl_who);
            varargout{ouputindex}=varname;
            % make global struct and put it in varname
            eval(['global ' varname]);
            
%             [a,f]=multim2d(b_x,b_y,p,'spec',200);
            
            eval ([varname '= struct(''type'',''graph'',''data1'',a,''data2'',f,''title'',stitle,''xlabel'',alabel,''ylabel'',flabel);']);
            % add varname to list
            fl_addlist(0,varname);
        end
end

% trunc
function trunc_x=gui_fl_mm_trunc(x,x_min,x_max)
if(x<x_min)
    trunc_x=x_min;
else
    if(x>x_max)
        trunc_x=x_max;
    else
        trunc_x=x;
    end
end

% fix
function fix_x=gui_fl_mm_fix(x,ten_power)
fix_x=round(x.*ten_power)/ten_power;

% deterministicbasicsetting
function deterministicbasicsettings
set(findobj('Tag','Radiobutton_deterministic'),'Value',1)
set(findobj('Tag','Radiobutton_stochastic'),'Value',0)
set(findobj('Tag','CheckBox_microcanonical'),'Enable','off')
set(findobj('Tag','CheckBox_microcanonical'),'Value',0)
set(findobj('Tag','PopupMenu_microcanonical'),'Style','pushbutton')
set(findobj('Tag','PopupMenu_microcanonical'),'Enable','off')
set(findobj('Tag','CheckBox_canonical'),'Enable','off')
set(findobj('Tag','CheckBox_canonical'),'Value',0)
set(findobj('Tag','PopupMenu_canonical'),'Style','pushbutton')
set(findobj('Tag','PopupMenu_canonical'),'Enable','off')
set(findobj('Tag','EditText_perturbation'),'Enable','off')
set(findobj('Tag','Slider_standard_deviation'),'Enable','off')
set(findobj('Tag','EditText_standard_deviation'),'Enable','off')
set(findobj('Tag','Slider_perturbation'),'Enable','off')
set(findobj('Tag','CheckBox_partition'),'Enable','on')
set(findobj('Tag','CheckBox_reyni'),'Enable','on')
set(findobj('Tag','CheckBox_spectrum'),'Enable','on')

% stochasticbasicsettings
function stochasticbasicsettings
set(findobj('Tag','Radiobutton_deterministic'),'Value',0)
set(findobj('Tag','Radiobutton_stochastic'),'Value',1)
set(findobj('Tag','CheckBox_microcanonical'),'Enable','on')
set(findobj('Tag','CheckBox_microcanonical'),'Value',0)
set(findobj('Tag','PopupMenu_microcanonical'),'Enable','off')
set(findobj('Tag','PopupMenu_microcanonical'),'Style','popupmenu')
set(findobj('Tag','CheckBox_canonical'),'Enable','on')
set(findobj('Tag','CheckBox_canonical'),'Value',1)
set(findobj('Tag','PopupMenu_canonical'),'Enable','on')
set(findobj('Tag','PopupMenu_canonical'),'Style','popupmenu')
set(findobj('Tag','EditText_perturbation'),'Enable','on')
set(findobj('Tag','Slider_perturbation'),'Enable','on')
set(findobj('Tag','CheckBox_partition'),'Enable','off')
set(findobj('Tag','CheckBox_partition'),'Value',0)
set(findobj('Tag','CheckBox_reyni'),'Value',0)
set(findobj('Tag','CheckBox_spectrum'),'Value',0)
set(findobj('Tag','CheckBox_spectrum'),'String',' No')
