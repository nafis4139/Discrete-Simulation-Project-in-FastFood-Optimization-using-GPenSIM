function [] = prncolormap(Sim_Results, places)
% [] = print_colormap(pn, Sim_Results, places)
% 
% Name:	print_colormap
% Purpose:	To print colors of the tokens
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
%                   {set_of_place_names}
% Out parameters:	None
% Uses:	print_colormap_for_place 
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   results = gpensim(pn, dynamicpart);
%   print_colormap(results, {'pNUM1','pADDED', 'pRESULT'}); 
% 
%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 14 June 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = Sim_Results.No_of_places; % Number of places

disp(' '); disp('**** **** Printing Colormap ...'); 

% no specific place is given: print all colors for all places
if eq(nargin, 1)   % print colors of tokens in all places
    set_of_places = 1:Ps;
elseif eq(nargin, 2)   % specific place(s) is given
    set_of_places = check_valid_place(places);    
end

for i = 1:length(set_of_places) % set of places are given
    print_colormap_for_place(Sim_Results, set_of_places(i));
end
