function [] = add_slacks_to_global_places(muC)
%        [] = add_slacks_to_global_places(muC)

global PN
mc0 = transpose(muC);       % initial tokens on control places
lenConstr = length(mc0);    % number of slack places

%%%%%   set slack marking
for i = 1:lenConstr,
    % virtual places
    Vslack_place.name = ['Vslack', int2str(i)];
    Vslack_place.tokens = 0;
    Vslack_place.token_bank = [];     % new slack place
    PN.global_Vplaces = [PN.global_Vplaces Vslack_place];
    
    % normal control places
    noTokens = mc0(i);
    slack_place.tokens = noTokens;  % new slack place token
    slack_place.name = ['slack', int2str(i)];
    slack_place.token_bank = []; 
    if noTokens,
        for j = 1:noTokens,
            PN.token_serial_numer = PN.token_serial_numer + 1;
            tok.tokID = PN.token_serial_numer;
            tok.creation_time = current_time();
            tok.color = {};  tok.cost = 0;  % initial tokens are for free 
            slack_place.token_bank = [slack_place.token_bank tok];
        end;
    end;
    PN.global_places = [PN.global_places slack_place]; 
end;

%PN.global_places = [PN.global_places slack_places];
PN.No_of_places = PN.No_of_places + lenConstr;
PN.No_of_control_places = lenConstr;
PN.X =  [PN.X, mc0]; 
PN.VX = [PN.VX,zeros(1,lenConstr)]; % absorbed tokens in Virtual places