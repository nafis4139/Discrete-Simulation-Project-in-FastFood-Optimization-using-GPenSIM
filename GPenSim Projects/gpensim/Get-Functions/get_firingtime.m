function [ft] = get_firingtime(t_index)
% [ft] = get_firingtime(t_index)
%
% E.g. ft = get_firingtime('Robot_1'); 
%      t1 = get_firingtime(3);  % t_index is 3
%
% This function extracts firingtime of the transition from PN structure.
%
% Define variables: 
% Inputs:  
%          t_index: transition name (string) or transition index (number) 
%
% Output:  firing time of the transition 
% 
% Functions called : (none)

% Reggie.Davidrajuh@uis.no (c) 10 September 2017 (c) v.9

global PN

if ischar (t_index), 
    t_index = check_valid_transition(t_index);
end

ft = PN.Set_of_Firing_Times(t_index);
if isnan(ft),
    ft = PN.global_transitions(t_index).firing_time;
    ft = eval(ft);
end