function [LOG, colormap, EIP, no_of_completions] = ...
    firing_complete(LOG, colormap, EIP, FTS_index)
% function [LOG, colormap, EIP, no_of_completions] = ...
%    firing_complete(LOG, colormap, EIP, FTS_index)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

EIP_not_empty = ~isempty(EIP);
time_to_fire = 1;       % initial assumption
no_of_completions = 0;  % number of completed transitions    

while and(EIP_not_empty, time_to_fire)
    top_event = EIP(1);
    time_to_fire = le(top_event.completion_time, PN.current_time);    
    if (time_to_fire)
        [log_record, colormap_record] = ...
            firing_complete_one(top_event, FTS_index);    
        LOG = [LOG; log_record]; %recording of events for tracing back
        colormap = [colormap colormap_record];
        EIP = EIP(2:end);                    
        no_of_completions = no_of_completions + 1;  
    end
    EIP_not_empty = ~isempty(EIP);     
end