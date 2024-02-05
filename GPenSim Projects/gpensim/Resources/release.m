function [] = release(t_index)
% function [] = release(t_index)
% this function releases all the resources the specified transition
% is holding.
%
% Usage:
%   Inputs: t_index: name/index of the specified transition
%   Outputs: None
% 

%  Reggie.Davidrajuh@uis.no (c) Version 9.0 (c) 10 july 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if not(nargin)
    t_index  = PN.completing_trans;  % release is used in a post-processor
else
    if ischar(t_index), t_index = check_valid_transition(t_index); end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if no resources used by trans
if not(isfield(PN.global_transitions(t_index), 'resources_owned'))
    return
end

resources_owned = PN.global_transitions(t_index).resources_owned;
if not(sum(resources_owned))
    return
end % there are Zero resource owned

Rs = PN.No_of_system_resources;
res_released_time = PN.current_time; % resource released time

% FIRST: clear ownership of resources inside transition structure
PN.global_transitions(t_index).resources_owned = zeros(1, Rs);

% SECOND: Update "instance_usage" of each resource 
%       "row-1: on_use" and "row-3: total_time" 
for i = 1:Rs % check resource by resource
    rou = resources_owned(i);    
    if rou
        instance_usage = PN.system_resources(i).instance_usage;
        on_use_by_t = find(instance_usage(1,:)== t_index);
        for j = 1:length(on_use_by_t) % instance by instance
            current_inst = on_use_by_t(j);
            start_time = instance_usage(2, current_inst);
            PN.system_resources(i).instance_usage(1, current_inst) = 0;
            PN.system_resources(i).instance_usage(3, current_inst) = ...
              PN.system_resources(i).instance_usage(3, current_inst) + ...
                (res_released_time - start_time);
            use_log=[i,t_index,start_time,res_released_time,current_inst];
            PN.Resource_usage_LOG = [PN.Resource_usage_LOG; use_log];
        end
    end  % if rou
end
