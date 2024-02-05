function [] = priorset(trans_name, value)
% function [] = priority_set(trans_name, value)
% assign (set) a value as priority to a transition 

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

tx = check_valid_transition(trans_name);
PN.priority_list(tx) = value;
