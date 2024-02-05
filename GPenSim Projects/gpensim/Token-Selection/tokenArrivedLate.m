function [set_of_tokID, nr_token_av] = tokenArrivedLate(placeI, ...
                                               nr_tokens_wanted)
% function "token-Arrived-Latest"
% [set_of_tokID,  nr_token_av] = tokenArrivedLate(placeI, ...
%                                       nr_tokens_wanted)
%
% Selection of tokens based on their arrival time into a specific place 
% The tokens that are arrived latest (LCFS) are needed:
%  e.g. Select three tokens from place 'p1' among the latest arrivals: 
%          tokenArrivedLate('p1', 3)   
%
% renamed from "select_token_time"
%  Reggie.Davidrajuh@uis.no (c) revised 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN

% if place is a string, then get the place index
if ischar(placeI), placeI = check_valid_place(placeI); end

nr_tokens_in_placeI = PN.global_places(placeI).tokens;

if not(nr_tokens_in_placeI),   % no tokens in the place
    nr_token_av = 0;
    set_of_tokID = zeros(1, nr_tokens_wanted);
    return
end
    
if gt(nr_tokens_wanted, nr_tokens_in_placeI),
    nr_token_av = nr_tokens_in_placeI; % number of tokens available
else
    nr_token_av = nr_tokens_wanted;
end

tbank = PN.global_places(placeI).token_bank;
token_cts = [tbank.creation_time];
[cts, sinds] = sort(token_cts, 2, 'descend');
interested_inds = sinds(1:nr_token_av);
interested_tokens =  tbank(interested_inds);
set_of_tokID = [interested_tokens.tokID];

% patch the set of trailing zeros
set_of_tokID = [set_of_tokID zeros(1, nr_tokens_wanted - nr_token_av)];
