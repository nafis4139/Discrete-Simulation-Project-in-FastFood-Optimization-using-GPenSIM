function [n]  = ntokens(place_name)
% function [n] = ntokens(place_name)
%       "number of tokens" 
%
% Purpose:
% This function gets the number of tokens a place has.
%
% Define variables: 
% E.g. n1 = ntokens('buffer_1'); % place name = 'buffer_1'
%      n1 = ntokens(10); % place ID pid = 10  
%
% Arguments: 
% Inputs: place_name (string) or place ID (integer), identifying the place
% Output: number of tokens (integer, >= 0)
% 
% Functions called : get_place

% Reggie.Davidrajuh@uis.no  (c) 01 September 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

place1 = get_place(place_name); % get the local copy of the place
n = place1.tokens;              % check how many tokens this place has
