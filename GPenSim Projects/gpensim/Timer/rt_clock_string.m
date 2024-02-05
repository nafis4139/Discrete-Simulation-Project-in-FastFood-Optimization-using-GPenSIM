function [disp_str] = rt_clock_string()
% function [disp_str] = rt_clock_string()
% display string in format HH:MM:SS 
%                      e.g. '10:15:41'

current_clock = fix(clock); % time in [YY MM DD hh mm ss] 
hour = current_clock(4);
min = current_clock(5);
sec = current_clock(6);

hour_str = int2str(hour); 
min_str = int2str(min);
sec_str = int2str(sec);

if lt(hour, 10), hour_str = ['0', hour_str]; end
if lt(min, 10), min_str = ['0', min_str]; end
if lt(sec, 10), sec_str = ['0', sec_str]; end

disp_str = [hour_str, ':', min_str, ':', sec_str];
