function [reserved] = requestAR(pool_of_resources, no_of_instances_wanted)
%function [reserved]= requestAR(pool_of_resources, no_of_instances)
%  to request a number of instances from a pool of specific resources 
% e.g. [reserved]= reserveSR({'P','Q','S'}, 4)
%   output reserved is a boolean indicates whether reservation was 
%   successfull or not.

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrs = length(pool_of_resources);  % number of resources wanted 

RI = zeros(1, nrs); % set of resource indices 
for i = 1:nrs,
    r_index = pool_of_resources{i};     % 1: read the inputs
    r_index = check_valid_resource(r_index);
    RI(i) = r_index;
end;

if not(isnumeric(no_of_instances_wanted)), 
    error('wrong input: second input parameter must be a number: ');
end;

[RAI] = availableRes(RI); % get the resource availability info
N_array = [RAI.n]; % number of instances available in each specified resource
sum_N = sum(N_array);

if gt(no_of_instances_wanted, sum_N),
    reserved = false; % 
    return;
end;
    
reserved = true; % 
secured_inst = 0;
i = 1;
while lt(secured_inst, no_of_instances_wanted),
    needed_more = no_of_instances_wanted - secured_inst;
    n = RAI(i).n;
    if ge(needed_more, n),
        reserve_inst_from_this_res = n;
    else
        reserve_inst_from_this_res = needed_more;
    end;
    reserveInst(reserve_inst_from_this_res, RAI(i)); 
    secured_inst = secured_inst + reserve_inst_from_this_res;
    i = i + 1;
end;
