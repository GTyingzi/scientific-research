function [varargout]=gui_fl_function(varargin)


% Callback functions for direct computation GUI - Large Deviation Spectrum estimation 

% Modification P. Legrand, January 2005.

switch(varargin{1})

	%%%% basic computation %%%% 
case 'basic'

	fl_clearerror;  %%% Clear the error Zone !

        %%% J'ai besoin d'un vecteur en entree,
        %%% j'utilise fl_get_input, et c'est l'extase!
	[input_sig flag_error]=fl_get_input('vector');

	if flag_error   %% Si l'entree n'est pas un vecteur
	  varargout{1}=input_sig;
	  fl_warning('Input must be a vector !');
	  return;
	end

          %%% Cette ligne est necessaire pour pouvoir acceder
          %%% a la variable (d'entree) dont le nom est une chaine
          %%% de caracteres contenue dans la variable "input_sig".
	eval(['global ' input_sig]);

	  %%%%% Get a name for the output var %%%%%
          %%% Je trouve un nom pour la variable de sortie
          %%% en concatenant "alphagifs_" au nom de la variable
          %%% d'entree. De plus, avec "fl_findname",
          %%% je rajoute dans la joie un petit numero de maniere
          %%% a ne pas produire un nom deja present dans le WorkSpace
	prefix=['alphagifs_' input_sig];
	varname=fl_findname(prefix,varargin{2});
          %%% Je retourne le nom de la variable de sortie
          %%% pour pouvoir la "globaliser" dans le WorkSpace,
          %%% et je la globalise de suite dans cette fonction
          %%% (avant toute affectation)
	varargout{1}=varname;
	eval(['global ' varname]);

	  %%%%% Perform the computation %%%%%

	eval(['N=length(' input_sig ');']);
	scale = floor(log2(N));
	test_size = 2^scale;
	if(N > (test_size + test_size/2))
	%	fl_message('zeros have been added to the end of the signal!');
	elseif(N > (test_size+1))
	%	fl_message('only for the 2^n first samples were processed!');
	end

	reg = 'slope';
	eval(['[H,C]= alphagifs(' input_sig ',reg);']);
	eval([varname '={''alphagifs'';H;C};']);
    
    chaine=[varname,'=alphagifs(',input_sig,',''',reg,''');'];
    fl_diary(chaine);
    
	varargout{1} = varname ;

	  %%%%% Add to ouput list %%%%%
	%%% J'ajoute le nom de la variable de sortie dans la liste
	%%% des variables.
	 fl_addlist(0,varname);

	%%%% advanced parameter %%%% 

case 'advanced'

	fl_callwindow('Fig_alphagifs_adv','gui_fl_alphagifs_adv');

end



