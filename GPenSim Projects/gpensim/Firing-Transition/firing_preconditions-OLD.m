function [sfc, new_color,override,selected_tokens, additional_cost] = ...
        firing_preconditions(t1)
% [sfc] = firing_preconditions(transition1)
% (any pre-conditions for firing?) 
% 
% This functions checks whether user-defined (if any) 
% conditions are satisfied before firing a transition. 
% The user-defined conditions are defined in TDF 
% 
% Define variables: 
% Inputs:  transition1 : index of the transition inside PN
%
% Output: Boolean value (true/false), based on whether 
% 		user-defined conditions are met or not.
%
% Functions called: 
%         	(feval) 
% 

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global PN;

new_color = {};
override = 0; % by default, do not override earlier colors
selected_tokens = [];
additional_cost = 0; 

% first, check whether COMMON_PRE file exist
if PN.COMMON_PRE,
    [sfc1, new_color1, override1, selected_tokens1, additional_cost1] = ...
        firing_preconditions_COMMON_PRE(t1);
    new_color = new_color1;
    override = override1; 
    selected_tokens = selected_tokens1;
    additional_cost = additional_cost1;
else
    sfc1 = 1;  % in case no COMMON_PRE
end;

% second, check whether specific TDF _PRE file exist
if PN.PRE_exist(t1),
    [sfc2, new_color2, override2, selected_tokens2, additional_cost2] = ...
        firing_preconditions_specific_pre(t1);
    
    new_color = union(new_color, new_color2);
    override = or(override, override2); 
    selected_tokens = [selected_tokens selected_tokens2];
    additional_cost = additional_cost + additional_cost2;
else
    sfc2 = 1;    % if no TDF, then always fire if enabled. 
end;

sfc = and(sfc1, sfc2); % satisified firing conditions 
