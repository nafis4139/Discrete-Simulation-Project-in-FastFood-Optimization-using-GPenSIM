function [token_info] = get_token(pi, tokID)
% function [token_info] = get_token(pi, tokID)
% Get complete information about the token in a place
% Inputs:  parameter-1: pi (place name or place index)
%          parameter-2: tokID
%
% Example: [token_info] = get_tokens('p1', 101);
%
%     Reggie.Davidrajuh@uis.no (c) v10 (c) 18. Oct 2017

global PN

% from the place name, get the index of the place 
if ischar(pi), pi = check_valid_place(pi); end

token_bank = PN.global_places(pi).token_bank;
token_bankTokIDs = [token_bank.tokID];
[i, j] = find(token_bankTokIDs == tokID);
if isempty(i), 
    Invalid_msg = ['Invalid tokID: ', int2str(tokID)]; 
    prnerrormsg(Invalid_msg);
end

token_info = token_bank(j);
