function [set_of_tokID, nr_token_av] = tokenAny(placeI, nr_tokens_wanted)
%function [set_of_tokID, nr_token_av] = tokenAny(placeI, nr_tokens_wanted)
%
% Select any tokens (without any preference on color) from 
%    a specific place (placeI). 
% Returned: Set of tokIDs will be returned. 
% 

% renamed from "select_tokens"
%  Reggie.Davidrajuh@uis.no (c) revised 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN;

set_of_tokID = [];
nr_token_av  = 0;

% nr_tokens_wanted == 0
if not(nr_tokens_wanted),  return;  end;

% if placeI is a string, get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end;

nr_tokens_in_placeI = PN.global_places(placeI).tokens;
% this place has no tokens 
if not(nr_tokens_in_placeI),  return; end;

if gt(nr_tokens_wanted, nr_tokens_in_placeI)
    nr_token_av = nr_tokens_in_placeI;  % number of tokens available
else
    nr_token_av = nr_tokens_wanted;  
end;

token_bank = PN.global_places(placeI).token_bank(1:nr_token_av);
set_of_tokID = [token_bank.tokID];

% patch the set of trailing zeros
set_of_tokID = [set_of_tokID zeros(1, nr_tokens_wanted - nr_token_av)];
