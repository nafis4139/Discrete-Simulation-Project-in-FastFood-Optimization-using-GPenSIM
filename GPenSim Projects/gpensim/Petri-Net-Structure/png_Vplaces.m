function [] = png_Vplaces()
%        [] = png_Vplaces()
%

%  
%  Reggie.Davidrajuh@uis.no (c) Version 7.0 (c)  10 july 2012  
%                           (c) Version 10.0 (c) 07 Nov 2016 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN
% treating set_of_places
Ps = PN.No_of_places; 

% allocate empty matrix for accomodating Virtual places 
global_Vplaces = []; 

% extracting elements
for i = 1:Ps,
    Vplace.name = ['V' PN.global_places(i).name]; % name of the place
    Vplace.tokens = 0;         % initially, 0 token in this place 
    
    global_Vplaces = [global_Vplaces Vplace];
end;

PN.global_Vplaces = global_Vplaces;
