function [] = prnfinalcolors(Sim_Results, set_of_places)
% [] = prnfinalcolors (Sim_Results, set_of_places)
% 
% Name:	print_finalcolors
% Purpose:	To print colors of the final state 
%           (colors of the tokens that are left in the system 
%           when the simulations are complete)
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
% Out parameters:	None
% Uses:	
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   results = gpensim(pn, dynamicpart);
%   prnfinalcolors(results);
%
%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 14 June 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' '); disp('**** **** Colors of Final Tokens ...'); 

if eq(nargin, 1)
    set_of_pi = 1:Sim_Results.No_of_places;
elseif eq(nargin, 2)
    set_of_pi = check_valid_place(set_of_places);
else
    disp('Usage:  prnfinalcolors(Sim_Results, set_of_places); ');
    disp('E.g.: prnfinalcolors(Sim_Results, {"p1", "p2", "pE"}); ');
    return
end

Final_state = Sim_Results.X; % final state of the system
NoFinalTokens = sum(Final_state); % sum of the final tokens
if NoFinalTokens % there are final tokens left at the end of simulation
    disp(['No. of final tokens: ', int2str(NoFinalTokens)]);
else
    disp('There are NO final tokens left at the end of simulation ... ');
    return
end


for i = 1:length(set_of_pi)
    pi = set_of_pi(i);
    if not(Final_state(pi)) % there are NO final tokens in this place?
        continue
    end
    t_bank = Sim_Results.global_places(pi).token_bank;
    if not(isempty(t_bank))
        disp(' '); disp(['Place: ', pname(pi)]);
        for j = 1:length(t_bank)
            token = t_bank(j);
            ctime = token.creation_time;
            colors = token.color; 
            m = length(colors); 
            colorset = ' '; for k = 1:m, colorset = [colorset, '  "', colors{k},'" ']; end
            cost = token.cost;
            if isempty(colors)
                disp_str = ['Time: ',num2str(ctime),' *** NO COLOR ***'];
            else
                disp_str = ['Time: ',num2str(ctime),'    Colors: ', colorset];
            end % if isempty(colors),
            if cost, disp_str = [disp_str,  '   Cost: ', num2str(cost)];  end
            disp(disp_str);       
        end % for j = 1:length(t_bank),
    end % if not(isempty(t_bank)), 
end
