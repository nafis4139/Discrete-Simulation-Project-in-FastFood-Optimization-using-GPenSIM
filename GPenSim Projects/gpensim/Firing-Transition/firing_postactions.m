function [] = firing_postactions()
% [global_info] = firing_postactions()
% (any post-actions after firing?) 
% 
% This functions checks whether user-defined (if any) 
% conditions are satisfied before firing a transition. 
% The user-defined conditions are defined in TDF 
% 
%
% Functions called: 
%         	(feval) 

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN
fired_transition = PN.completing_trans;

% get the name of the fired transition
name = PN.global_transitions(fired_transition).name;
transition.name = name; %new structure as input parameter for _POST files

% First, if specific TDF file for post actions exist, then run it
if PN.POST_exist(fired_transition),
    funcname = [name '_post'];
    feval(str2func(funcname), transition);
end

% Second, if MOD_POST file for post actions exist, then run it
module_of_t1 = PN.module_membership(1, fired_transition);
if module_of_t1, % trans is a member of a module
    mname = PN.module_names{module_of_t1}; 
    if PN.MOD_POST_exist(module_of_t1),
        funcname = ['MOD_', mname '_POST'];
        feval(str2func(funcname), transition);
    end 
end

if module_of_t1, % this trans belongs to a module,
    if not(PN.module_membership(2, fired_transition)), % but NOT an input/output port
        return
    end
end

% Third, if COMMON POST actions exist, then run it
if PN.COMMON_POST,
    funcname = 'COMMON_POST';
    feval(str2func(funcname), transition);
end