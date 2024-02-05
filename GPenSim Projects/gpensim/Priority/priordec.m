function [] = priority_decrement(trans_name, value)
%        [] = priority_decrement(trans_name, value)

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

tx = check_valid_transition(trans_name);

if eq(nargin, 1), value = 1; end;

PN.priority_list(tx) = PN.priority_list(tx) - value;

