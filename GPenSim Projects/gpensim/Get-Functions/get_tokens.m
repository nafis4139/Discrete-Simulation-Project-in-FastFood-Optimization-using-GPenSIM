function [set_of_token_info] = get_tokens(pi, tokenIDs)
% function [set_of_tokens] = get_tokens(pi, tokenIDs)
% get complete information about the tokens in a place
%              input parameter-1: pi (place name or place index)
% (optional)   input parameter-2: set of tokIDs
%  if input parameter-2 is not given, then all the tokens 
%       in the the place pi will be returned
%
% Example-1: [set_of_token_info] = get_tokens('p1');
%
% Example-2: [set_of_token_info] = get_tokens('p1', [101, 110]);
%
%     Reggie.Davidrajuh@uis.no (c) v10 (c) 18. Oct 2017

global PN
set_of_token_info = [];

% from the place name, get the index of the place 
if ischar(pi),  
    pi = check_valid_place(pi); 
end

% if only one input parameter is given - the name of the place 
% then look into all the tokens in that place
if eq(nargin, 1), 
    tokenIDs = tokIDs(pi); 
end

% if the place has no tokens then return
if isempty(tokenIDs), 
    return 
end

% finally, get the information about all the tokens
no_of_tokens = length(tokenIDs);
for i = 1:no_of_tokens,
    tokID = tokenIDs(i);
    token_info = get_token(pi, tokID);
    set_of_token_info = [set_of_token_info token_info];
end
