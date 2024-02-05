function [set_of_tokID, nr_token_av] = tokenCheap(placeI, nr_tokens_wanted)
%       "token-Cheapest"
% [set_of_tokID,  nr_token_av] = tokenCheap(placeI, nr_tokens_wanted)
%
% Selection of tokens from a specific place based on their costs 
% This function selects the cheapest tokens :
%  e.g. Select three tokens from place 'p1' that are cheapest: 
%          tokenCheap('p1', 3)   

%  Reggie.Davidrajuh@uis.no (c) revised 15 February 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN;

% if place is a string, then get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end;

nr_tokens_in_placeI = PN.global_places(placeI).tokens;
if gt(nr_tokens_wanted, nr_tokens_in_placeI),
    nr_token_av = nr_tokens_in_placeI; % number of tokens available
else
    nr_token_av = nr_tokens_wanted;
end;

tbank = PN.global_places(placeI).token_bank;
token_costs = [tbank.cost];
[cts, sinds] = sort(token_costs, 2, 'ascend');
interested_inds = sinds(1:nr_token_av);
interested_tokens =  tbank(interested_inds);
set_of_tokID = [interested_tokens.tokID];

% patch the set of trailing zeros
set_of_tokID = [set_of_tokID zeros(1, nr_tokens_wanted - nr_token_av)];

