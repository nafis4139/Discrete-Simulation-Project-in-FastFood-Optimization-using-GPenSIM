function [set_of_tokID, nr_token_av] = tokenColorless(placeI, ...
                                       nr_tokens_wanted)
% function [set_of_tokID, nr_token_av] = tokenColorless(placeI, ...
%                                      nr_tokens_wanted)
% Select colorless tokens (tokens with NO color) from 
%    a specific place (placeI). 
% Returned: Set of tokIDs will be returned. 
% 

% renamed from "select_token_colorless"
%  Reggie.Davidrajuh@uis.no (c) revised 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if ischar(placeI),   % if place is a string, then get the place index
    placeI = check_valid_place(placeI); 
end;

nr_tokens_in_placeI = PN.global_places(placeI).tokens;
set_of_tokID = [];
nr_token_av = 0;  % number of tokens available

token_bank = PN.global_places(placeI).token_bank;
i = 1;
while and((nr_token_av < nr_tokens_wanted), ...
        i <= nr_tokens_in_placeI),
    % colorless tokens 
    if isempty(token_bank(i).color),  
        nr_token_av = nr_token_av + 1;
        set_of_tokID = [set_of_tokID token_bank(i).tokID];
    end; % if
    i=i+1;
end; % while

% patch the set of trailing zeros
set_of_tokID = [set_of_tokID zeros(1, nr_tokens_wanted-nr_token_av)];
