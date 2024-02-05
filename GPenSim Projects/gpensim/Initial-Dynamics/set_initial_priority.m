function [] = set_initial_priority(initial_priority)
%        [] = set_initial_priority(initial_priority)
%


%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

Ts = PN.No_of_transitions;

priority_list = zeros(1, Ts);
lenPrio = length(initial_priority);

for i = 1:2:(lenPrio-1),
    tname = initial_priority{i};
    tpriority = initial_priority{i+1}; 
    
    t_index = check_valid_transition(tname);
    priority_list(t_index) = tpriority;
    
end;

PN.priority_list = priority_list;
