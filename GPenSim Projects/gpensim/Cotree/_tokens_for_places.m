function [source_tokens] = tokens_for_places(sources)
% [source_tokens] = tokens_for_places(sources)
% This function constructs the tokens vector from the places (sources)
% and their specified tokens
% e.g. tokens_for_specific_places:  sources = {'p1',1, 'p7',3}; 

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
Ps = PN.No_of_places;

no_sources = length(sources)/2;
source_tokens = zeros(1, Ps);

for i = 1:no_sources,
    curr_place = sources{2*i -1};
    place_nr = check_valid_place(curr_place);
    source_tokens(1, place_nr) = sources{2*i};
end;
