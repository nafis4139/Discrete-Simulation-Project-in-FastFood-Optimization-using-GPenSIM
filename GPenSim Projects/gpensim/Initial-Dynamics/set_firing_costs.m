function [] = set_firing_costs(initial_dynamics) 
%        [] = set_firing_costs(initial_dynamics) % firing costs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts a group of elements from a given inputs of
% global_elements and elements. The resulting output is an element matrix.
% function elements_m = elements_matrix(pn.global_elements, elements)
% Inputs:
%       -global elements
%      - elements
% Output: elemets matrix

%  Reggie.Davidrajuh@uis.no (c) Version 8.0 (c) 10 July 2013  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
Ts = PN.No_of_transitions;
PN.Set_of_Firing_Costs_Fixed    = zeros(1, Ts); 
PN.Set_of_Firing_Costs_Variable = zeros(1, Ts); 

if isfield(initial_dynamics, 'fc_fixed'), % fixed firing costs 
    fc_fixed = initial_dynamics.fc_fixed;
else    fc_fixed = [];
end;

if isfield(initial_dynamics, 'fc_variable'), % variable firing costs 
    fc_variable = initial_dynamics.fc_variable; 
else    fc_variable = [];
end;

both_costs_empty = and(isempty(fc_fixed), isempty(fc_variable));
PN.Firing_Costs_Enabled = not(both_costs_empty);

if both_costs_empty, 
    PN.COST_CALCULATIONS = 0;
    return; 
end;

PN.COST_CALCULATIONS = 1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

no_of_fcfixed = length(fc_fixed)/2; %number of elements to be extracted
no_of_fcvar = length(fc_variable)/2; %number of elements to be extracted

% extracting elements
% check whether the current elements is a member of global_elements
% sett in extracted element in the allocted matrix
for i = 1:no_of_fcfixed,
    curr_trans_name = fc_fixed{2*i -1};
    trans_nr = check_valid_transition(curr_trans_name); 
            
    % assign firing costs fixed to transitions
    fcf = fc_fixed{2*i};
    if ischar (fcf),  % firing cost is a string; e.g. 'unifrnd(1,1)', 
        PN.global_transitions(trans_nr).firing_cost_fixed = fcf;  
        PN.Set_of_Firing_Costs_Fixed(trans_nr) = NaN;
    else
        % firing costs is a valid real number 
        PN.global_transitions(trans_nr).firing_cost_fixed = fcf;  
        PN.Set_of_Firing_Costs_Fixed(trans_nr) = fcf;
    end;
end;

for i = 1:no_of_fcvar,
    curr_trans_name = fc_variable{2*i -1};
    trans_nr = check_valid_transition(curr_trans_name); 
            
    % assign firing costs variable to transitions
    fcv = fc_variable{2*i};
    if ischar (fcv),  % firing cost is a string; e.g. 'unifrnd(1,1)', 
        PN.global_transitions(trans_nr).firing_cost_variable = fcv;  
        PN.Set_of_Firing_Costs_Variable(trans_nr) = NaN;
    else
        % firing costs is a valid real number 
        PN.global_transitions(trans_nr).firing_cost_variable = fcv;  
        PN.Set_of_Firing_Costs_Variable(trans_nr) = fcv;
    end;
end;
