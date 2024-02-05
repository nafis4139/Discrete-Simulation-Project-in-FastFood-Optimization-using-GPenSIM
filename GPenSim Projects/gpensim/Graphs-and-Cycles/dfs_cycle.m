function [V] = dfs_cycle (V, u)
% function [V] = dfs_cycle (V, u)
% function depth-first-search for cycle detection
% ** V is the set of nodes
%       V.A is the incidence matrix
%       V.nodes is the set of nodes
%       V.time = is the current time (current step)
% ** u is the current node
%
%      Reggie Davidrajuh (c) August 2011

No_of_nodes = length(V.nodes);

V.time = V.time + 1; V.nodes(u).d = V.time; V.nodes(u).color = 'gray';
% disp([V.nodes(u).name, '(', int2str(V.nodes(u).d), '/ )']);

for v = 1:No_of_nodes, % scan all the nodes connected with u
    if V.A(u, v),   % if there is a connection between (i, j)
        
        if strcmp(V.nodes(v).color, 'white'), % tree edge
            % disp(['Tree edge: ',V.nodes(u).name,' to ',V.nodes(v).name]);
            V.nodes(v).pi = u; 
            V = dfs_cycle (V, v);
        elseif strcmp(V.nodes(v).color, 'gray'),  % Back edge
            % disp(['Back edge: ',V.nodes(u).name,' to ',V.nodes(v).name]);
            % V.no_of_cycles = V.no_of_cycles + 1;
            % disp(' ');
            % disp(['Cycle no.: ', int2str(V.no_of_cycles)]);
            cycle_path = create_cycle_path(V, v, u);
            
            [new_cycle, cycle_path] = cycle_new_detected(V, cycle_path);
            if new_cycle, 
                V.cycles = [V.cycles; cycle_path];
                %V.cycles 
            end;
            % V.cycles                          
        else 
            % disp(['Cross/Forward edge: ', ...
            %    V.nodes(u).name,' to ',V.nodes(v).name]);                     
        end;
    end; % if V.A
end; % for j = 1:

V.nodes(u).color = 'black'; V.time = V.time + 1; V.nodes(u).f = V.time;
% disp(['Black node: ', V.nodes(u).name, ...
%    '(', int2str(V.nodes(u).d), '/', int2str(V.nodes(u).f), ')']);
