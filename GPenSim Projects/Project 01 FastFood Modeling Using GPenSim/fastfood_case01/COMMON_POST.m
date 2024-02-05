function [] = COMMON_POST (transition)
global PN
%disp(transition.name);
disp(['In Common POST enabled trans is: ', transition.name]);
disp(markings_string(PN.X));
release(); %Release all resources after firing