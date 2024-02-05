function [set_of_tokID] = tokIDs(placeI, nr_tokIDs_wanted)
% [set_of_tokID] = tokIDs(placeI, nr_tokIDs_wanted)
% this function returns a set of tokIDs of tokens in a place
% if the second argument 'nr_tokIDs_wanted' is not given, 
% tokIDs of all the tokens in the place is returned 

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%  revised and renamed (from "select_token") 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
set_of_tokID = []; % init the return pack

if not(isnumeric(placeI)), % get the place index, better with verfication
    placeI = check_valid_place(placeI); 
end;

nr_tokens_in_placeI = PN.global_places(placeI).tokens; % total tokens 
if not(nr_tokens_in_placeI),  % if the place has no tokens 
    return;
end;

% if the number of tokens wanted is not specified, then return all tokens
if eq(nargin, 1),  nr_tokIDs_wanted = nr_tokens_in_placeI; end;

% if (nr_tokIDs_wanted == 0) just return
if not(nr_tokIDs_wanted), return; end;

% if 'nr_tokIDs_wanted' is more than available, then trim it
if gt(nr_tokIDs_wanted, nr_tokens_in_placeI),
    nr_tokIDs_wanted = nr_tokens_in_placeI;  % number of tokens available
end;

token_bank = PN.global_places(placeI).token_bank; 
token_bank_wanted = token_bank(1:nr_tokIDs_wanted);
set_of_tokID = [token_bank_wanted.tokID];
