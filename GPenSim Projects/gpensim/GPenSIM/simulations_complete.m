function [SIM_COMPLETE]  = simulations_complete(Loop_Nr,MAX_LOOP)
% function [SIM_COMPLETE]=  simulations_complete(Loop_Nr, MAX_LOOP)
%
% This function determines whether to terminate simulations
%
% Queue_is_Empty = isempty(EIP);
% No_enabled_transitions = ~any(any_enabled_transitions(pn));
% Que_is_Empty_and_No_enabled_Transitions = and(Queue_is_Empty, ...
%                                No_enabled_transitions);                 
% Max_Loop_Number_Reached = ge(Loop_Nr, MAX_LOOP); 
%
%
% SIM_COMPLETE_1 = or(Que_is_Empty_and_No_enabled_Transitions, ...
%                Max_Loop_Number_Reached);
%
% SIM_COMPLETE_2 = 0;
% if isfield(global_info, 'STOP_SIMULATION'),
%     SIM_COMPLETE_2 = global_info.STOP_SIMULATION; % forced stopping 
% end;
%
% SIM_COMPLETE = or(SIM_COMPLETE_1, SIM_COMPLETE_2);

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global global_info
global PN

Max_Loop_Number_Reached = ge(Loop_Nr, MAX_LOOP); 

Stop_Simulation1 = 0;
if isfield(global_info, 'STOP_SIMULATION'),
    Stop_Simulation1 = global_info.STOP_SIMULATION; % forced stopping 
end

Stop_Simulation2 = 0;
if isfield(PN, 'STOP_TIME'),
    if ~isnan(PN.STOP_TIME),
        Stop_Simulation2 = ge(current_time(), ...
                              PN.STOP_TIME); % given stop time
        Max_Loop_Number_Reached = 0; % DO NOT consider MAX_LOOP !!!!!!!!
    end
end

Stop_Simulation = or(Stop_Simulation1, Stop_Simulation2);
SIM_COMPLETE = or(Max_Loop_Number_Reached, Stop_Simulation);
