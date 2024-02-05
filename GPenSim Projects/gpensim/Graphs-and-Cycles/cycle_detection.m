function [V] = cycle_detection (V, optional_vertex_order)
% function [V] = cycle_detection (V, optional_vertex_order)
% uses "depth-first-search" technique
% V is the set of nodes
% V.A is the incidence matrix
% V.nodes is the set of nodes
%
% Uses dfs_cycle.m
%  
%      Reggie Davidrajuh (c) December 2011

No_of_nodes = length(V.nodes);

for i = 1:No_of_nodes,
    V.nodes(i).color = 'white';
    V.nodes(i).d = 0;   % discovered time
    V.nodes(i).f = 0;   % finished time
    V.nodes(i).pi = 0;  % predecessor
end;

V.time = 0; % current time (current step)

% optional vertex order given
if eq(nargin, 2),
    vertex_order = optional_vertex_order;
else
    vertex_order = 1:number_of_nodes;
end;

% now uses Depth-First-Search 
for i = 1:No_of_nodes,
    ni = vertex_order(i);
    if strcmp(V.nodes(ni).color, 'white'),
        V = dfs_cycle(V, ni);        
    end;
end;
