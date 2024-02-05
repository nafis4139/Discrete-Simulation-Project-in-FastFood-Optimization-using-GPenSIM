function [place] = extract_place(placeElement)

place = [];

place.id = placeElement.Attributes.Value;
placeStruct = placeElement.Children; 

lenPlaceStruct = length(placeStruct);
for j = 1:lenPlaceStruct,
    if strcmp(placeStruct(j).Name, 'name'),
        placeData = placeStruct(j).Children;
        lenPlaceData = length(placeData);
        for k = 1:lenPlaceData,
            if strcmp(placeData(k).Name, 'value')
                place.name = placeData(k).Children.Data;
            end;
        end;                             
    end; % if strcmp(placeStruct(j).Name, 'name')        
    
    if strcmp(placeStruct(j).Name, 'initialMarking'), 
        placeData = placeStruct(j).Children;
        lenPlaceData = length(placeData);
        for k = 1:lenPlaceData,
            if strcmp(placeData(k).Name, 'value'),
                place.m0 = placeData(k).Children.Data;
            end;
        end;                             
    end; % if strcmp(placeStruct(j).Name, 'initialMarking') 
end;

