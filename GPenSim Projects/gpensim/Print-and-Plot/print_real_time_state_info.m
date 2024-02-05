function [] = print_real_time_state_info()
% function [] = print_real_time_state_info()
%
%      Reggie Davidrajuh (c) AUgust 2011

global PN;

if eq(PN.X, PN.REAL_TIME_PREV_X),
    return
end;

disp(' ');
% print time
if (PN.HH_MM_SS), 
    disp(['    Time: ', string_HH_MM_SS(PN.current_time)]);
else
    disp(['    Time: ', num2str(PN.current_time)]);
end;

disp(['Current State: ', int2str(PN.X)]);
PN.REAL_TIME_PREV_X = PN.X;

% print firing transitons state change 
ft_index = find(PN.Firing_Transitions);
if not(isempty(ft_index)),
    Set_fev = [];
    for i = 1:length(ft_index),
        ftn = ft_index(i);
        firing_event_name = PN.global_transitions(ftn).name;
        Set_fev = [Set_fev, ' ',firing_event_name]; 
    end;
    disp(['Firing Transitions: ', Set_fev]);
end;



% print enabled transitons state change 
et_index = find(PN.Enabled_Transitions);
if not(isempty(et_index)),
    Set_Eev = [];
    for i = 1:length(et_index),
        etn = et_index(i);
        Enabled_event_name = PN.global_transitions(etn).name;
        Set_Eev = [Set_Eev, ' ',Enabled_event_name]; 
    end;
    disp(['Enabled Transituions: ', Set_Eev]);
end;

disp(' ');
