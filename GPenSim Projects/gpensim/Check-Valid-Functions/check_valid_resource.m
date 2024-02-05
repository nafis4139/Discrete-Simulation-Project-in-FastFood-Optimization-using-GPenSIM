function [r_index] = check_valid_resource(resource)
% function [r_index] = check_valid_resource(resource)
% checks whether resource name is valid

%  Reggie.Davidrajuh@uis.no (c) Version 9.0 (c) 20 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
r_index = resource;  % resource is an index  

if ischar(r_index),   % resource is a character string name
    r_index = search_names(r_index, PN.system_resources);
    if not(r_index),
        if not(strcmpi('anyresource', resource)),
            error([resource, ':  unknown resource']);
        end;
    end;    
end;
