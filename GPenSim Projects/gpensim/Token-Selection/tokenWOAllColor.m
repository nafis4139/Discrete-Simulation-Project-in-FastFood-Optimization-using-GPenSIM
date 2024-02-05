function [set_of_tokID, nr_token_av] = tokenWOAllColor(placeI,...
                    nr_tokens_wanted, t_color)
% [set_of_tokID, nr_token_av] = tokenWOAllColor(placeI,...
%                   nr_tokens_wanted,t_color)
%
% Exclude a token ONLY if the color contains 
%     all of the specified colors (t_color) 
% Returned: Set of tokIDs will be returned. 
% 

% renamed from "select_token_without_colors"
%  Reggie.Davidrajuh@uis.no (c) revised 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

% if placeI is a string, get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end

nr_tokens_in_placeI = PN.global_places(placeI).tokens;
set_of_tokID = [];
nr_token_av = 0;  % number of tokens available

token_bank = PN.global_places(placeI).token_bank;
i = 1;
while and((nr_token_av < nr_tokens_wanted), ...
        i <= nr_tokens_in_placeI),
    token_color = token_bank(i).color;
    % STRANGE PROBLEM, temporarily fixed !!!!!!!!!!!!
    if gt(size(token_color,1),1),
        token_color = transpose(token_color);
    end
    if ~all(ismember(t_color, token_color)),  
        nr_token_av = nr_token_av + 1;
        set_of_tokID = [set_of_tokID token_bank(i).tokID];
    end;
    i=i+1;
end

% patch the set of trailing zeros
set_of_tokID = [set_of_tokID zeros(1, nr_tokens_wanted - nr_token_av)];