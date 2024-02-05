function [] = set_firing_times(ftimes) 
%        [] = set_firing_times(ftimes) % firing times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts a group of elements from a given inputs of
% global_elements and elements. The resulting output is an element matrix.
% function elements_m = elements_matrix(pn.global_elements, elements)
% Inputs:
%       -global elements
%      - elements
% Output: elemets matrix

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
Ts = PN.No_of_transitions;
PN.Set_of_Firing_Times = zeros(1, Ts); 
no_of_fts = length(ftimes)/2; % number of firing times given
allOthers = 0; 

% extracting elements
% check whether the current elements is a member of global_elements
% sett in extracted element in the allocted matrix
% min_ft_but_not_zero = inf; %intially minimum-but-not-zero
for i = 1:no_of_fts,
    curr_trans_name = ftimes{2*i -1};
    if strcmpi(curr_trans_name, 'allothers'),
        allOthers = ftimes{2*i};
        continue;
    end;
        
    trans_nr = check_valid_transition(curr_trans_name); 
    ft = ftimes{2*i}; % get the firing time of transition
    PN.global_transitions(trans_nr).firing_time = ft;  
    
    if ischar (ft),  %firing time is a string; e.g. 'unifrnd(1,1)', 
        PN.Set_of_Firing_Times(trans_nr) = NaN;
    elseif eq(length(ft), 3),  %firing time is vector [hh mm ss]
        PN.HH_MM_SS = 1; % set Hour-Min-Sec flag
        ft2 = ft(3) + (60 * ft(2)) + (60 * 60 * ft(1)); % convert to seconds
        PN.global_transitions(trans_nr).firing_time = ft2;  % overrride
        PN.Set_of_Firing_Times(trans_nr) = ft2;
    else   % firing time is in time units (perhaps, seconds)
        PN.Set_of_Firing_Times(trans_nr) = ft;
    end;
end;

% check for any zero firing times AMONG non-zero firing times
% and warn if there are some firing times zero and others non-zero
set_firing_times_check_zero_ft(allOthers);

% set the global timer increment value "detla_T"
set_firing_times_delta_T();
