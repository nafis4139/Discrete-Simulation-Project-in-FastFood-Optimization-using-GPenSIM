function [set_of_pi] = check_valid_place(set_of_places)
% function [set_of_pi] = check_valid_place(set_of_places)
% checks whether place names are valid, and returns the indices
%
% Usage:
%     set_of_place_indices = check_valid_places({'p1','p2','pE'})
% Uses:
%      check_valid_places
%
%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 14 June 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

% if there is a single place input (text string)
if ischar(set_of_places),   
    set_of_places = {set_of_places}; % then convert i t to a cell
end

set_of_pi = [];

for i = 1: numel(set_of_places),
    place_name = set_of_places{i};
    p_index = search_names(place_name, PN.global_places);
    if (p_index),
        set_of_pi = [set_of_pi p_index];
    else
        prnerrormsg (['"', place_name, '":   Wrong place name !']);
    end
end
