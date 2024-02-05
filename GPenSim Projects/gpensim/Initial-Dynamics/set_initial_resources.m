function [] = set_initial_resources(dynamicpart)
%        [] = set_initial_resources(dynamicpart)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

Ts = PN.No_of_transitions;
Resources = [];

% process the resource names and the max instances
resources = dynamicpart.re;
Rs = length(resources)/3;  %number of resources with instances and MAX_CAP
for i = 1:Rs,
    res.name = resources{3*i - 2};
    res.max_instances = resources{3*i-1};    
    res.MAX_CAP = resources{3*i};    
    if or(or(not(ischar(res.name)), not(isnumeric(res.max_instances))), ...
            not(isnumeric(res.MAX_CAP))), 
        error('"dynamic.resources" must contain (name value) pairs'); 
    end;
    %%%% res.on_use = 0; % no one is using this resource now
    res.rc_fixed = 0; % cost of resource is yet to assigned
    res.rc_variable = 0; % cost of resource is yet to assigned
    
    % create matrix to record usage of each instance of the resource 
    % row-1: "on_use": whether the instance is currently being used or not 
    % row-2: "start_time": the start time of the current usage
    % row-3: "total_time": total time of usage of the instance so far
    % row-4: "reserving_trans": which trans has currently reserved the instance
    res.instance_usage = zeros(4,res.max_instances);
    Resources = [Resources res];
end;
PN.system_resources = Resources;

% for each transition, add the register for resource reservation
for i = 1:Ts,
    PN.global_transitions(i).resources_reserved = zeros(1, Rs);
end;

% process fixed resource costs
if isfield(dynamicpart, 'rc_fixed'), 
    PN.COST_CALCULATIONS = 1;
    rc_fixed = dynamicpart.rc_fixed;
    fcosts = length(rc_fixed)/2;  % number of (resources with cost)
    for i = 1:fcosts,
        res_name = rc_fixed{2*i - 1};
        res_cost = rc_fixed{2*i};    
        ri = check_valid_resource(res_name);
        PN.system_resources(ri).rc_fixed = res_cost;
    end;
 end;

% process variable resource costs
if isfield(dynamicpart, 'rc_variable'), 
    PN.COST_CALCULATIONS = 1;
    rc_variable = dynamicpart.rc_variable;
    vcosts = length(rc_variable)/2;  % number of (resources with cost)
    for i = 1:vcosts,
        res_name = rc_variable{2*i - 1};
        res_cost = rc_variable{2*i};    
        ri = check_valid_resource(res_name);
        PN.system_resources(ri).rc_variable = res_cost;
    end;
 end;
 
PN.No_of_system_resources = Rs;
PN.Resource_usage_LOG = [];
