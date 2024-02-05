function [] = pack_sim_results(Enabled_Trans_SET, Firing_Trans_SET, ...
                        LOG, colormap)
% function [] = pack_sim_results(Enabled_Trans_SET, Firing_Trans_SET, ...
%                        LOG, colormap)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

%Ps = PN.No_of_places;      % number of places
Ts = PN.No_of_transitions; % number of tansitions

% final enabled trans
for i = 1:Ts, PN.Enabled_Transitions(i) = enabled_transition(i); end;

Enabled_Trans_SET = [Enabled_Trans_SET;       % *** NOTE: APOSTERORI ***
    PN.current_time, PN.Enabled_Transitions]; % LOG global set of enabled 
Firing_Trans_SET = [Firing_Trans_SET;
    PN.current_time, PN.Firing_Transitions]; % global set of enabled     

% pack the results
PN.LOG = LOG;
PN.Firing_Trans_SET = Firing_Trans_SET;
PN.Enabled_Trans_SET = Enabled_Trans_SET;
PN.color_map = colormap;
PN.completion_time = PN.current_time;
PN.overall_no_of_tokens_used = PN.token_serial_numer;
%PN.final_tokens = get_all_tokens;
