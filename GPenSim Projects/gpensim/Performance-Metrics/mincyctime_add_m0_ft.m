function [V] = mincyctime_add_m0_ft(pni, V)
% function [V] = mincyctime_add_m0_ft(pni, V)
%
% Purpose: 
% Prepare for finding the minimum cycle (critical circuit), by
% adding tokens and firing times to the circuits
%
% Used by (solely): mincyctime
%  
%       Reggie.Davidrajuh@uis.no (c) February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

No_of_nodes = length(V.nodes);
Ps = pni.No_of_places;
Ts = pni.No_of_transitions;
if not(eq(No_of_nodes, Ps+Ts)),
    disp('Something went wrong in converting PN into G');
    error('"No_of_nodes" NOT equal to "pni.Ps + pni.Ts"');
end

% init each place node with imarkings 
for i = 1:Ts,
    V.nodes(i).imarkings = 0; 
    V.nodes(i).firing_time = pni.Set_of_Firing_Times(i);
end

% init each transition node with and firing_time 
for i = Ts+1:No_of_nodes,
    V.nodes(i).imarkings = pni.X(i-Ts); 
    V.nodes(i).firing_time = 0;
end