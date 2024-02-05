function [reserved] = requestGR(no_of_instances_wanted)
%function [reserved]= requestGR(no_of_instances_wanted)
%  to request a number of instances of ANY resources
% e.g. [reserved]= reserveGR(5)
%   output reserved is a boolean indicates whether reservation was 
%   successfull or not.

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 30 October 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[RAI] = availableRes(); % get the resource availability info
N_array = [RAI.n]; % number of instances available in all resource
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
