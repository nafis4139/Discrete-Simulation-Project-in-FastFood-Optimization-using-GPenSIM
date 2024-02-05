function [PN] = dg2pns(dg, makeDEFfile) 
% function [PN] = dg2pns(dg, makeDEFfile)
%
% E.g.: pns = dg2pns(dg, 1);
%       pns = dg2pns({dg1, dg2, ..., dgn}, 1); % must input as a cell !!!!! 
% This function reads the dependency graph(s).
%       dg is a structure consisting of dependency matrix A, 
%       and optionally a set of task names and a project name
%       e.g. dg1.A = [1 0 1; 0 0 1; 1 0 0]; 
%            dg1.set_of_Ts = {'t1', 't2', 't3'};
%            dg1.PN_name = 'Project-1'
% Inputs: dependency graph(s)
%         makeDEFfile: to create hard DEF file or not
% Output: pns: Petri net structure (static Petri Net graph)
% Functions called : build_place, build_trans, 
%                    incidencematrix 
%                      
 
%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 15 February 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN; % because of incidencematrix() 
PN.total_number_of_tasks = 0;

if eq(nargin,1), makeDEFfile = 0; end;
    
%%%% for single definition file %%%%%
global_set_of_Ps = []; global_set_of_Ts = []; global_set_of_As = [];
global_set_of_Is = [];  % inhibitor arcs

if not(iscell(dg)), dg = {dg}; end;  % only one DG to convert
N = length(dg);

for i=1:N,
    % convert DGs one by one into pns sets 
    [set_of_Ps, set_of_Ts, set_of_As] = dg2pns_oneDG(dg{i}, makeDEFfile);
    global_set_of_Ps = [global_set_of_Ps set_of_Ps];
    global_set_of_Ts = [global_set_of_Ts set_of_Ts];
    global_set_of_As = [global_set_of_As set_of_As];
end;

global_set_of_Ps = unique(global_set_of_Ps);
Ps = length(global_set_of_Ps);
global_set_of_Ts = unique(global_set_of_Ts); 
Ts = length(global_set_of_Ts);

if isfield(dg{N}, 'PN_name'), 
    PN.name = dg{N}.PN_name;
else
    PN.name = '    ';
end;
PN.global_places = png_places(global_set_of_Ps);
PN.No_of_places = Ps; 
PN.global_transitions = png_trans(global_set_of_Ts, Ps);
PN.No_of_transitions = Ts; 

PN = png_Vplaces(PN);
png_incidencematrix(global_set_of_As);
png_inhibitormatrix(global_set_of_Is);

