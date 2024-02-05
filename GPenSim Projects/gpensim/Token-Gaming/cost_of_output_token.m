function [output_token_cost] = cost_of_output_token(t1, additonal_cost, ...
                                resource_usage_cost, inherited_costs)
% [output_token_cost] = cost_of_output_token(t1, additonal_cost, ...
%                               resource_usage_cost, inherited_costs)

global PN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPORTANT: variable firing cost is added only aposterori 
%                 (not in this function)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp(' ');
%disp('inside "cost_of_output_token" ...');
%disp(['Firing trans: ', PN.global_transitions(t1).name]);

Ps = PN.No_of_places;
A =  PN.incidence_matrix; 

% token depositis to output place
output_weigths = A(t1,Ps+1:end); % extracting weight of output arcs 
out_weights = sum(output_weigths);

fixed_firing_cost = PN.Set_of_Firing_Costs_Fixed(t1);
variable_firing_cost = PN.Set_of_Firing_Costs_Variable(t1);    
% disp(['Firing cost        : ', int2str(firing_cost)]);
% disp(['Additonal cost     : ', int2str(additonal_cost)]);
% disp(['Resource usage cost: ', int2str(resource_usage_cost)]);
% disp(['Inherited costs    : ', int2str(inherited_costs)]);

total_costs = fixed_firing_cost + (variable_firing_cost* get_firingtime(t1)) + ...
              additonal_cost + resource_usage_cost + inherited_costs;
%disp(['Total costs: ', num2str(total_costs)]);
output_token_cost = total_costs / out_weights;

%disp(['Cost of output token: ', num2str(output_token_cost)]); 

