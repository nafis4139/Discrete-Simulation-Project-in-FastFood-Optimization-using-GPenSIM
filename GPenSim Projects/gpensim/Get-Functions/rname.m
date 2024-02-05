function [resource_name] = rname(r_index)
% function [transition_name] = rname(r_index)
%       (return the name of the resource)
%
% Purpose:
%   To get the name (ASCII string) of the resource
%
% Input:    index of the resource (1 - Rs)
% Output:   Name of the resource as an ASCII string 
%
% Usage:	
%   resource_name = rname(r_index));
%

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 20 September 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
Rs = PN.No_of_system_resources;

if or(lt(r_index, 1), gt(r_index, Rs)),
    error('Resource index either less than 1 or greater than Rs');
end;

resource_name = PN.system_resources(r_index).name; 