function [] = prnsys(sim, ini_dynamics)
% function [] = prnsys (sim, ini_dynamics)
%    Print system info 

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
PN = sim;

Ps = PN.No_of_places;
Ts = PN.No_of_transitions;

if isfield(PN, 'No_of_control_places')
    Cs = PN.No_of_control_places;
else Cs = 0;
end

disp(' ');
disp('======= Process Composition ======= ');
disp(['There are ', int2str(Ps-Cs), ' process places']);
disp(['There are ', int2str(Ts), ' process transitions']);
if Cs, disp(['There are ', int2str(Cs), ' control places']); end

% Add the number of arcs (connections)to PN
indices = find(PN.incidence_matrix ~= 0);
No_of_arcs = numel(indices);
disp(['There are ', int2str(No_of_arcs ), ' normal arcs']);
disp(' ');

disp(['Process Petri Net: ', PN.name]);
prnsys_connection;

X = zeros(1, Ps); % initial assumption
if eq(nargin, 2)
    X = get_initial_marking(ini_dynamics); % intial marking
    disp(' '); disp('Initial markings on the Process places: ');
    str = markings_string (X, [1 Ps-Cs]); 
    disp(str); disp(' ');
end

if Cs
    print_controller_info(X);
end
