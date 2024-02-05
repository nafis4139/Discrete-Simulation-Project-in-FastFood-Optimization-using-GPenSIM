function [V] = mincyctime(pni, expected_FR)
% function [V] = minicyctime(pni, expected_FR)
%        minim-cycle-time 
% This function finds the "minim-cycle-time (MCT)" of a marked graph.
% In order to find MCT, this function first lists all the cycles 
% in a marked_graph. The MCT = max(cycle Delay/tokens in the cycle)
% 
%
% This function first checks whether the PN is a mrked_graph.
% If not, it simply exits with an error message.
% If this is a marked graph, 
%  1) PN (incidence matrix) is converted into 
%       standard V (adjancency matirx) for graph algorithms 
%       using the function "convert_PN_V"
%  2) all the cycles are found using the function "cycles.m"
%  
%       Reggie.Davidrajuh@uis.no (c) February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V = [];  % initially

% Check whether the Petri net is an event graph
if not(is_eventgraph(pni)), % png is is NOT a marked graph
    disp('This is not a event graph ....'); return
end

% Check whether the Petri net is strongly connected
if not(is_stronglyconn(pni)), % png is is NOT a marked graph
    disp('This Net is not strongly connected ....'); return
end

% convert PN into a homogenous graph 
V1 = convert_PN_V(pni);

% find the elementary circuits (cycles) in the homogenous graph 
V = cycles(V1); % V.cycles represent the detected circuits

% Prepare for finding the minimum cycle (critical circuit), by
% adding tokens and firing times to the circuits
V = mincyctime_add_m0_ft(pni, V);

% now print: cycle number, cycle path, total Time delay, token sum, CT
[max_value, max_index, TokenSum, TotalTD] = mincyctime_process(V);
mincyctime_flowrate(max_value); % print the flow rate

% propose improvements to critical circuit 
if eq(nargin, 1), expected_FR = 0; end; % ignore expected_FR 
mincyctime_propose(max_index,TokenSum,TotalTD, expected_FR);
