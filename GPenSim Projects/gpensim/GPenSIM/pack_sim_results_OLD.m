function [sim_results] = pack_sim_results(...
    Enabled_Trans_SET, Firing_Trans_SET, LOG, colormap)
% function [sim_results] = pack_sim_results(...
%   Enabled_Trans_SET, Firing_Trans_SET, LOG, colormap)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

disp('inside: pack_sim_results'); 
PN

Ps = PN.No_of_places;      % number of places
Ts = PN.No_of_transitions; % number of tansitions

% final enabled trans
for i = 1:Ts, PN.Enabled_Transitions(i)=enabled_transition(i); end;

Enabled_Trans_SET = [Enabled_Trans_SET;       % *** NOTE: APOSTERORI ***
    PN.current_time, PN.Enabled_Transitions]; % LOG global set of enabled 
Firing_Trans_SET = [Firing_Trans_SET;
    PN.current_time, PN.Firing_Transitions]; % global set of enabled     

% pack the results
sim_results.type = 'simulation';  
sim_results.LOG = LOG;
sim_results.Firing_Transitions  = Firing_Trans_SET;
sim_results.Enabled_Transitions = Enabled_Trans_SET;
sim_results.color_map = colormap;
sim_results.completion_time = PN.current_time;
sim_results.overall_no_of_tokens_used = PN.token_serial_numer;
sim_results.HH_MM_SS = PN.HH_MM_SS; % Hour-Min-Sec flag

PNames = []; 
for i=1:Ps, 
    PNames = [PNames; good_name(PN.global_places(i).name)];
end;

TNames = [];
for i=1:Ts, 
    TNames = [TNames; good_name(PN.global_transitions(i).name)]; 
end;

sim_results.Place_Names = PNames; 
sim_results.Transition_Names = TNames; 
sim_results.final_tokens = get_final_tokens(PN);
sim_results.No_of_places = Ps;
sim_results.No_of_transitions = Ts;
sim_results.resources = PN.resources;
