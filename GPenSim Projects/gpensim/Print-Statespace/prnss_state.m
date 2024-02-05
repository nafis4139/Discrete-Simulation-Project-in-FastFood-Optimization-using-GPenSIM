function [] = prnss_state(fired_event, finishing_time, ...
               current_markings, state, virtual_tokens)
%        [] = print_statespace_state(fired_event, finishing_time, ...
%               current_markings, state, virtual_tokens)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

disp(' ');
if (PN.HH_MM_SS)
    disp(['**    Time: ', string_HH_MM_SS(finishing_time), '   **']);
else
    disp(['**    Time: ', num2str(finishing_time), '   **']);
end;

if (fired_event), % this is a state transition 
    disp(['State: ', num2str(state)]);
    disp(['Fired Transition: ', PN.global_transitions(fired_event).name]);
    disp(['Current State: ', markings_string(current_markings)]); 
    disp(['Virtual tokens: ',  markings_string(virtual_tokens)]);        
    
else    %%% this is an intermediate state
    disp('Intemediate State: ');  
    disp(['Current Markings: ', markings_string(current_markings)]);
    disp(['Virtual tokens: ',  markings_string(virtual_tokens)]);    
end;
