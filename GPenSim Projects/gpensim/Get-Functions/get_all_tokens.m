function [all_tokens_info] = get_all_tokens()
% [all_tokens_info] = get_all_tokens()
%

%  Reggie.Davidrajuh@uis.no (c) 18 February 2014  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

all_tokens_info = [];

set_of_non_empty_places = find(PN.X);
if isempty(set_of_non_empty_places)
    return;
end;

for i = 1:length(set_of_non_empty_places)
    pi = set_of_non_empty_places(i);
    tokens_info = get_tokens(pi);
    all_tokens_info = [all_tokens_info tokens_info];
end;
    
    
% for placeI = 1:length(pn.global_places),
%     token_bank = pn.global_places(placeI).token_bank;
%     if not(isempty(token_bank)),
%         lenTB = length(token_bank);
%         for tokenJ = 1:lenTB,
%             cm.creation_time = token_bank(tokenJ).creation_time;
%             cm.place = placeI;
%             cm.color = token_bank(tokenJ).color;
%             cm.cost  = token_bank(tokenJ).cost;
%             cm.tokID = token_bank(tokenJ).tokID;
%             final_tokens = [final_tokens cm];            
%         end;
%     end;
% end;
