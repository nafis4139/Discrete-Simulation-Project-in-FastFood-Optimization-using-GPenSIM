function [acquired] = resource_request_one_res(r_index, ...
                          no_of_instances_required)
% function [acquired] = resource_request_one_res(r_index, ...
%                         no_of_instances_required)

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
t_index = PN.attempting_trans;

%%% disp('Inside "resource_request_one_res" ....');

acquired = false; % initially 
max_inst = PN.system_resources(r_index).max_instances;
MAX_CAP =  PN.system_resources(r_index).MAX_CAP;

% instances of the resource on use by the other transitions
on_use =   PN.system_resources(r_index).instance_usage(1, :); 
% instances already reserved by this transition 
already_reserved = PN.system_resources(r_index).instance_usage(4, :);

on_use_or_already_reserved = on_use + already_reserved;
available_instances = not(on_use_or_already_reserved);
no_of_available_instances = sum(available_instances);
if gt(no_of_instances_required, no_of_available_instances)
    return
end

indices_of_available_instances = find(available_instances);

instances_secured = 0;
instance_indices = [];
i = 1; 
while and(lt(instances_secured, no_of_instances_required), ...
          le(i, no_of_available_instances))
    next_av_inst = indices_of_available_instances(i);
    total_time_of_inst = PN.system_resources(r_index).instance_usage(3, next_av_inst);
    if ge(MAX_CAP, total_time_of_inst + get_firingtime(t_index))
        % reserve the instance
        instance_indices = [instance_indices next_av_inst];
        instances_secured = instances_secured + 1;
    end
    i = i + 1;
end

if eq(instances_secured, no_of_instances_required)
    acquired = true; % finally
    x = zeros(1, max_inst); x(instance_indices) = t_index;
    % add the newly reserved instances to the reserved_instances list
    PN.system_resources(r_index).instance_usage(4, :) = ...
        PN.system_resources(r_index).instance_usage(4, :) + x;
    PN.global_transitions(t_index).resources_reserved(r_index) = ...
        PN.global_transitions(t_index).resources_reserved(r_index) + ...
         no_of_instances_required;
end    