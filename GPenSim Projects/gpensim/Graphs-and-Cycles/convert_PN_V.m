function [G] = convert_PN_V(PN)
% function [G] = convert_PN_V(PN)
% 
% Being a directed bipatitie graph, Petri nets can be analyzed 
% for properties based on graph algorithms. E.g. the shortest distance 
% between any two nodes, exsistence of cycles, etc.  
% In order to run graph algorithms, we have to change 
% the bipartite Petri Net into homogenous direted graph. 
%
% This function converts PN.incidence_matrix (A) 
% into G (adjacency matrix) so that standard graph algorihms 
% such as Depth-First-Search  can be used. 
%  
%       Reggie.Davidrajuh@uis.no (c) December 2011

Ps = PN.No_of_places;       % Number of places in the Petri Net
Ts = PN.No_of_transitions;  % Number of transitions in the Petri Net
A = PN.incidence_matrix;    % The adjacency (incidence) matrix

% Adjacency_Matrix will sparse, as there are no connections 
% between any two transitions (and between any two  places).
%  Adj = [zeros(Ts)|    Ao   ]
%        [   Ai'   |zeros(Ps)]
Ai = A(:, 1: Ps);      % Ain:  input incidence matrix
Ao = A(:, Ps+1:end);   % Aout:output incidence matrix
Tm0 = zeros(Ts, Ts);
Pm0 = zeros(Ps, Ps);

%%%%%%%%% G is the structure for homogenous directed graph
%%%%% 1. Add adjacency matrix to G
%%%%% 2. Add the names of the nodes to G
G.A = [Tm0, Ao; Ai', Pm0];  % 1. Add adjacency matrix to G

% 2. Add the names of the nodes to G
nodes = []; 
for i=1:Ts
    nodeI.name = PN.global_transitions(i).name;
    nodes = [nodes nodeI];
end
for i=1:Ps
    nodeI.name = PN.global_places(i).name;
    nodes = [nodes nodeI];
end
G.nodes = nodes;