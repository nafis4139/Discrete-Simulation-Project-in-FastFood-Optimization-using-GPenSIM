function [] = print_statespace_firing_trans(firing_trans, checking_time)
%        [] = print_statespace_firing_trans(firing_trans, checking_time)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if (PN.HH_MM_SS),
    Set_fev = ['At time: ', string_HH_MM_SS(checking_time), ...
               ',  Firing transitions are:  '];
else
    Set_fev = ['At time: ', num2str(checking_time), ...
               ',  Firing transitions are:  '];
end;

ft_index = find(firing_trans);

for k = 1:length(ft_index),
    ftn = ft_index(k);
    firing_event_name = PN.global_transitions(ftn).name;
    Set_fev = [Set_fev, '   ', firing_event_name]; 
end;

disp(Set_fev);

