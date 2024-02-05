function [global_places, global_transitions, global_arcs] = ...
                extract_pta_elements(netStruct)
% function [global_places, global_transitions, global_arcs] = ...
%                extract_pta_elements(netStruct)            
%
% This function extracts places, transitions, and arcs from the 
%    xDOM structure 
%  Input:   PNMLfile: name of the PNML file
%  Output: global_places, global_transitions, global_arcs

%  Reggie.Davidrajuh@uis.no (c) September 2013

netElements = netStruct.Children;
global_places = []; 
global_transitions = [];
global_arcs = [];
lenNet = length(netElements);
for i = 1:lenNet
    if strcmp(netElements(i).Name, 'place')
        global_places = [global_places extract_place(netElements(i))];
    end
    if strcmp(netElements(i).Name, 'transition')
        global_transitions = ...
            [global_transitions extract_trans(netElements(i))];
    end
    if strcmp(netElements(i).Name, 'arc')
        global_arcs = [global_arcs extract_arc(netElements(i))];
    end
end

