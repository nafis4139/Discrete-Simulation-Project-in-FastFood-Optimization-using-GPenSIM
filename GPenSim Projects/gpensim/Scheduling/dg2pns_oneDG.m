function [set_of_Ps, set_of_Ts, set_of_As] = dg2pns_oneDG(dg1, makeDEFfile)
% function [set_of_Ps, set_of_Ts, set_of_As] = dg2pns_oneDG(dg1, makeDEFfile)
%
% Convert one dependency graph into a Petri Net structure

global PN;
TNT = PN.total_number_of_tasks;

A = dg1.A; N = size(A, 1); 
 
% 1: create the set of transitions
if isfield(dg1, 'set_of_Ts'), 
    set_of_Ts = dg1.set_of_Ts;
else
    set_of_Ts = [];
    for i = TNT+1:TNT+N,
        t_name = ['t', int2str(i)]; set_of_Ts = [set_of_Ts, {t_name}];
    end;
end;
% 2: create the set of places
set_of_Ps = [];
for i = TNT+1:TNT+N,
    p_name = ['p', int2str(i)]; set_of_Ps = [set_of_Ps, {p_name}];
end;

% 3: create the set of arcs
set_of_As = [];
for i = 1:N,
    t_name = set_of_Ts{i};
    
    % connections FROM other places (tasks)
    column_i = A(:, i); 
    sum_ci = sum(column_i);
    if sum_ci, 
        from_indices = find(column_i>0)';
        for j = 1:length(from_indices),
            from_j = from_indices(j);
            p_name = set_of_Ps{from_j};
            set_of_As = [set_of_As {p_name, t_name, 1}]; 
        end;
    end;
    
    % connection WITHIN (transition, place) pair
    row_i = A(i, :); 
    sum_ri = sum(row_i);
    p_name = set_of_Ps{i};
    if sum_ri,
        set_of_As = [set_of_As {t_name, p_name, sum_ri}]; 
    else
        set_of_As = [set_of_As {t_name, p_name, 1}];
    end;
end;
if makeDEFfile, write_def(set_of_Ps, set_of_Ts, set_of_As); end;
PN.total_number_of_tasks = PN.total_number_of_tasks + N;
