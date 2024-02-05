function [transition_name] = tname(t_index)
% function [transition_name] = tname(t_index)
%       (return the name of the transition)
%
% Purpose:
%   To get the name (ASCII string) of the transition
%
% Input:    index of the transition (1 - Ts)
% Output:   Name of the transition as an ASCII string 
%
% Usage:	
%   transition_name = tname(t_index));
%

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 20 September 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
Ts = PN.No_of_transitions;

if or(lt(t_index, 1), gt(t_index, Ts))
    error('Transition index either less than 1 or greater than Ts');
end

transition_name = PN.global_transitions(t_index).name; 