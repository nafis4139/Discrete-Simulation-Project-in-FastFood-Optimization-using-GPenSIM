function [SCC] = stronglyconn_rader(G)
% function [SCC] = stronglyconn_rader(G)
%   Finding Strongly Connected Components with Rader's method
%
% This file implements the algorithm by Rader (2011)
% described in chapter 3 of the book by Kepner & Gilbert (2011)
% "Graph Algorithms in the Language of Linear Algebra", p.20, fig.3.1
% Inputs: 
%       SCC (results of "scc_rader") 
%       G: the graph structure consisting of 
%               G.A (adjacency matrix) and Gnodes (set of nodes)    
%
% Reggie.Davidrajuh@uis.no     (c) April 12, 2015

A = G.A;  % get the Adjacency matrix

I = eye(size(A,1));
alpha = 0.5;
D = inv(I - alpha.* A); % the D matrix 
%disp('D matrix within "scc_rader" : '); disp(D);

%C = and(D, ones(size(D))); % extract the non-zero elements of D 

SCC = and(D, transpose(D)); % Note: for undirected graph: SCC = C 
%disp('SCC matrix within "scc_rader" : '); disp(SCC);
