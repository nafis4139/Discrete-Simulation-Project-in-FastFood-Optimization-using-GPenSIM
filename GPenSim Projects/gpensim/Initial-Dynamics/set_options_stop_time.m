function [STOP_TIME] = process_options_stop_time(STOP_AT)
% function [STOP_TIME] = process_options_stop_time(STOP_AT)
%
%           Reggie Davidrajuh (c) August 2011

global PN;

st = STOP_AT;

% STOP_TIME = start_at(global_info.START_AT); 
if ischar (st),  % starting time is a string; e.g. 'unifrdn(10, 12)'
    STOP_TIME  = eval(st); 
elseif eq(length(st), 3),  % starting time is vector [hh mm ss]
    PN.HH_MM_SS = 1; % set Hour-Min-Sec flag
    STOP_TIME = st(3) + (60 * st(2)) + (60 * 60 * st(1)); % convert to sec
else   % firing time is in seconds 
    STOP_TIME = st;
end;