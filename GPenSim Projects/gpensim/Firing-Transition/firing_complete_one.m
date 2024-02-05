function [log_record, colormap_record] = firing_complete_one...
                        (current_event, FTS_index)
% function[log_record, colormap_record] = firing_complete_one ...
%                       (current_event, FTS_index)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
Ps = PN.No_of_places;

t1 = current_event.event; % firing transition
PN.completing_trans = t1; % NEW in v.10 !!!!!!!!!!!!!!!!!

% deposit new tokens
delta_X = current_event.delta_X;
PN.X    = PN.X + delta_X;

% cancel virtual tokens in Virtual Places
PN.VX = PN.VX - PN.global_transitions(t1).absorbed_tokens;
PN.global_transitions(t1).absorbed_tokens = zeros(1, Ps);

for i = 1:length(delta_X)
    if delta_X(i)
        deposit_token(i,delta_X(i), ...
            current_event.add_color, current_event.add_cost);
    end
end

PN.global_transitions(t1).times_fired = ...
    PN.global_transitions(t1).times_fired + 1;
PN.State = PN.State + 1;

log_record = [PN.X, t1, PN.State, current_event.from_State, ...
    FTS_index, current_event.start_time, PN.current_time PN.VX];

% after all the deposits, now get the colors picture in color_map 
colormap_record = get_current_colors();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finally perform, if any, post actions of the firing 
firing_postactions(); 

%%%%%%%%%%%%
% trans has fired thus available
PN.Firing_Transitions(t1) = 0; 
