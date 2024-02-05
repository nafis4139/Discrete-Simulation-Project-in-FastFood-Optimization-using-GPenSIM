function [] = print_transitions (M, lead_string)
% function [] = print_transitions (M, lead_string)
% Matrix M (k, Ts) contains rows of transitions
% which is prduced by t_invariant
% 

global PN;

[m, n] = size(M); 

if eq(nargin, 1),
    % no lead string
    disp_str = '';
else
    disp_str = lead_string;
end;

for i = 1:m,
    disp_str = [disp_str '{'];
    for j = 1:n,
        if M(i,j),
            disp_str = [disp_str, PN.global_transitions(j).name, ','];
        end;
    end;
    disp_str(end) = '}';
    disp(disp_str);
end;
