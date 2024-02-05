function [RETREE] = retree(pni, max_states)   
%        [RETREE] = retree(pni, max_states)   
% Name:	reachtree
% Purpose:	Creates the reachability tree of finite number of states
%           the tree includes timing and costs
% Input parameters:	Petri net sturcture with ini dynamics 
%                                   (output by ‘inidynamics’)
%                   maximum-no-of-states        
% Uses:	print_retree
%       
% Used by:	[main simulation file]
%
% Out parameters:	[RETREE]
%
% Example:	
%   % in main simulation file
%   png = petrinetgraph('cotree_example_def');
%   dyn.initial_markings = {'p1',2, 'p4', 1};
%   dyn.firing_times = {'t1',2, 't2', 1};
%   dyn.firing_costs = {'t1',16, 't2', 32};
%   RTTREE = reachtree(png, dyn.initial_markings);
%

%   Reggie.Davidrajuh@uis.no (c) Version 8.0 (c) May 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
PN = pni;
Ts = PN.No_of_transitions;

if eq(nargin, 1),
    max_states = 50; % default max states
end;

X0 = pni.X;                     % first extract the initial markings, 
FT = pni.Set_of_Firing_Times;            %   firing times
FCF = pni.Set_of_Firing_Costs_Fixed;    %   firing costs fixed, and 
FCV = pni.Set_of_Firing_Costs_Variable;    %   firing costs variable

for i = 1:Ts,
    if isnan(FT(i)),  % firing time is a string; e.g. 'unifrnd(1,1)', 
        FT(i) = eval(PN.global_transitions(i).firing_time);
    end;
    if isnan(FCF(i)),  % firing cost is a string; e.g. 'unifrnd(1,1)', 
        FCF(i) = eval(PN.global_transitions(i).firing_cost_fixed);
    end;    
    if isnan(FCV(i)),  % firing cost is a string; e.g. 'unifrnd(1,1)', 
        FCV(i) = eval(PN.global_transitions(i).firing_cost_variable);
    end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[RETREE] = build_retree(X0, FT, FCF, FCV, max_states);
print_cotree(RETREE, 1); 


