function [] = print_statespace_enabled_trans(enabled_trans, checking_time)
%        [] = print_statespace_enabled_trans(enabled_trans, checking_time)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if (PN.HH_MM_SS),
    Set_fev = ['At time: ', string_HH_MM_SS(checking_time),...
                 ',  Enabled transitions are: '];
else
    Set_fev = ['At time: ', num2str(checking_time), ...
                 ',  Enabled transitions are: ']; 
end;

% row - 2: Enabled Transitions
et_index = find(enabled_trans);

for j = 1:length(et_index),
    etn = et_index(j);
    enabled_event_name = PN.global_transitions(etn).name; 
    Set_fev = [Set_fev, '   ',enabled_event_name]; 
end;

disp(Set_fev);    
