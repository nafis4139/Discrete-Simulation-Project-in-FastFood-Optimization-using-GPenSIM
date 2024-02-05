function [] = set_initial_dynamics(initial_dynamics)
%        [] = set_initial_dynamics(dynamicpart)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

Ts = PN.No_of_transitions; 

% handle initial makrings
set_initial_marking(initial_dynamics); % intial marking "m0"     
 
% handle firing costs
set_firing_costs(initial_dynamics);

% handle firing times
if ~(isfield(initial_dynamics, 'ft')), % firing times
    disp('Firing times of transitions: NOT given ...');
    disp(' ');
    initial_dynamics.ft = [];
end;
set_firing_times(initial_dynamics.ft);

% handle initial priority
if (isfield(initial_dynamics, 'ip')), 
    set_initial_priority(initial_dynamics.ip);
else
    PN.priority_list = zeros(1, Ts);     
end;

% handle resources
if isfield(initial_dynamics, 're'), 
    set_initial_resources(initial_dynamics);
else
    PN.system_resources = [];
    PN.No_of_system_resources = 0;
    PN.Resource_usage_LOG = [];
end;
