function [cost] = get_cost(pi, tokID)
% [colors] = get_color (pi, tokID)
% get the color of the token
% token must be identified by the (place_name, tokID) pair 
%      or (place_index, tokID) pair

global PN;

if ischar(pi), pi = check_valid_place(pi); end;
t_bank = PN.global_places(pi).token_bank;

if isempty(t_bank), 
    error('given tokID is not valid');
end;
tokID
tokIDs = [t_bank.tokID]
[i, j] = find(tokIDs==tokID)
if isempty(j), 
    error('given tokID is not in given place');
end;
cost = t_bank(j).cost;