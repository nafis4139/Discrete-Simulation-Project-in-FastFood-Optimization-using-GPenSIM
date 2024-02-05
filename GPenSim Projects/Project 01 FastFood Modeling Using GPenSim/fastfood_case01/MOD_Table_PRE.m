function [fire, transition] = MOD_Table_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In Table PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));

if strcmp(transition.name, 'tTabByPass')
    fire= ge(ntokens('pTabQue'),global_info.TabQueCap);
elseif strcmp(transition.name, 'tTabFind')
    fire = le(ntokens('pTabInUse'),global_info.TabAvaialble);
end
    
