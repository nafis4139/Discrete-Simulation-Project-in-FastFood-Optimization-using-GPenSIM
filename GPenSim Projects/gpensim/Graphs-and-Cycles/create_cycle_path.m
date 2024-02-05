function [cycle_path] = create_cycle_path(V, source, des)
% function [des] = create_cycle_path(V, source, des)
%     Reggie Davidrajuh (c) December 2011

cycle_path = source;
% disp('Inside  "create_cycle_path" .....'); 
% AND
%   ('des' is not zero)
%   ('des' not eq to 'source'
while and(des, not(eq(des, source))),
    cycle_path = [des cycle_path];
    des = V.nodes(des).pi;
end;
