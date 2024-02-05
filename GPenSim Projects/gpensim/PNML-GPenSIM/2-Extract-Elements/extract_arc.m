function [arcx] = extract_arc(arcElement)

arcx = [];

eval(['arcx.', arcElement.Attributes(1).Name, '=', 'arcElement.Attributes(1).Value', ';']);
eval(['arcx.', arcElement.Attributes(2).Name, '=', 'arcElement.Attributes(2).Value', ';']);
eval(['arcx.', arcElement.Attributes(3).Name, '=', 'arcElement.Attributes(3).Value', ';']);

arcStruct = arcElement.Children; 

lenArcStruct = length(arcStruct);
for j = 1:lenArcStruct,
    if strcmp(arcStruct(j).Name, 'inscription'),
        arcData = arcStruct(j).Children;
        lenArcData = length(arcData);
        for k = 1:lenArcData,
            if strcmp(arcData(k).Name, 'value'),
                arc_weight = arcData(k).Children.Data;
            end;
        end;                             
    end; % if strcmp(placeStruct(j).Name, 'name')            
end;

% just a fix for Ian Liu's problem: 
% if arc_weight is defined as a sting 'Default,1', not 
% just as a character like '1','2', or '1000' as expected 
if strfind(arc_weight, 'Default,'),
    arc_weight = arc_weight(9:end);
end;
eval(['arcx.weight =', int2str(arc_weight), ';']);


