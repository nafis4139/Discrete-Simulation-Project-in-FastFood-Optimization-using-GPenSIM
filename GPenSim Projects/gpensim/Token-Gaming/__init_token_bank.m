function [] = init_token_bank()
% [] = init_token_bank()
%
%           Reggie.Davidrajuh@uis.no (c) August 2011

global PN;

Ps = PN.No_of_places;
PN.token_serial_numer = 0;
X0 = PN.X; % initial state

for i = 1:Ps,
    PN.global_places(i).token_bank = [];
    PN.global_places(i).tokens = X0(i);
  
    if X0(i),
        for j = 1:X0(i),
            PN.token_serial_numer = PN.token_serial_numer + 1;
            tok.tokID = PN.token_serial_numer;
            tok.creation_time = 0;
            tok.color = {};
            PN.global_places(i).token_bank = ...
                [PN.global_places(i).token_bank tok];
        end;
    end;
end;
