function tx = get_trans(t_index)
% function [tx] = get_trans(t_index)
%       "get a local copy of the transiton"
%
% Purpose:
% This function extracts transition structure from PN structure.
%
% Define variables: 
%   Inputs:  transition name (string) or transition index (number) 
%   Output:  structure of trans
%
% %                   name: 'tX1'
% %            firing_time: 1
% %            firing_cost: 0
% %            times_fired: 5
% %       resources_on_use: []
% %     resources_reserved: 0
% %        absorbed_tokens: [0 0 0]
% %        resources_owned: 0
%
% Usage:
% E.g. tx = get_trans('Robot_1'); 
%      tx = get_trans(3);  % t_index is 3
%
% Functions called : check_valid_transition

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if ischar (t_index), 
    t_index = check_valid_transition(t_index);
end;

tx = PN.global_transitions(t_index);
