function [SCC] = stronglyconn(PN)
% function [SCC] = scc_rader(PN)
% Rader's method for computing strongly connected components
% This file implements the algorithm by Rader (2011)
% described in chapter 3 of the book by Kepner & Gilbert (2011)
% "Graph Algorithms in the Language of Linear Algebra", p.20, fig.3.1
% Inputs: 
%       SCC (results of "scc_rader") 
%       G: the graph structure consisting of 
%               G.A (adjacency matrix) and Gnodes (set of nodes)    
%
% Reggie.Davidrajuh@uis.no     (c) April 12, 2015

V = convert_PN_V(PN);  % convert Petri net model into a homogenous graph 
SCC = stronglyconn_rader(V);  % find the SC components by Rader's method
SCC = unique(SCC, 'rows'); % purge the duplicate rows
% Note:unlike Rader's CC, SCC is compact without duplicate rows
[m, n] = size(SCC);  
if eq(m,1)
    disp('This is a Strongly Connected Petri net.');
    return
end

disp(['There are ', int2str(m), ' components!']);
for i = 1:m
    component = SCC(i, :);
    components_str = '';
    for j = 1:n
        if component(j)
            components_str = [components_str, ' ', V.nodes(j).name];
        end
    end
    disp(['Component-', int2str(i), ': ', components_str]); 
end