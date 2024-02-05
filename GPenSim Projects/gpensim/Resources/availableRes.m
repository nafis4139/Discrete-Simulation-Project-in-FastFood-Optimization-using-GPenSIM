function [RAI] = availableRes(set_of_resource_indices)
% function[RAI] = availableRes()
%  function returns available resource info for a prticular transition. 
%   !!!! Important: time already the instance is used is also checked 
%                   against MAX_CAP
%
%  Input: 
%
%  Output: RAI structure consisting of the following fields for each
%  resource
%    avINS.r_index = r_index;   % reosurce index
%    avINS.n = numel(instance_indices); % number of free (avail) instances
%    avINS.instance_indices=instance_indices; %indice of avail instances

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN
Rs = PN.No_of_system_resources;

if eq(nargin,0)
    SI = 1:Rs; lenSR = Rs;
else
    lenSR = length(set_of_resource_indices);
    if iscell(set_of_resource_indices)
        SI = zeros(1, lenSR);
        for i = 1:lenSR
            SI(i) = check_valid_resource(set_of_resource_indices(i));
        end
    else
        SI = set_of_resource_indices;
    end % if iscell(set_of_resource_indices),            
end
    
RAI = []; % resource availablity info
for i=1:lenSR
    rai = availableInst(SI(i));
    RAI = [RAI rai];
end