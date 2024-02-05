function [reserved] = requestWA(reource_w_WA)
%function [reserved]= requestWA(reource_w_WA)
%  to request a reource with write access (lock all the instances) 
% e.g. [reserved]= reserveWA('P')
%   output reserved is a boolean indicates whether reservation was 
%   successfull or not.

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if iscell(reource_w_WA), 
    r_index = reource_w_WA{1}; 
else
    r_index = reource_w_WA;
end;
if ischar(r_index), r_index = check_valid_resource(r_index); end;

no_of_instances_required = PN.system_resources(r_index).max_instances;

iai = availableInst(r_index); % get the instance availability info
% number of instances available in each specified resource
if gt(no_of_instances_required, iai.n),
    reserved = false; % 
else % no_of_instances_required == iai.n   (all the instances are avail)
    reserveInst(no_of_instances_required, iai); 
    reserved = true; % 
end;
