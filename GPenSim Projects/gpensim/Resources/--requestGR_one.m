function [acquired] = requestGR_one(trans_name)
% function [acquired] = requestGR_one(trans_name)
%   Request one instance of any available resource
% E.g.:   [acquired] = requestGR_one(trans_name)

%  Reggie.Davidrajuh@uis.no (c) Version 9.0 (c) 20 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
Rs = PN.No_of_system_resources;

t_index = trans_name;
if ischar(t_index), t_index = check_valid_transition(t_index); end;

r_index = 1;
found = false;
while and(le(r_index, Rs), not(found)),
    found = resource_request_one_res(t_index, r_index, 1);
    r_index = r_index + 1;
end;
acquired = found;    
