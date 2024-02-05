function [sfc, new_color,override,selected_tokens, additional_cost] = ...
        firing_preconditions
% [sfc] = firing_preconditions
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

global PN
t1 = PN.attempting_trans;

new_color = {};
override = 0; % by default, do not override earlier colors
selected_tokens = [];
additional_cost = 0; 

% first, check specific_pre conditions, if exist
if PN.PRE_exist(t1)
    [sfc, new_color1, override1, selected_tokens1, additional_cost1] = ...
        firing_preconditions_specific_pre;
    new_color = new_color1;
    override = override1; 
    selected_tokens = selected_tokens1;
    additional_cost = additional_cost1;
else
    sfc = 1;  % in case no specifc_pre file exist
end;

% if conditions in the specific_pre are NOT satisfied, 
%      then no point in to continue with COMMON_PRE
% !!!!! Wrong: MOD_PRE and COMMON_PRE can do some common actions

% Second, check MOD_PRE conditions, if exist
sfc2 = 1;    % initial assumption
module_of_t1 = PN.module_membership(1, t1);
if (module_of_t1) % this trans belongs to a module
    if PN.MOD_PRE_exist(module_of_t1) % if _pre file for this module exist
        [sfc2, new_color2, override2, selected_tokens2, additional_cost2] = ...
            firing_preconditions_MOD_PRE;
        new_color = union(new_color, new_color2);
        override = or(override, override2); 
        selected_tokens = [selected_tokens selected_tokens2];
        %     %%%%%%%%%  purge slected tokens (get rid of 0s)
        %     selected_tokens = selected_tokens(any(selected_tokens));
        additional_cost = additional_cost + additional_cost2;
    end % if PN.MOD_PRE_exist(module_of_t1), 
end; 

if (module_of_t1) % this trans belongs to a module,
    if not(PN.module_membership(2, t1)) % but NOT an input/output port
        % no COMMON_PRE
        sfc = and(sfc, sfc2); % satisified firing conditions 
        return
    end
end
        
     

% Third, check COMMON_PRE conditions, if exist
if PN.COMMON_PRE,
    [sfc3, new_color3, override3, selected_tokens3, additional_cost3] = ...
        firing_preconditions_COMMON_PRE;
    
    new_color = union(new_color, new_color3);
    override = or(override, override3); 
    selected_tokens = [selected_tokens selected_tokens3];
%     %%%%%%%%%  purge slected tokens (get rid of 0s)
%     selected_tokens = selected_tokens(any(selected_tokens));
    additional_cost = additional_cost + additional_cost3;
else
    sfc3 = 1;    % if no COMMON_PRE then always fire if enabled. 
end;

sfc = and(and(sfc, sfc2), sfc3); % satisified firing conditions 
