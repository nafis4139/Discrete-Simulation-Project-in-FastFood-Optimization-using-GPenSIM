function [acquired] = requestSR(specific_resources)
%        Request Specific Resources 
% [acquired] = requestSR(specific_resources)
%
% e.g. [acquired] = requestSR('tRobot1', {'rP',1, 'rQ',2, 'anyResource', 2});

%  Reggie.Davidrajuh@uis.no (c) Version 9.0 (c) 30 October 2014  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%disp('"requestSR" ......'); 
global PN;
t_index = PN.attempting_trans; 
no_of_resources = length(specific_resources)/2;

i = 1;
acquired = true;
while and(le(i, no_of_resources), acquired),
    r_index = specific_resources{2*i-1};
    if ischar(r_index), r_index = check_valid_resource(r_index); end;
    no_of_instances = specific_resources{2*i};    
    if not(isnumeric(no_of_instances)),
        disp('Usgae: ');  
        disp('[acquired] = requestSR("t1", {"rP",1,"anyResource",2});');
        error('check the number of resource intances');
    end;
    
    if (r_index), 
        acquired = resource_request_one_res(t_index,r_index, no_of_instances);
    else
        acquired = requestGR(t_index, no_of_instances);
    end;
    i = i + 1;
end;
