function [HEL] = priority_compare(trans1, trans2) 
% function [HEL] = priority_compare(trans1, trans2) 
%
% This function compares priority of trans1 with trans2.
%
% Inputs:   PN : PN structure
%           trans1, trans2: the transitions (Names or Numbers)
% Output:   HEL = 1  if priority of trans1 > trans2
%           HEL = 0  if priority of trans1 = trans2
%           HEL = -1 if priority of trans1 < trans2


%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

if ischar(trans1),  trans1 = check_valid_transition(trans1); end;
if ischar(trans2),  trans2 = check_valid_transition(trans2); end;

PList = PN.priority_list;

if gt(PList(trans1), PList(trans2)), 
    HEL = 1;
elseif eq(PList(trans1), PList(trans2)), 
    HEL = 0;
else
    HEL = -1;
end;

