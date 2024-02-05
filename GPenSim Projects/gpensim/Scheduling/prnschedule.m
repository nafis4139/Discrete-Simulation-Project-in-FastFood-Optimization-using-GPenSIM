function [LE,RES_USAGE,completion_time,LT,Total_time_at_Ks] = prnschedule(PN)
%function [LE,RES_USAGE,completion_time,LT,Total_time_at_Ks]=prnschedule(PN)
%   print schedule
% For every resource utilized, this fundtion prints
% the transition that used the resource, start time  and end time
% of utilization

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 August 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LOG = PN.Resource_usage_LOG;
if isempty(LOG)
    LE =[];  RES_USAGE=[]; 
    disp('No resources used ...' )
    return
end

res = PN.system_resources;
Rs = PN.No_of_system_resources;
Ts = PN.No_of_transitions;
completion_time = PN.completion_time; %   wrong before:  LOG(end, end-1);

Sum_Resource_Cost = 0;

% process LOG file 
[RES_USAGE] = print_schedule_pLOG(PN);
%   RES_USAGE is [number_of_resources X 2] matrix
%       column-1: number of times each resource was used. 
%       column-2: total time of usage of each resource 

disp(' '); disp('RESOURCE USAGE SUMMARY: '); 
for i = 1:Rs
    res_name = res(i).name; 
    total_occasions = RES_USAGE(i,1);
    total_time = RES_USAGE(i,2);
    disp([res_name, ':  Total occasions: ', num2str(total_occasions), ...
        '   Total Time spent: ', num2str(total_time)]); 
    res_fcost = res(i).rc_fixed;
    res_vcost = res(i).rc_variable;
    resource_usage_cost = (total_occasions * res_fcost) + ...
                          (total_time * res_vcost); 
    if resource_usage_cost % not zero 
        disp([res_name, ':  Total resource usage cost: ', ...
        num2str(resource_usage_cost)]); 
    end
    Sum_Resource_Cost = Sum_Resource_Cost + resource_usage_cost;        
end

% Calculate Line Time (LT)
LT = 0; % Line Time (LT)
K = 0; % Total number of server instances
for i = 1:Rs
    instances = PN.system_resources(i).max_instances;
    K = K + instances;
    MAX_CAP = PN.system_resources(i).MAX_CAP;
    if isinf(MAX_CAP)
        LT = LT + (instances * completion_time);
    else
        LT = LT + (instances * MAX_CAP);
    end
end
Total_time_at_Ks = sum(RES_USAGE(:, 2));
LE = Total_time_at_Ks * 100/LT;  % line efficiency

% cost incurred due to transition firings
Sum_Firing_cost = CostOfFirings(PN);
Total_Costs = Sum_Resource_Cost + Sum_Firing_cost;

disp('  ');

disp('*****  LINE EFFICIENCY AND COST CALCULATIONS: *****');
disp(['  Number of servers:  k = ', num2str(Rs)]);
disp(['  Total number of server instances:  K = ', num2str(K)]);
disp(['  Completion = ', num2str(completion_time)]);
disp(['  LT = ', num2str(LT)]);
disp(['  Total time at Stations: ', num2str(Total_time_at_Ks)]);
disp(['  LE = ', num2str(LE), ' %']);
%disp(['  SI = ', num2str(SI)]);
disp('  ** ');
disp(['  Sum resource usage costs: ', num2str(Sum_Resource_Cost), ...
    '   (', num2str(Sum_Resource_Cost*100/Total_Costs), '% of total)']);
disp(['  Sum firing costs: ', num2str(Sum_Firing_cost), ...
    '   (', num2str(Sum_Firing_cost*100/Total_Costs), '% of total)']);
disp(['  Total costs:  ', num2str(Total_Costs)]);
disp('  ** ');

