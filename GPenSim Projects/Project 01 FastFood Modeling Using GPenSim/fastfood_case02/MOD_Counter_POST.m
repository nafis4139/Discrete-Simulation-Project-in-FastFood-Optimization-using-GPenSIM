function [] = MOD_Counter_POST (transition)
global PN
%disp(transition.name);
disp(['In Counter Post enabled trans is: ', transition.name]);
disp(markings_string(PN.X));
release(); %Release all resources after firing