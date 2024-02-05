function [] = prnss (SimResults)  
% function [] = prnss(SimResults)  
%        Print State Space information
%
% Purpose:	
%   To print simulation results
%
% Arguments:
%   Inputs:	Simulation Results (a structure output by ‘gpensim’)
%   Outputs:     (none)
%
% Functions called:	
%       prnss_enabled_and_firing_trans, prnss_state
%
% Used by:	[main simulation file]
% 
% Usage:	
% % in main simulation file
%   simResults = gpensim(png, dynamic);
%   prnss(simResults );
%   (utility) string_HH_MM_SS

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% current_markings =  1:Ps;     % fired_trans_index = Ps + 1;     
% state_index = Ps + 2;         % Prev_state_index = Ps + 3;      
% FTS_index = Ps + 4;           % Start_Time_index = Ps + 5;      
% Stop_Time_index = Ps + 6;     % virtual_tokens =  Ps+7 : end; 

global PN;
PN = SimResults;

Ps = PN.No_of_places;

disp(' '); disp(' '); 
disp(['Simulation of "', PN.name, '":']);
disp(' ======= State Diagram ======= ');
HH_MM_SS = PN.HH_MM_SS; % printing style for time 

% xlswrite('pn_log.xls', PN.LOG);  % Testing purposes only

len_ETS = size(PN.Enabled_Trans_SET, 1);

start_time = PN.LOG(1, Ps+5);
if (HH_MM_SS),     disp(['**    Time: ', string_HH_MM_SS(start_time), '   **']);
   else disp(['**    Time: ', num2str(start_time), '   **']); 
end;

initial_markings = PN.LOG(1, 1:Ps); % print initial state
disp(['State:0 (Initial State): ', markings_string(initial_markings)]); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enabled and firing transitions at start
ETS_index = 1;
if (len_ETS), 
    disp('At start ....');
    prnss_enabled_and_firing_trans(ETS_index);
end;
% end of change -1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


no_of_rows = size(PN.LOG, 1); 
for i = 2:no_of_rows, 
    current_row = PN.LOG(i, :);
    fired_trans = current_row(Ps+1);
    if (fired_trans),
        state = current_row(Ps+2);
        ETS_index = current_row(Ps+4); 
        start_time = current_row(Ps+5);
        finishing_time = current_row(Ps+6); 
%        disp(' '); disp('Just before new state ....');
%        print_statespace_enabled_and_firing_trans(ETS_index-1);
        current_markings = current_row(1:Ps); 
        virtual_tokens = current_row(Ps+7:end); 
        prnss_state(fired_trans, finishing_time, ...
                current_markings,state, virtual_tokens);
            
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % change - 2 
        if gt(len_ETS, ETS_index), 
            disp(' '); 
            disp(['Right after new state-', int2str(state), ' ....']);
            prnss_enabled_and_firing_trans(ETS_index+1);
            disp(' '); 
        end;
        % end of change -1 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
    end;
end;    
disp(' '); disp(' ');
