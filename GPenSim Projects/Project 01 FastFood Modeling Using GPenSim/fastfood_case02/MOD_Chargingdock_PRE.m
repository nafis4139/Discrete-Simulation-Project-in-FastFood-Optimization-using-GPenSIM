function [fire, transition] = MOD_Chargingdock_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In CD PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));

% Assignining "Service Type" Color in tCounterEnter transition
if strcmp(transition.name, 'tCDFindDock')
    fire = le(ntokens('pCDInUse'),global_info.CDAvaialble);
elseif strcmp(transition.name, 'tCDByPass')
    fire= ge(ntokens('pCDQue'),global_info.CDQueCap);
end
    