function [] = prnfinalcolorsSummary(Sim_Results, set_of_places)
% [] = prnfinalcolorsSummary(Sim_Results, set_of_places)
% 
% Name:	print_finalcolorsSummary
% Purpose:	To print colors of the final state 
%           (colors of the tokens that are left in the system 
%           when the simulations are complete)
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
% Out parameters:	None
% Uses:	None
% Used by:	[main simulation file]
% Example:	
%   % in main simulation file
%   results = gpensim(pn, dynamicpart);
%   print_finalcolors(results); 

disp(' '); disp(' ');
disp('Colors of Final Tokens (SUMMARY):'); 

% GRAND TOTAL
No_of_all_tokens = 0;
Set_of_all_colors = ' '; 
Costs_of_all_tokens = 0;    

if eq(nargin, 2),
    set_of_pi = [];
    for i = 1:length(set_of_places),
        pi = set_of_places{i};
        if ischar(pi), pi = check_valid_place(pi); end;
        set_of_pi = [set_of_pi pi];
    end;
else
    set_of_pi = 1:Sim_Results.No_of_places;
end;

for i = 1:length(set_of_pi),
    pi = set_of_pi(i);
    t_bank = Sim_Results.global_places(pi).token_bank;
    place_name = Sim_Results.global_places(pi).name;    
    
    No_of_tokens = 0;
    colorset = ' '; 
    Costs_of_tokens = 0;    
    if not(isempty(t_bank)),
        for j = 1:length(t_bank),
            token = t_bank(j);
            No_of_tokens = No_of_tokens + 1;
            ctime = token.creation_time;
            colors = token.color; 
            m = length(colors);
            for k = 1:m, colorset = union(colorset, colors{k}); end;
            %colorset = unique(colorset);
            cost = token.cost;
            Costs_of_tokens = Costs_of_tokens + cost;      
        end; % for j = 1:length(t_bank),
    end; % if not(isempty(t_bank)), 
    if No_of_tokens, 
        disp(' ');
        disp(['**** Place: ', place_name]); 
        disp(['Total number of tokens: ' int2str(No_of_tokens)]);
        if isempty(colors), 
            disp(' *** NO COLOR ***');
        else
            disp_str = '    Colors: '; 
            for l=1:length(colorset), disp_str = [disp_str,'  ', colorset(l)]; end;
            disp(disp_str);
        end; % if isempty(colors),
        disp(['Total cost of tokens: ', num2str(Costs_of_tokens)]);
    end
    % update GRAND SUM
    No_of_all_tokens = No_of_all_tokens + No_of_tokens;
    Set_of_all_colors = union(Set_of_all_colors, colorset); 
    Costs_of_all_tokens = Costs_of_all_tokens + Costs_of_tokens;        
end  % for i = 1:length(set_of_pi),


disp(' ');
disp('Grand Totals: ');
disp(['Total number of tokens in al places: ' int2str(No_of_all_tokens )]);
disp(['Total cost of all the tokens: ', num2str(Costs_of_all_tokens)]);
if not(isempty(Set_of_all_colors)),
    disp_str = 'Set of colors in all tokens: '; 
    for l = 1:length(Set_of_all_colors), 
        disp_str = [disp_str,'  ', Set_of_all_colors(l)]; 
    end;
    disp(disp_str);
end % not(isempty(Set_of_all_colors)),