function [DURATION_MATRIX] = extractt(PN, set_of_transitions)
% [DURATION_MATRIX] = extractt(PN, set_of_transitions)
% E.g.: [DURATION_MATRIX] = extractt(PN, {'tr_1', tr_2'})
%
% This function returns a matrix with three colums: 
%     [firing-transition, start-time, stop-time]

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = PN.No_of_places;
Ts = PN.No_of_transitions;

m = size(PN.LOG, 1);

%                               event,  start:stop
event_timing_log = PN.LOG(2:m, [Ps+1, end-Ps-1:end-Ps]);

% [m2, n2] = size(event_timing_log);
% maxtime = event_timing_log(m2, n2);
DURATION_MATRIX = [];

% get the transition index, for each of the transition names 
firing_transitions = event_timing_log(:,1)';

for i = 1:length(set_of_transitions),
    transition_name = set_of_transitions{i};
    t_index = check_valid_transition(transition_name); 
    index = (firing_transitions==t_index);
    submatrix = event_timing_log(index',:);
    sm = size(submatrix, 1);
        
    for j = 1:sm,
        startT = submatrix(j,2);
        stopT = submatrix(j,3);
        DURATION_MATRIX = [DURATION_MATRIX; ...
            t_index startT stopT];
    end;
end;
