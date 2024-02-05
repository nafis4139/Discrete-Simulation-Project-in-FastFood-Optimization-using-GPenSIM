function [Sum_Firing_cost] = CostOfFirings(PN) 
% function [Sum_Firing_cost] = CostOfFirings(PN) 
% function [Sum_Firing_cost] = Costs-Of-All-Firings(PN) 
%

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 16 March 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = PN.No_of_transitions;

Sum_Firing_cost = 0; % initially

if not(PN.Firing_Costs_Enabled)
    return
end

for ti = 1:Ts
    Sum_Firing_cost = Sum_Firing_cost + ...
        PN.Set_of_Firing_Costs_Fixed(ti) * ...
        PN.global_transitions(ti).times_fired; 
    % WARNING: firing_time(ti) is average firing time, if it is
    %   stochastic; e.g. 'unifrnd(5,7)'
    Sum_Firing_cost = Sum_Firing_cost + ...
        PN.Set_of_Firing_Costs_Variable(ti) * ...
        PN.global_transitions(ti).times_fired * get_firingtime(ti);
end