function [set_of_tokID, nr_token_av] = tokenArrivedBetween(placeI, ...
                         nr_tokens_wanted, lower_interval, upper_interval)
% function "token-Arrived-Between-the-given-time-interval"
% [set_of_tokID,  nr_token_av] = tokenArrivedBetween(placeI, ...
%                     nr_tokens_wanted, lower_interval, upper_interval)
%
% Selection of tokens based on their arrival time into a specific place 
% The tokens that are arrived within the given time interval:
%  e.g. Select three tokens from place 'p1' among the latest arrivals: 
%          tokenArrivedLate('p1', 3, lower_int, upper_int)   
%
% renamed from "select_token_time"
%  Reggie.Davidrajuh@uis.no (c) revised 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN

% if place is a string, then get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end

set_of_tokID = zeros(1, nr_tokens_wanted); % all zeros, initially
nr_token_av = 0; % initially
nr_tokens_in_placeI = PN.global_places(placeI).tokens;

% if the place has no tokens then there's nothing to do
if not(nr_tokens_in_placeI), 
    return
end

tbank = PN.global_places(placeI).token_bank;
for i = 1:nr_tokens_in_placeI,
    tct = tbank(i).creation_time;  % token's creation time
    if and(ge(tct,lower_interval), le(tct,upper_interval)),
        nr_token_av = nr_token_av + 1;
        set_of_tokID(nr_token_av) = tbank(i).tokID;
    end
    if eq(nr_token_av, nr_tokens_wanted),
        break 
    end
end
