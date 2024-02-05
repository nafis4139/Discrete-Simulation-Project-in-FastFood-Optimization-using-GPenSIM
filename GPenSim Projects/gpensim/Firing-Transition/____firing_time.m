function ftime = firing_time(t1)
% function ftime = firing_time(t1)

global PN;

ftime = PN.Set_of_Firing_Times(t1);
if isnan(ftime),  % firing time is a string; e.g. 'unifrnd(10, 12)'
    trans = PN.global_transitions(t1);
    ftime = eval(trans.firing_time);
end;

