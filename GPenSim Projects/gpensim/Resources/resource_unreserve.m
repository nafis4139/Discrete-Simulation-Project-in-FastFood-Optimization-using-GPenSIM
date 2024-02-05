function [] = resource_unreserve(t_index)
% function [] = resource_unreserve(t_index)
% this function cancells all the resources that are reserved by 
% a transition in its _pre file.  
%
% In a _pre file, a transition can ONLY reserve resources:
%    if the resources are available, then they will be reserved
%    for the transition. However, only when the transition 
%    starts firing, then the reserved resources will be allocated 
%    to the firing transition. On the other hand, if a transiton fails
%    to satisfy the firing_conditions and do not start fire, 
%    then all the resource reservations will be cancelled by this 
%    function.
%
% Usage:
%   Inputs:
%       trans_name: name of the specified transition
%
%   Outputs:
%       allocated: name of the specified transition
%
%   Called by: firing_preconditions
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

Rs = PN.No_of_system_resources;
reserved_by_this_trans = PN.global_transitions(t_index).resources_reserved;

if not(any(reserved_by_this_trans)), return; end  % return if nothing to unreserve

% 1: go into every resource structure, and 
%    clear the "under reservation" bits (row-4 of instance_usage)
for resource = 1:Rs
    instances_of_a_res_reserved_by_t = reserved_by_this_trans(resource);
    if instances_of_a_res_reserved_by_t
        PN.system_resources(resource).instance_usage(4, :) = 0;
    end
end

% 2: also, cancel all the resource reservations made by the transition
PN.global_transitions(t_index).resources_reserved = zeros(1, Rs); 



