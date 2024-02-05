function [] = set_firing_times_delta_T() 
% function [] = set_firing_times_delta_T() 
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

% now set the delta_T 
if isnan(PN.delta_T),
    minimum_ft = inf;
    for i = 1:Ts,
        ft = PN.global_transitions(i).firing_time;
        if ischar(ft), ft = eval(ft); end;
        if lt(ft, minimum_ft), minimum_ft = ft; end;
    end;
    PN.delta_T = 0.25 * minimum_ft;
    
elseif eq(PN.delta_T, 0),  
    % OPTION DELTA_TIME is given as zero
    % perhaps this is for a timeless system; so, keep the value
else
    % OPTION DELTA_TIME is assigned in the MSF
    % disp(['png.delta_T = ', num2str(png.delta_T)]);     
end;

