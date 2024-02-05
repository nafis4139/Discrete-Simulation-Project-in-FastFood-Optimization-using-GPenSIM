function [resource_usage_cost] = resource_assign(t_index)
% function [resource_usage_cost] = resource_assign(t_index)
% this function cancells all the resources that are reserved by 
% a transition in its _pre file.  
%
% In a _pre file, a transition can ONLY reserve resources:
%    if the resources are available, then they will be reserved
%    for the transition. However, only when the transition 
%    starts firing, then the reserved resources will be allocated 
%    to the firing transition. On the other hand, if a transiton fails
%    to satisfy the firing_conditions and do not start fire, 
%    then all the resource reservations will be cancelled by 
%    the function resource_unreserve() 
%
% Usage:
%   Inputs:   t_index: index of the transition
%   Outputs:
%
%   Called by: firing_start
%

%  Reggie.Davidrajuh@uis.no (c) Version 9.0 (c) 10 july 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

resource_usage_cost = 0;   % initially 
rr = PN.global_transitions(t_index).resources_reserved;

if not(sum(rr)), 
    return;  % resource_usage_cost = 0;   
end; % if no resource reservation, simply return

Rs = PN.No_of_system_resources;

% FIRST: transiton: assign resources to tx and clear the reservation list 
PN.global_transitions(t_index).resources_owned = rr; 
PN.global_transitions(t_index).resources_reserved = zeros(1, Rs);

% SECOND: Update "instance_usage" of each resource 
%       "row-1: on_use", "row-2: start_of_use", and "row-4: reservation list"
% Note !!!!: "row-3: total_time" will be updated in function "release"   
for i = 1:Rs,
    no_of_instances_in_use = rr(i);
    if no_of_instances_in_use,    
        % setting the start time: first find the avialble instance
        instance_usage = PN.system_resources(i).instance_usage;
        on_use = instance_usage(1,:);
        currently_reserved_by_trans = instance_usage(4,:);
        on_use = on_use + currently_reserved_by_trans;
        j = find(currently_reserved_by_trans > 0);
        
        start_time_for_current_usage = instance_usage(2,:);
        start_time_for_current_usage(j) = PN.current_time;
        
        % update
        instance_usage(1,:) = on_use;
        instance_usage(2,:) = start_time_for_current_usage;
        instance_usage(4,:) = zeros(size(on_use));
        PN.system_resources(i).instance_usage = instance_usage;
      
        % instances usage costs
        rfc = PN.system_resources(i).rc_fixed;
        rvc = PN.system_resources(i).rc_variable;
        resource_cost =  no_of_instances_in_use * ...
             (rfc + get_firingtime(t_index) * rvc); %%%%%% rr(i) is corrected
        resource_usage_cost = resource_usage_cost + resource_cost;       
    end;
end;
