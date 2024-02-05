function [set_of_tokID, nr_token_av] = tokenCostBetween(placeI, ...
                         nr_tokens_wanted, lower_interval, upper_interval)
%function [set_of_tokID, nr_token_av] = tokenCostBetween(placeI, ...
%                          nr_tokens_wanted, lower_interval, upper_interval)
%       "token-Cost-Between"
%
% Selection of tokens from a specific place based on their costs 
% This function selects tokens that cost between two limits:
%  e.g. Select three tokens from place 'p1' that cost between 10 and 20 USD
%          tokenExpensive('p1', 3, 10, 20)   

%  Reggie.Davidrajuh@uis.no (c) revised 15 February 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN;

% if place is a string, then get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end;

set_of_tokID = zeros(1, nr_tokens_wanted); % all zeros, initially
nr_token_av = 0; % initially
nr_tokens_in_placeI = PN.global_places(placeI).tokens;

% if the place has no tokens then there's nothing to do
if not(nr_tokens_in_placeI), return; end; 

tbank = PN.global_places(placeI).token_bank;
for i = 1:nr_tokens_in_placeI,
    tct = tbank(i).cost;  % token's creation time
    if and(ge(tct,lower_interval), le(tct,upper_interval)),
        nr_token_av = nr_token_av + 1;
        set_of_tokID(nr_token_av) = tbank(i).tokID;
    end;
    if eq(nr_token_av, nr_tokens_wanted),
        break; 
    end;
end;
