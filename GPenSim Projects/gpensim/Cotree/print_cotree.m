function [] = print_cotree(COTREE, time_and_cost)
%        [] = print_cotree(COTREE, time_and_cost)
% Purpose:	To print cotree structure 
% Input parameters:	Cotree structure (the structure output by ‘cotree’)
% Uses:	print_markings 
% Used by:	cotree
% Example:	
%   % in main simulation file
%   cotree_structure = cotree(png, dyn.initial_markings);
%   print_cotree(cotree_ structure);
 
%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
Ps = PN.No_of_places; 

if lt(nargin, 2)
    time_and_cost = 0;   % no time and cost info
end
    
no_of_rows = size(COTREE, 1);

disp(''); disp(''); 
if (time_and_cost)
    disp(' ======= Extended Reachability Tree ======= '); 
else
    disp(' ======= Coverability Tree ======= '); 
end

disp('');

%%%%% ROOT node
Current_row = COTREE(1,:);   
X = Current_row(:, 1:Ps);   % Type = Current_row(:, Ps+3); % double('R')
disp('State no.: 1  ROOT node');
disp(markings_string(X)); disp(' '); 

Terminal_States = []; % for storing terminal states

%%%%% Main Loop: 
for i = 2:no_of_rows
   Current_row = COTREE(i,:);
   X = Current_row(:, 1:Ps);
   firing_event = Current_row(:, Ps+1);
   firing_event_name = PN.global_transitions(firing_event).name;
   Parent_row = Current_row(:, Ps+2);
   Type = Current_row(:, Ps+3); 
   
   if (~Type), Type = double(' '); end
   disp(['State no.: ',num2str(i),'    ','Firing event: ',firing_event_name]); 
   if time_and_cost
       state_time = Current_row(:, Ps+4);
       state_cost = Current_row(:, Ps+5);
       disp(['Time of the state: ', num2str(state_time)]); 
       disp(['Cost of the state: ', num2str(state_cost)]); 
   end
       
   disp(['State: ', markings_string(X)]); 
   fprintf('Node type: ''%c''   Parent state: %d\n\n',...
       char(Type), Parent_row);
   if strcmp(char(Type), 'T')
       Terminal_States = [Terminal_States i];
   end
end

if (time_and_cost)
    return
end

if PN.Inhibitors_exist
    % summary on Boundedness & Liveness are only for P/T Petri nets
    return
end

disp(' '); disp('Boundedness:');
for i = 1:Ps
    markings = COTREE(:,i); 
    upper_bound = max(markings);
    disp([PN.global_places(i).name, ' : ', num2str(upper_bound)]);
end

disp(' '); disp('Liveness:');
if isempty(Terminal_States)
    disp('No Terminal States found: The system is Live');
else
    disp(['Terminal States: [', num2str(Terminal_States), ']']);
end
