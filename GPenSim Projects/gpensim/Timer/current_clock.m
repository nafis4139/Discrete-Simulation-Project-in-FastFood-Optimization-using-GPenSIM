function [current_clock_HMS] = current_clock(secs_or_HHMMSS)
% function [current_clock_HMS] = current_clock(secs_or_HHMMSS)
%       secs_or_HHMMSS = 1 : returns seconds
%       secs_or_HHMMSS = 3 : returns [hour min sec]
%
%       Reggie Davidrajuh (c) August 2011

current_clock = fix(clock); % time in [YY MM DD hh mm ss] 
hour = current_clock(4);
min = current_clock(5);
sec = current_clock(6);

if eq(secs_or_HHMMSS, 1),
    % convert to seconds
    current_clock_HMS = sec + (60 * min) + (60 * 60 * hour); 
elseif eq(secs_or_HHMMSS, 3),
    % convert to [hour min sec]
    current_clock_HMS = [hour min sec]; 
else
    error('input argument must be either 1 or 3');
end;
