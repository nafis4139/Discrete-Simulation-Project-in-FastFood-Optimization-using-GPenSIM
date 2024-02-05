function [Ts,EIP,LOG,colormap,Enabled_Trans_SET, ...
    Firing_Trans_SET,SIM_COMPLETE,Loop_Nr,ETS_index,FTS_index] = ...
    gpensim_init_all()
% function [Ts,EIP,LOG,colormap,Enabled_Trans_SET, ...
%    Firing_Trans_SET,SIM_COMPLETE,Loop_Nr,ETS_index,FTS_index] = ...
%          gpensim_init_all()
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global PN

Ts = PN.No_of_transitions; % number of tansitions

EIP = []; % Queue for events_in_progress; initially, no events in Q

%global recording of events
% LOG: [Initial_state, 
%            fired_transition, State_number, Prev_state, FTS_index, 
%      Start_Time, Stop_Time, aTokens]
% Total length = Ps + 6 + Ps
aTokens = PN.VX;   % absorbed tokens in Virtual places
LOG = [PN.X, 0, 0, 0, 0, PN.current_time, PN.current_time, aTokens];  

colormap = [];
Enabled_Trans_SET = []; % Log for global set of enabled trans
Firing_Trans_SET = []; % Log for global set of firing trans
ETS_index = 0; % index of last Log for global set of enabled trans
FTS_index = 0; % index of last Log for global set of firing trans

PN.Firing_Transitions = zeros(1, Ts);  % firing transitions
PN.Enabled_Transitions = zeros(1, Ts); % enabled transitions
PN.State = 0;

SIM_COMPLETE = 0; % simulation is not complete, just for starting
Loop_Nr = 0;
