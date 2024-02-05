function [no_of_ts, set_of_ti] = get_transitions(sys1, Set_of_Transition)
%        [no_of_ts, set_of_ti] = get_transitions(sys1, Set_of_Transition)

global PN;
PN = sys1;

no_of_ts = length(Set_of_Transition);
set_of_ti = [];

for i = 1:no_of_ts,
    t_index = check_valid_transition(Set_of_Transition{i});
    set_of_ti = [set_of_ti t_index];
end;

