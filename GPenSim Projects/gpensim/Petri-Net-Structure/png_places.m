function [global_places] = png_places(set_of_places)
%        [global_places] = png_places(set_of_places)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% treating set_of_places
no_of_places = length(set_of_places); %number of elements to be extracted

% allocate empty matrix for accomodating elements extracted
global_places = []; 

% extracting elements
for i = 1:no_of_places,
    curr_place.name = set_of_places{i}; % name of the place
    curr_place.tokens = 0;         % initially, 0 token in this place 
    
    global_places = [global_places curr_place];
end;
