function [] = print_pta(global_places, ...
                            global_transitions, global_arcs)
% function [] = print_pta(global_places, ...
%               global_transitions, global_arcs)

disp('  '); 
disp('*** Places: ***');
for i = 1:length(global_places)
    disp(['Place id: ', global_places(i).id, ...
        '   name: ', global_places(i).name,...
        '   m0: ', global_places(i).m0]);
end

disp('  '); 
disp('*** Transitions: ***');
for i = 1:length(global_transitions)
    disp(['Place id: ', global_transitions(i).id, ...
        '   name: ', global_transitions(i).name]);
end

disp('  '); 
disp('*** Arcs: ***');
for i = 1:length(global_arcs)
    disp(['Arc id: ', global_arcs(i).id, ...
        '   source: ', global_arcs(i).source,...
        '   target: ', global_arcs(i).target, ...
        '   weight: ', global_arcs(i).weight]);
end

