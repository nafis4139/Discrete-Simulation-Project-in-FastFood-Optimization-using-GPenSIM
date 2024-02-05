function [new_event] = create_new_event_in_Q(transition1, ...
                                  delta_X, output_place)
% [new_event] = create_new_event_in_Q(trans1, deltaX,outputPl)
%
%               Reggie Davidrajuh (c) August 2013
%

global PN;

new_event.start_time = PN.current_time; %it can be local time

% completion time
new_event.completion_time = PN.current_time + get_firingtime(transition1); 

new_event.delta_X = delta_X; %tokens to be deposited
new_event.output_place = output_place; %output places
new_event.event = transition1;
new_event.from_State = PN.State;


% event_in_Q = 
% 
%       start_time: 518
%       completion: 519.7500
%          delta_X: [0 0 1]
%     output_place: [0 0 1]
%            event: 2
%        add_color: {}