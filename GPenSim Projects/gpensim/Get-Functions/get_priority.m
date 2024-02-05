function [prio_value] = get_priority(trans_name)
% function [prio_value] = get_priority(trans_name)

global PN;

tx = is_trans(trans_name);
if ~(tx), 
    error([trans_name, ' : wrong transition name']);
end;

prio_value = PN.priority_list(tx);

