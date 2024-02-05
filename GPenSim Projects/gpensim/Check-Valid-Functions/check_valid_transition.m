function [set_of_ti] = check_valid_transition(set_of_transitions)
% function [set_of_pi] = check_valid_transition(set_of_transitions)
% checks whether transition names are valid, and returns the indices
%
% Usage:
%     set_of_transition_indices = check_valid_transitions({'t1','t2','tE'})
% Uses:
%      search_names
%
%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 14 June 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

% if there is a single transition input (text string)
if ischar(set_of_transitions)  
    set_of_transitions = {set_of_transitions}; % then convert i t to a cell
end

set_of_ti = [];

for i = 1: numel(set_of_transitions)
    trans_name = set_of_transitions{i};
    t_index = search_names(trans_name, PN.global_transitions);
    if (t_index)
        set_of_ti = [set_of_ti t_index];
    else
        prnerrormsg (['"', trans_name, '":   Wrong transition name !']);
    end
end
