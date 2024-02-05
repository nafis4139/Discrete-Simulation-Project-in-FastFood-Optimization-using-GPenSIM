function [color_of_del_tokens, costs_of_del_tokens, set_of_tokID] = ...
    consume_token_in_place_i (placeI, nr_tokens_to_be_deleted, set_of_tokID)
%
% [pn,color_of_del_tokens] = consume_token_in_place_i ...
%          (pn,placeI,nr_tokens_to_be_deleted,set_of_tokID)
%

%  Reggie.Davidrajuh@uis.no (c) Version 7.0 (c) 30 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

color_of_del_tokens = {}; % color set of deleted tokens
costs_of_del_tokens = 0;      % costs of deleted tokens

nr_tokens_in_placeI = PN.global_places(placeI).tokens;
deleted_tokens = 0; % initially
token_bank = PN.global_places(placeI).token_bank; 
tokIDs = [token_bank.tokID];

if (nr_tokens_to_be_deleted > nr_tokens_in_placeI)
    error('Error in "delete_token": (nr_tokens_to_be_deleted > tokens)');
end

% first try to delete tokens marked in "set_of_tokID"
for i = 1:length(set_of_tokID)
    if lt(deleted_tokens, nr_tokens_to_be_deleted)
        tokID = set_of_tokID(i);
        token_index = ismember(tokIDs, tokID);
        if any(token_index)
            set_of_tokID(i) = NaN;  % done with this tokID
            color_of_del_tokens = union(color_of_del_tokens, ...
                token_bank(token_index).color); % ADD            
            % IMPORTANT: union malfunctions is one of input is empty !!!!!
            if gt(size(color_of_del_tokens, 1), 1)
                color_of_del_tokens = transpose(color_of_del_tokens);                
            end         
            costs_of_del_tokens = costs_of_del_tokens + ...
                token_bank(token_index).cost;
            deleted_tokens = deleted_tokens + 1;
            token_bank(token_index).tokID = NaN; 
        end % if any(token_index)
    end % if lt(deleted_tokens, 
end % for i = 1:length(set_of_tokID)

% any tokens deleted, then PURGE "set_of_tokID" and "token_bank"
if (deleted_tokens)
    % PURGE "set_of_tokID" 
    Old_set_of_tokID = set_of_tokID;
    set_of_tokID = [];
    for i = 1:length(Old_set_of_tokID)
        tokID = Old_set_of_tokID(i);
        if not(isnan(tokID))
            set_of_tokID = [set_of_tokID tokID];
        end
    end % for i = 1:length(Old_set_of_tokID)
    
    % PURGE "token_bank"
    OlD_token_bank = token_bank;
    token_bank = [];
    for i = 1:length(OlD_token_bank)
        token = OlD_token_bank(i);
        if not(isnan(token.tokID))
            token_bank = [token_bank token];
        end
    end % for i = 1:length(OlD_token_bank)
end % if (deleted_tokens)

% if still some tokens to be deleted
more_to_delete =  nr_tokens_to_be_deleted - deleted_tokens;
if (more_to_delete)
    % now delete tokens without specific tokID
    Old_TB = token_bank;
    lenTBank = length(token_bank);
    token_bank  = Old_TB(1 : lenTBank - more_to_delete);
    deleting_TB = Old_TB(lenTBank - more_to_delete+1 : end);
    for j = 1: length(deleting_TB)
        color_of_del_tokens = union(color_of_del_tokens, deleting_TB(j).color);
        if gt(size(color_of_del_tokens, 1), 1)
            color_of_del_tokens = transpose(color_of_del_tokens);            
        end
        costs_of_del_tokens = costs_of_del_tokens + deleting_TB(j).cost;
    end
end

PN.global_places(placeI).token_bank = token_bank;
new_tokens = length(token_bank);
PN.global_places(placeI).tokens = new_tokens;
