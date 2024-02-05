function [acquired] = request(specific_resources)
% function [acquired] = request(specific_resources)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp(['inside "resource_request" ....']);

global PN;

acquired = false; % initially 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nargin == 0: reserve ANY ONE available resource
if not(nargin),  
    r_index = 1;
    Rs = PN.No_of_system_resources;
    found = false;
    while and(le(r_index, Rs), not(found)),
        found = resource_request_one_res(r_index, 1);
        r_index = r_index + 1;
    end;
    acquired = found;    
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nargin == 1: reserve ONE or multiple specific resource(s)
if eq(nargin, 1),  
    no_of_resources = length(specific_resources)/2;
    
    acquired = true; % inital assumption
    for i = 1: no_of_resources,
        res_name = specific_resources{2*i-1};
        r_index = check_valid_resource(res_name);
        no_of_instances = specific_resources{2*i};
        found = resource_request_one_res(r_index, no_of_instances);
        acquired = and(acquired, found);
    end;
end;

