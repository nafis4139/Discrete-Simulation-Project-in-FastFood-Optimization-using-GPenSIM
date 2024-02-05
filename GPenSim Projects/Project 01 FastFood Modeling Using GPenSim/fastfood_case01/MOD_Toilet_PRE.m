function [fire, transition] = MOD_Toilet_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In Toilet PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));

if strcmp(transition.name, 'tTIn')
    fire = le(ntokens('pTInUse'),global_info.TAvaialble);
elseif strcmp(transition.name, 'tTByPass')
    fire= ge(ntokens('pTQue'),global_info.TQueCap);
end