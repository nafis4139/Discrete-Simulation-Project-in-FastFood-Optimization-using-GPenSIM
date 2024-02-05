function [max_value, max_index, TokenSum, TotalTD] = mincyctime_process(V)
% function [max_value, max_index, TokenSum, TotalTD] = mincyctime_process(V)
%
% This function prints: 
%     cycle number, cycle path, total Time delay, token sum, and CT 
%
%     Reggie.Davidrajuh@uis.no  (c) February 2012

No_of_cycles = size(V.cycles, 1);

TotalTD = zeros(1, No_of_cycles);  % array of all the (total FT per circuit)
TokenSum = zeros(1, No_of_cycles); % array of all the (token sum per circuit)
CT = zeros(1, No_of_cycles); % array of all the ratio: total_time_delay/token_sum 

for i = 1:No_of_cycles,
    total_time_delay = 0;
    token_sum = 0;
    current_cycle = V.cycles(i, :);
    j = 1;
    disp_cycle_path = '';
    node = current_cycle(j);
    % each cycle end with zeros
    while node,
        disp_cycle_path = [disp_cycle_path, ' -> ', V.nodes(node).name];
        total_time_delay = total_time_delay + V.nodes(node).firing_time;
        
        token_sum = token_sum + V.nodes(node).imarkings;
        j = j+1;
        node = current_cycle(j);
    end; 
    TotalTD(i) = total_time_delay;
    disp_TD_TS = ['TotalTD = ', num2str(total_time_delay)];
    TokenSum(i) = token_sum;
    disp_TD_TS = [disp_TD_TS, '    TokenSum = ', num2str(token_sum)]; 
    ct = total_time_delay/token_sum; 
    CT(i) = ct;
    disp_CTime = ['     Cycle Time = ', num2str(ct)]; 
    disp(' '); disp(['Cycle-', int2str(i), ':   ', disp_cycle_path]);
    disp([disp_TD_TS, disp_CTime]);    
end;

[max_value, max_index] = max(CT);
disp(' ');disp(' ');
disp(['Minimum-cycle-time is: ', num2str(max_value), ...
    ', in cycle number-', num2str(max_index)]);
disp(' ');
