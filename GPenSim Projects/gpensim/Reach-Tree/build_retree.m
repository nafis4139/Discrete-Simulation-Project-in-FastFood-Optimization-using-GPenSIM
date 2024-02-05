function [RETREE] = build_retree(X0, FT, FCF, FCV, max_states)   
%        [RETREE] = build_retree(X0, FT, FCF, FCV, max_states)   
% Name:	build_retree
% Purpose:	Creates the coverability tree of a Petri net 
% Input parameters:	Static Petri net sturcture (output by ‘petrinetgraph’)
%                   Intial_markings
% Out parameters:	Cotree structure 
% Uses:	sources_matrix, enabled_transition, new_marking, 
%       check_for_dominance, good_name
% Used by:	[main simulation file], print_cotree, plot_cotree
% NOTE:	build_Cotree algorithm is similar to Cassandras & Lafortune (1998)
%       plot_cotree is based on the work by Univ. Cagliari
% Example:	
%   % inside cotree main simulation file
%   png = petrinetgraph('cotree_example_def');
%   dyn.initial_markings = {'p1',2, 'p4', 1};
%   COTREE = build_cotree();

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

FALSE = 0;  TRUE = 1;	
Ps = PN.No_of_places;	% number of places
Ts = PN.No_of_transitions; % number of transitions

RETREE = zeros(1, Ps+5); % initialize COTREE
RETREE(1, 1:Ps) = X0;     % initialize COTREE with x
%%%%%%%%%%%%%%%%% info %%%%%%%%%%%%%%% 
%%%% RETREE(i,Ps+1) is triggering transition that created the 'i'th row 
%%%% RETREE(i,Ps+2) is the parent row of the 'i'th row  
%%%% RETREE(i,Ps+3) is a tag: 'R'oot/'D'uplicate/'T'erminal 
%%%% RETREE(i,Ps+4) is the time of the state
%%%% RETREE(i,Ps+5) is the cost of the state

RETREE(1, Ps+3) = double('R');%'R'oot; also the first row
main_index = 0; 
size_of_RETREE = 1; % just one row to start

% global while loop
while and(lt(main_index, size_of_RETREE), lt(size_of_RETREE, max_states)),
   main_index = main_index+1;
   X = RETREE(main_index, :); % current state (with extended info)
   PN.X = X(1:Ps); % current state 
   current_time = X(Ps+4);
   current_cost = X(Ps+5);
   
   % check for duplicate
   xTREE = RETREE(1:main_index-1, 1:Ps);   parent = X(Ps+2); 
   if ~any(ismember(xTREE, PN.X, 'rows')), % not duplicate
       terminal = TRUE; % for starting
       for t = 1:Ts,
           if enabled_transition(t), 
               terminal = FALSE; %enabled trans means not terminal
               new_branch = zeros(1, Ps+3); %new branch          
               x1 = new_marking(t); %STEPS 2.2 + 2.2.1
               % STEP 2.2.2
               %            x1 = check_for_dominance(x1, ...
               %                  RETREE(1:main_index-1, :), parent);
               new_branch(1, 1:Ps) = x1; % new state tokens
               new_branch(1, Ps+1) = t;  % fired transitions
               new_branch(1, Ps+2) = main_index; % parent
               new_branch(1, Ps+4) = current_time + FT(t); % new state time
               new_branch(1, Ps+5) = current_cost + ...
                   FCF(t) + (FT(t) * FCV(t)); % new state cost
               RETREE = [RETREE; new_branch];
           end; %if enabled_transition
       end; %for t=1:Ts
       if terminal,
           RETREE(main_index, Ps+3) = double('T'); %'T'erminal
       end; %if terminal,
   else % ~any(ismember(xTREE, PN.X, 'rows')), % not duplicate
       RETREE(main_index, Ps+3) = double('D'); %'D'uplicate
   end;       
   size_of_RETREE = size(RETREE,1);   
end; %global while 

