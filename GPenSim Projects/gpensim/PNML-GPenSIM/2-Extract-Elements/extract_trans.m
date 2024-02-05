function [trans] = extract_trans(transElement)


trans = [];
trans.id = transElement.Attributes.Value;
transStruct = transElement.Children; 
lenTransStruct = length(transStruct);
for j = 1:lenTransStruct,
    if strcmp(transStruct(j).Name, 'name'),
        transData = transStruct(j).Children;
        lenTransData = length(transData);
        for k = 1:lenTransData,
            if strcmp(transData(k).Name, 'value')
                trans.name = transData(k).Children.Data;
            end;
        end;                             
    end; % if strcmp(transStruct(j).Name, 'name')
end;