function [arcw] = arcweightPT(pi, ti)
% [arcw] = arcweightPT(pi, ti)
%       "get a local copy of the place with all its details"
%
% Purpose:
% This function extracts a place from PN structure.
%
% Define variables: 
% E.g. p1 = place('buffer_1'); % place name = 'buffer_1'
%      p1 = get_place(10); % place ID pid = 10  
%
% Arguments: 
% Inputs: place_name (string) or place ID (integer), identifying the place
% Output: place (structure) with all its details
% 
% Functions called : check_valid_place

% Reggie.Davidrajuh@uis.no  (c) 05.may.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

arcw = PN.incidence_matrix(ti, pi);
