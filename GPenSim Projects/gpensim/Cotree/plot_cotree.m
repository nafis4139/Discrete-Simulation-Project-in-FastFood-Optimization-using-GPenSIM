function [] = plot_cotree(X0)   
%        [] = plot_cotree(X0)   
% Name:	plot_cotree
% Purpose:	Plots the coverability tree 
% Input parameters:	Intial_markings X0
% Out parameters:	[]
% Uses:	plottree
%       
% Used by:	cotree or [main simulation file]
%
% NOTE !!!!:	the functions "plottree" and "graph" are wholly 
%               developed by Univ. of Cagliari and are part of the 
%               their "Petri Net Control Toolbox"
%               these two functions are included with specific prefix
%               PCNT_, thus plottree is renamed as PNCT_plottree and
%                           graph is renamed as PNCT_graph 
%       
% Example:	
%   % in cotree or in main simulation file 
%   png = petrinetgraph('cotree_example_def');
%   dyn.initial_markings = {'p1',2, 'p4', 1};
%   plot_cotree(png, dyn.initial_markings);

%
%   Reggie.Davidrajuh@uis.no (c) January 2012

global PN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert GPenSIM PN structure into 
%           "Cagliari "Petri Net Control Toolbox" structure

[Pre_A, Post_A] = gpensim_2_PNCT(PN.incidence_matrix);

% now call the plottree function of "Petri Net Control Toolbox" 
[G, T] = PNCT_graph(Pre_A, Post_A, X0');
PNCT_plottree(T);

