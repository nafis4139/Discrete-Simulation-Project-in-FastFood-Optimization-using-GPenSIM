function [colors] = get_color(pi, tokID)
% [colors] = get_color (pi, tokID)
% get the color of the token
% token must be identified by the (place_name, tokID) pair 
%      or (place_index, tokID) pair

% Bug fixed: 

global PN

%disp('inside "get_color" ....'); 

if ischar(pi), pi = check_valid_place(pi); end
t_bank = PN.global_places(pi).token_bank;

if isempty(t_bank)
    colors = {};
    return    
end

tokIDs = [t_bank.tokID];
[i, j] = ismember(tokID, tokIDs);
if not(i)
    error('given tokID is not in given place');
end
colors = t_bank(j).color;
