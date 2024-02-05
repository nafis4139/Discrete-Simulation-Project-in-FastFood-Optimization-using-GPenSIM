function [new_cycle, cycle_path] = cycle_new_detected(V, cycle_path)
% function [new_cycle,cycle_path]= cycle_new_detected(V, cycle_path)
%  
%       Reggie.Davidrajuh@uis.no (c) December 2011

% first pad cycle_path with tariling zeros
No_of_nodes = length(V.nodes);
cycle_path = [cycle_path ...
    zeros(1, No_of_nodes-length(cycle_path))];

m = size(V.cycles, 1); % cycles already found 
new_cycle = true;

for rows = 1:m, 
    if isempty(setxor(cycle_path, V.cycles(rows, :))),
        new_cycle = false;
    end;
end;