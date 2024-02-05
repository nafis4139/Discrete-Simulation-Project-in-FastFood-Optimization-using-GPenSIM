function [PNEG] = is_eventgraph(PN)
% function [classtype] = is_eventgraph(png)
%       Is this Petri Net an event graph (marked graph)?
% Purpose:
% This function it to check whether the Petri Net 
% an event graph (marked graph). 
% Uses:
%   SCC = stronglyconn(PN)   % strongly connected components
%
% Used by: 
%
%       Reggie.Davidrajuh@uis.no (c) February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = PN.No_of_places;  Ts = PN.No_of_transitions;
A = PN.incidence_matrix;

AinnT = A(:, 1:Ps)';  
AoutT = A(:, Ps+1:2*Ps)';

PNEG = 1; % initial assumption
i = 1; % start with p1
while and(le(i, Ps), PNEG), % check every place, one by one 
    rowinn = AinnT(i,:);    rowout = AoutT(i,:);
    no_of_input_Ts = length(find(rowinn));
    no_of_output_Ts = length(find(rowout));
    pneg = and(eq(no_of_input_Ts, 1), eq(no_of_output_Ts, 1));
    if not(pneg),
        disp(['the place ', pname(i), ...
            ' has more than one input or output trans!']); 
    end;
    PNEG = and(PNEG, pneg);
    i = i + 1;
end


