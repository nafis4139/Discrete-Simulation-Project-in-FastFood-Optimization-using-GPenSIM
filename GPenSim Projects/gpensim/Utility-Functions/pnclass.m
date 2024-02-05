function [classtype] = pnclass(PN)
% function [classtype] = pnclass(png)
%       PetriNetClass
% Purpose:
% This function checks the class of Petri net. 
% This function returns a vector of flags representing 
% the following information (output variable classtype):
%   flag-1: Binary PN
%   flag-2: PN State Machine
%   flag-3: Marked (Event) Graph
%   flag-4: Timed Petri Net
%   flag-5: Number of Strongly Connected components%
% 
% Uses:
%   SCC = stronglyconn(PN)   % strongly connected components
%
% Used by: MSF
%
%       Reggie.Davidrajuh@uis.no (c) February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = PN.No_of_places;  Ts = PN.No_of_transitions;
A = PN.incidence_matrix;
classtype = zeros(1, 8); % prepare to store class info

disp([' **** ', PN.name, ' ****']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flag-1: Binary PN
% In a Binary PN, all the arc weights are delfault '1'
max_arc_weight = max(max(A));
classtype(1) = eq(max_arc_weight, 1);% set flag for Binary PN
if classtype(1), 
    disp('This is a Binary Petri Nets.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flag-2: PN State Machine
% In a PN State Machine, every transition has exactly 
%     one input and one output place
Ainn = A(:, 1:Ps);  Aout = A(:, Ps+1:2*Ps);
PNSM = 1; % initial assumption
i = 1;
while and(le(i, Ts), PNSM), % check every transition, one by one 
    rowinn = Ainn(i,:);    rowout = Aout(i,:);
    no_of_input_places = length(find(rowinn));
    no_of_output_places = length(find(rowout));
    PNSM = and(eq(no_of_input_places, 1), eq(no_of_output_places, 1));
    i = i + 1;
end

if PNSM, 
    disp('This is a Petri Net State Machine.');
    classtype(2) = 1; % set flag for Petri Net State Machine
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flag-3: Event Graph (Marked Graph)
% In a Event Graph, every place has exactly 
%     one input and one output transition
AinnT = Ainn';  AoutT = Aout';
PNEG = 1; % initial assumption
i = 1;
while and(le(i, Ps), PNEG), % check every place, one by one 
    rowinn = AinnT(i,:);    rowout = AoutT(i,:);
    no_of_input_Ts = length(find(rowinn));
    no_of_output_Ts = length(find(rowout));
    PNEG = and(eq(no_of_input_Ts, 1), eq(no_of_output_Ts, 1));
    i = i + 1;
end

if PNEG, 
    disp('This is an Event Graph (Marked Graph).');
    classtype(3) = 1; % set flag for Marked (Event) Graph
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flag-4: Timed/untimed Petri net
% Timed petri net: at least one firing time is non-zero
Timed_PN = false;
if isfield(PN, 'Set_of_Firing_Times'),
    Timed_PN = any(PN.Set_of_Firing_Times);
end
classtype(4) = Timed_PN; % Timed or untimed Petri net
if Timed_PN,
    disp('This is a Timed Petri net.');
else
    disp('This is an untimed Petri net.');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flag-5: strongly connectedness 
SCC = stronglyconn(PN); % find the strongly connected components
classtype(5) = size(SCC,1); % number of strongly connected components
