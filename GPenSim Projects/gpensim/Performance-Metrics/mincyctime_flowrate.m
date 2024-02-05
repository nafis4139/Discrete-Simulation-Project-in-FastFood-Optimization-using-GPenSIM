function [] = mincyctime_flowrate(max_value)
% function [] = mincyctime_flowrate(max_value)
%
% Purpose: 
%    Just to the print the flow rate
%
% Used by (solely): mincyctime
%
%       Reggie.Davidrajuh@uis.no (c) February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

current_flow_rate = 1/max_value;

disp(' ');
disp('***  Token Flow Rate:   ***');

disp('In steady state, the firing rate of each transition is:');
disp(['    1/C* = ', num2str(current_flow_rate)]);
disp(['meaning, on average, ', num2str(current_flow_rate), ' tokens pass through ']);
disp('any node in the Petri net, per unit period of time.');
disp(' ');