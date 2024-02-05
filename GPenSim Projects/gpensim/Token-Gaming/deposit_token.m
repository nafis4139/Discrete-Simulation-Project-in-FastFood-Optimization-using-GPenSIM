function [] = deposit_token(placeI, nr_tokens, t_color, t_cost)
% [] = deposit_token(placeI, nr_tokens, t_color, t_cost)
%
%               Reggie Davidrajuh (c) Sep 2012
%%%%%%%%%%%%%%%%%%%%

global PN

PN.global_places(placeI).tokens = ...
    PN.global_places(placeI).tokens + nr_tokens; 

for i = 1:nr_tokens
    PN.token_serial_numer = PN.token_serial_numer + 1;
    tok.tokID = PN.token_serial_numer;
    tok.creation_time = PN.current_time;
    tok.color = t_color;
    tok.cost = t_cost;
    PN.global_places(placeI).token_bank = ...
        [PN.global_places(placeI).token_bank tok];
    
end