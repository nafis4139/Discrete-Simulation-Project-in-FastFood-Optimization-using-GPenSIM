function [] = print_statespace_enabled_and_firing_trans(ETS_index)
% function [] = print_statespace_enabled_and_firing_trans(ETS_index)

%  Reggie.Davidrajuh@uis.no (c) Version 7.0 (c) 10 Sept 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

event_time = PN.Enabled_Trans_SET(ETS_index, 1);

enabled_trans = PN.Enabled_Trans_SET(ETS_index, 2:end);
firing_trans  =  PN.Firing_Trans_SET(ETS_index, 2:end);

prnss_enabled_trans(enabled_trans, event_time); % 
prnss_firing_trans(firing_trans, event_time);   % 
