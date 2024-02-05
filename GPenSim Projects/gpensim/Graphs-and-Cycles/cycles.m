function [V] = cycles(V)
% function [V] = cycles(V)
%
% Purpose:
%  To detect all the elementary circuits (cycles) in a homogenous graph
%  The cycles are return as "V.cycles", where each row represent a circuit
%
%       Reggie.Davidrajuh@uis.no (c) December 2011


% firstly, check whether the input is a homogeneous directed graph 
%    or a bipartite Petri net graph
if not(isfield(V, 'nodes')), 
    % the input is a Petri net, hence 
    % convert it to homogeneous directed graph 
    V = convert_PN_V(V);
end

No_of_nodes = length(V.nodes);
vertex_order = 1:No_of_nodes;
V.cycles = [];

for i = 1:No_of_nodes,
    %disp(['vertex_order: ',int2str(vertex_order)]);
    vertex_order = circshift(vertex_order', 1)';
    %disp(['vertex_order: ',int2str(vertex_order)]);
    V = cycle_detection(V, vertex_order);
end

