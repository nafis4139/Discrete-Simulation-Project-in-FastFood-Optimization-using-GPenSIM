function [ordered_enabledTs] = priority_enabled_trans(enabledTrans)
%        [ordered_enabledTs ] = priority_enabled_trans(enabledTrans)
%
% This function will sort out enabled transitions in 
% decending order of priority 
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

Ts = PN.No_of_transitions;

PList = PN.priority_list;
[dont_care, t_index] = sort(PList, 'descend');

ordered_enabledTs = [];
for i=1:Ts,
    if ismember(t_index(i), enabledTrans),
        ordered_enabledTs = [ordered_enabledTs t_index(i)];
    end;
end;
