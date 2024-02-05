function [COTREE] = build_cotree_i(X0, sizeOfCotree)   
%        [COTREE] = build_cotree_i(X0, sizeOfCotree)   
%          Build Coverability Tree for inhibitor arc
%
% Purpose:	Creates coverability tree for a Petri net with inhibitor arcs 
% Input parameters:	
%    X0: initial tokens 
%    sizeOfCotree: maximum number of states 
%
% Out parameters:	Cotree structure 
%       
% Uses:	sources_matrix, enabled_transition, new_marking, 
%       check_for_dominance, good_name
% Used by:	cotree
% NOTE:	build_Cotree algorithm is similar to Cassandras & Lafortune (1998)

%   Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 20. September 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

PN.X = X0;  % initial markings

FALSE = 0;  TRUE = 1;	
Ps = PN.No_of_places;	% number of places
Ts = PN.No_of_transitions; % number of transitions

COTREE = zeros(1, Ps+3); % initialize COTREE
COTREE(1, 1:Ps) = PN.X;     % initialize COTREE with x
%%%%%%%%%%%%%%%%% info %%%%%%%%%%%%%%% 
%%%% COTREE(i,Ps+1) is triggering transition that created the 'i'th row 
%%%% COTREE(i,Ps+2) is the parent row of the 'i'th row  
%%%% COTREE(i,Ps+3) is a tag: 'R'oot/'D'uplicate/'T'erminal 
COTREE(1, Ps+3) = double('R');%'R'oot; also the first row
main_index = 0; 

%global while loop
while and(lt(main_index, size(COTREE,1)), lt(size(COTREE,1), sizeOfCotree)),
   main_index = main_index+1;
   X = COTREE(main_index, :); % current state (with extended info)
   PN.X = X(1:Ps); % current state 
   
   %check for duplicate
   xTREE = COTREE(1:main_index-1, 1:Ps);   % reachable states from x
   parent = X(Ps+2); 
   if ~any(ismember(xTREE, PN.X, 'rows')),%not duplicate
      
      terminal = TRUE; % initial assumption, just to start
      for t = 1:Ts,
         if enabled_transition(t), 
            terminal = FALSE; %enabled trans means not terminal
            new_branch = zeros(1, Ps+3); %new branch
            
            x1 = new_marking(t); %STEPS 2.2 + 2.2.1
            %STEP 2.2.2: THIS STEP IS NOT VALID FOR INHIBITOR ARCS
            %x1 = check_for_dominance(x1, ...
            %      COTREE(1:main_index-1, :), parent);
            new_branch(1, 1:Ps) = x1; 
            new_branch(1, Ps+1) = t;
            new_branch(1, Ps+2) = main_index; 
            COTREE = [COTREE; new_branch];
         end; %if enabled_transition
      end; %for t=1:Ts
      
      if terminal,
         COTREE(main_index, Ps+3) = double('T'); %'T'erminal
      end; %if terminal,
      
   else  %if ~any(ismember(XTREE, X
      COTREE(main_index, Ps+3) = double('D'); %'D'uplicate
   end; %if ~any(ismember(XTREE, X, 
end; %global while 
