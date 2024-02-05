function [acquired] = requestWR(resource_name)
%        [acquired] = requestWR(resource_name)

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 20 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
t_index = PN.attempting_trans;

if iscell(resource_name), 
    resource_name = resource_name{1}; 
end;
r_index = resource_name;
if ischar(r_index), r_index = check_valid_resource(r_index); end;

no_of_instances_required = PN.system_resources(r_index).max_instances;

[acquired] = resource_request_one_res(r_index, no_of_instances_required);
