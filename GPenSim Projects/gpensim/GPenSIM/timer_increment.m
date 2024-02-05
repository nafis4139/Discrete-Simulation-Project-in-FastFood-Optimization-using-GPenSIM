function [timer_increased] = timer_increment(number_of_completions)
% function [timer_increased] = timer_increment(number_of_completions)
%
% timer_increment increases timer value so that the next loop can start
% However, if some transitions has just fired, then we do not increase
% the timer, as the transition just fired could be an impulse so that
% some other transitions can start immediately
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global PN;

% if REAL_TIME, read the REAL_TIME clock
if PN.REAL_TIME,
    PN.current_time = current_clock(1); % return seconds
    
    % Print REAL-TIME state info
    % print_real_time_state_info();    
    timer_increased = true;
    return
end;

if (number_of_completions), 
    % if there was some transitions just completed, then do not
    % increase timer, as completed trans could be an impluse     
    % PN.current_time = PN.current_time + 0; 
else
    % firing completion time
    PN.current_time = PN.current_time + PN.delta_T; 
end;

% whether timer is increased or not
% timer is increased only if there were no completions
%               i.e. number_of_completions = 0
timer_increased = not(number_of_completions);
