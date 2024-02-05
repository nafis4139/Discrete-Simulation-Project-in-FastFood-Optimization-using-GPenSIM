function [] = set_options()
%        [] = set_options()
%  Handle OPTIONS like MAX_LOOP, DELTA_TIME, etc.

%  Reggie.Davidrajuh@uis.no (c) Version 7.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
global global_info

% set PRINT_LOOP_NUMBER, MAX_LOOP, DELTA_TIME
if not(isfield(global_info, 'PRINT_LOOP_NUMBER')),
    global_info.PRINT_LOOP_NUMBER = 0;
end

if not(isfield(global_info, 'MAX_LOOP')),
    global_info.MAX_LOOP = 200; % default number for MAX_LOOP
end

PN.delta_T = NaN;   % intially, NOT Assigned
if isfield(global_info, 'DELTA_TIME'),
    PN.delta_T = global_info.DELTA_TIME;
end

% process REAL_TIME: sets the option "global_info.START_AT"
if isfield(global_info, 'REAL_TIME'),
    global_info.START_AT = current_clock(3); % in [hour min sec] 
    PN.REAL_TIME = 1; 
    PN.REAL_TIME_PREV_X = zeros(1, PN.No_of_places);
else  PN.REAL_TIME = 0; 
end

% process HH_MM_SS (Hour-Min-Sec Format) & Starting Time
PN.HH_MM_SS = 0; % assume initially for Hour-Min-Sec flag
if isfield(global_info, 'START_AT'),
    START_TIME = set_options_start_time(global_info.START_AT);
else  START_TIME = 0;
end
PN.current_time = START_TIME;

if isfield(global_info, 'STOP_AT'),
    STOP_TIME = set_options_stop_time(global_info.STOP_AT);
else STOP_TIME = NaN;  % stop time not given
end
PN.STOP_TIME = STOP_TIME;

% process FIRING SEQUENCE: sets the option "global_info.FIRING_SEQ"
if isfield(global_info, 'FIRING_SEQ'),
    % convert transition names (text strings) into indices
    global_info.FIRING_SEQ = check_valid_transition(global_info.FIRING_SEQ); 
    
    if not(isfield(global_info, 'FS_REPEAT')), % if field missing,
        global_info.FS_REPEAT = 1;             %  let it be '1'        
    end
    global_info.FS_Repeat_Count = 1;                          
    if not(isfield(global_info, 'FS_ALLOW_PARALLEL')),
        global_info.FS_ALLOW_PARALLEL = false;
    end
    global_info.FS_Current_Ptr = 1; % current pointer
end
