function [] = print_cycles(V)
% function [] = print_cycles(V)
%
%  
%       Reggie.Davidrajuh@uis.no (c) December 2011


% now print all the cycles that are in V.cyles
No_of_cycles = size(V.cycles, 1);  % each row is a cycle
for i = 1:No_of_cycles,
    disp(' ');
    disp(['Cycle No-', int2str(i), ':  ******* ']);
    
    current_cycle = V.cycles(i, :);
    j = 1;
    disp_string = '';
    node = current_cycle(j);
    % each cycle end with zeros
    while node,
        disp_string = [disp_string, ' -> ', V.nodes(node).name];
        j = j+1;
        node = current_cycle(j);
    end;
    disp(disp_string);
end;