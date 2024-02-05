function [] = set_initial_marking(initial_dynamics)
%        [] = set_initial_marking(initial_dynamics)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts a group of elements from a given inputs of
% global_elements and elements. The resulting output is an element matrix.
% function elements_m = elements_matrix(pn.global_elements, elements)
% Inputs:
%       -global elements
%      - elements
% Output: elemets matrix

%  Reggie.Davidrajuh@uis.no (c) Version 7.0 (c) 30 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
Ps = PN.No_of_places;

X0 = get_initial_marking(initial_dynamics);  % 
PN.X = X0;
PN.VX = zeros(1, Ps); % absorbed tokens in Virtual places

PN.token_serial_numer = 0;

for i = 1:Ps,
    PN.global_Vplaces(i).token_bank = []; % Vplaces have empty token bank    
    
    PN.global_places(i).token_bank = [];  % real places
    PN.global_places(i).tokens = X0(i);   % real places
 
    if X0(i),
        for j = 1:X0(i),
            PN.token_serial_numer = PN.token_serial_numer + 1;
            tok.tokID = PN.token_serial_numer;
            tok.creation_time = 0;
            tok.color = {};
            tok.cost = 0;  % initial tokens are for free 
            PN.global_places(i).token_bank = ...
                [PN.global_places(i).token_bank tok];
        end;
    end;
end;
