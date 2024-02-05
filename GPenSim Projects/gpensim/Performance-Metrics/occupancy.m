function [OCCUPANCY_MATRIX, DURATION_MATRIX] = occupancy(PN, set_of_transitions)
% [OCCUPANCY_MATRIX, DURATION_MATRIX] = occupancy(PN, set_of_transitions)
%
% E.g.:
% [OCCUPANCY_MATRIX, DURATION_MATRIX] = occupancy(PN, {'tr_1', tr_2'});
%
% Function extracts start-times and stop-times of transition firing
% 
%
% Define variables: 
% Inputs: 	PN: the Petri net structure; SIM: simulation results 
%          set_of_transitions: (string)
%
% Output:  OCCUPANCY_MATRIX:  1st row [time taken by each transition]
%                             2nd row:[active time in percentage]     
%
%          DURATION_MATRIX: first column: transition_index 
%                           second column: start time
%                           third column: stop time
% Functions called : extractt
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = PN.No_of_transitions;

DURATION_MATRIX = extractt(PN, set_of_transitions);
nr_rows = size(DURATION_MATRIX, 1);

completion_time = PN.completion_time; %PN.LOG(end, end); % sim.LOG(lrows, lcols);
OCCUPANCY_MATRIX = zeros(2, Ts); 

for i = 1:nr_rows,
    firing_event = DURATION_MATRIX(i, 1);
    OCCUPANCY_MATRIX(2, firing_event) = 1; % set flag bit 
    startTIME = DURATION_MATRIX(i, 2);
    stopTIME = DURATION_MATRIX(i, 3);
    durationTIME = stopTIME - startTIME;
    OCCUPANCY_MATRIX(1, firing_event) = ...
        OCCUPANCY_MATRIX(1, firing_event)+ durationTIME; % occupied time
end;

disp(' '); disp('Occupancy analysis .... ');
disp(['Simulation Completion Time: ', num2str(completion_time)]);
for i=1:Ts,
    if OCCUPANCY_MATRIX(2,i), 
        disp(['occupancy ', PN.global_transitions(i).name, ': ']);
        total_occu_time = OCCUPANCY_MATRIX(1, i);
        percentage_time = (total_occu_time/completion_time)*100;
        OCCUPANCY_MATRIX(2,i) = percentage_time;
        disp(['  total time: ', num2str(total_occu_time)]);
        disp(['  Percentage time: ', num2str(percentage_time), '%']);
    end;
end;
