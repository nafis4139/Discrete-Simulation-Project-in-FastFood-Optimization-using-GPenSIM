function [set_of_tokID,nr_token_av] = tokenWOEXColor(...
    placeI, nr_tokens_wanted, t_color)
% function [set_of_tokID,nr_token_av] = tokenWOExColor(...
%    placeI, nr_tokens_wanted, t_color)
%
% Exclude a token ONLY if it has **exact** colors as specified
%   in "t_color" from a specific place (placeI).  
% Returned: Set of tokIDs will be returned. 
% 

%  Reggie.Davidrajuh@uis.no (c) revised 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN

% if place is a string, then get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end

nr_tokens_in_placeI = PN.global_places(placeI).tokens; % number of tokens 
set_of_tokID = [];
nr_token_av = 0;  % number of tokens available

token_bank = PN.global_places(placeI).token_bank;
size_t_color = size(t_color, 2); % number of individual colors
i = 1;
while and((nr_token_av < nr_tokens_wanted), ...
        i <= nr_tokens_in_placeI),
    token_color = token_bank(i).color;
    % STRANGE PROBLEM, temporarily fixed !!!!!!!!!!!!
    if gt(size(token_color,1),1),
        token_color = transpose(token_color);
    end
    equal_size = eq(size_t_color, size(token_color, 2));
    same_color = all(ismember(t_color, token_color)); 
    if not(and(equal_size, same_color)), 
        nr_token_av = nr_token_av + 1;
        set_of_tokID = [set_of_tokID token_bank(i).tokID];        
    end;
    i=i+1;
end

% patch the set of trailing zeros
set_of_tokID = [set_of_tokID zeros(1, nr_tokens_wanted - nr_token_av)];
