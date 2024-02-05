function [avINS] = availableInst(r_index)
% function[avINS] = availableInst(r_index)
%  function returns info about the available (free) instances of a recource
%   for a prticular transition. 
%   !!!! Important: time already the instance is used is also checked 
%                   against MAX_CAP
%
%  Input: resource name (or resource index)
%
%  Output: A structure consisting of the following fields
%    avINS.r_index = r_index;   % reosurce index
%    avINS.n = numel(instance_indices); % number of free (avail) instances
%    avINS.instance_indices = instance_indices; %indice of avail instances

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
t_index = PN.attempting_trans;

%%% disp('Inside "availINS" ....');
if ischar(r_index), r_index = check_valid_resource(r_index); end

max_inst = PN.system_resources(r_index).max_instances;
MAX_CAP =  PN.system_resources(r_index).MAX_CAP;
instance_usage = PN.system_resources(r_index).instance_usage;

on_use = instance_usage(1,:); % instances on use by other transitions
already_reserved = instance_usage(4,:); % instances already reserved by this transition 

on_use_or_already_reserved = on_use + already_reserved;
available_instances = not(on_use_or_already_reserved);
no_of_available_instances = sum(available_instances);

indices_of_available_instances = find(available_instances);

% find the "valid_instances" out of the "available_instances"
% by checking the instance usage time against MAX_CAP
valid_instances = 0;  
instance_indices = [];
i = 1; 
while le(i, no_of_available_instances)
    next_av_inst = indices_of_available_instances(i);
    total_time_of_inst = instance_usage(3, next_av_inst);
    if ge(MAX_CAP, total_time_of_inst + get_firingtime(t_index))
        % take this instance
        instance_indices = [instance_indices next_av_inst];
        valid_instances = valid_instances + 1;
    end
    i = i + 1;
end

avINS.r_index = r_index;   % reosurce index
avINS.n = numel(instance_indices);
avINS.instance_indices = instance_indices;

% "instance_usage" of each resource in PN.system_resources:
%       "row-1: on_use", "row-2: start_of_use", "row-3: total_time used" 
%   and "row-4: reservation list"
