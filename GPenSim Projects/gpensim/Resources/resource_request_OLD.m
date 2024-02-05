function [acquired] = resource_request(trans_name, ...
                     specific_resource, no_of_instances_required)
% function [acquired] = resource_request(trans_name, ...
%                     specific_resource, no_of_instances_required)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp(['inside "resource_request" ....']);

global PN;

acquired = false; % initially 
t_index = check_valid_transition(trans_name);

% nargin == 1: reserve ANY ONE available resource
if eq(nargin, 1),  
    r_index = 1;
    Rs = PN.No_of_system_resources;
    found = false;
    while and(le(r_index, Rs), not(found)),
        found = resource_request_one_res(t_index, r_index, 1);
        r_index = r_index + 1;
    end;
    acquired = found;    
end;

% nargin >= 2: first extract the resource name and then the index
if iscell(specific_resource), 
    specific_resource = specific_resource{1};
end;

r_index = check_valid_resource(specific_resource);

% nargin == 2: acquiring one instance of a specific resource 
if eq(nargin, 2),
    acquired = resource_request_one_res(t_index, r_index, 1);
end;

% nargin == 3: acquiring many instances of a specific resource
if eq(nargin, 3),
    acquired = resource_request_one_res(t_index, r_index, ...
                    no_of_instances_required); 
end;

%PN.global_transitions(1).resources_reserved
%PN.global_transitions(2).resources_reserved
