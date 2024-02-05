function [reserved] = requestSR(set_of_resources)
%function [reserved]= requestSR(set_of_resources)
%  to request a set of specific resources with instances
% e.g. [reserved]= reserveSR({'P',1, 'Q',2, 'S',5})
%   output reserved is a boolean indicates whether reservation was 
%   successfull or not.

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nrs = length(set_of_resources)/2;  % number of resources wanted 

RI = zeros(1, nrs); % set of resource indices 
II = zeros(1, nrs); % number of instances required

for i = 1:nrs
    % 1: read the inputs
    r_index = set_of_resources{2*i - 1};
    no_instances = set_of_resources{2*i};
    
    % 2: check the inputs for validity   
    r_index = check_valid_resource(r_index);
    if not(isnumeric(no_instances))
        error('wrong inputs: check the inputs to this function');
    end
    RI(i) = r_index;
    II(i) = no_instances;
end

[RAI] = availableRes(RI); % get the resource availability info
N = [RAI.n]; % number of instances available in each specified resource
if ge(N, II)
    reserved = true; % 
    for i = 1:nrs, reserveInst(II(i), RAI(i)); end
else
    reserved = false; % 
end