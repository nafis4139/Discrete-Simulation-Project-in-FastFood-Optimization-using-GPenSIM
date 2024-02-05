function [START_TIME] = process_options_start_time(START_AT)
% function [START_TIME] = process_options_start_time(START_AT)
%
%           Reggie Davidrajuh (c) August 2011

global PN;

st = START_AT;

% STARTING_TIME = start_at(global_info.Start_At); 
if ischar (st),  % starting time is a string; e.g. 'unifrdn(10, 12)'
    START_TIME  = eval(st); 
elseif eq(length(st), 3),  % starting time is vector [hh mm ss]
    PN.HH_MM_SS = 1; % set Hour-Min-Sec flag
    START_TIME = st(3) + (60 * st(2)) + (60 * 60 * st(1)); %convert to sec
else   % all times are in seconds 
    START_TIME = st;
end;
