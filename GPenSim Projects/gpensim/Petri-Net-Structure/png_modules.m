function [] = png_modules()
% function [] = png_modules()

global PN

Ts = PN.No_of_transitions;
% creating transition-module membership table (MMT)
% MMT is (2 X Ts)
% First  row of MMT: if trans belongs to a module, then module number
% Second row of MMT: whether the trans is a also a input/output port
module_names = {};
module_membership = zeros(2, Ts);  
for i = 1:PN.No_of_modules,
    eval(['current_module_Ts = PN.module_', int2str(i), '_Ts;']);
    mx = ['module_', int2str(i), '_Ts'];
    PN = rmfield(PN, mx);
    for j = 1:numel(current_module_Ts),
        tname = current_module_Ts{j};
        tx = check_valid_transition(tname);
        module_membership(1,tx) = i;
    end
    eval(['current_module_Ports = PN.module_', int2str(i), '_Ports;']);
    mx = ['module_', int2str(i), '_Ports'];
    PN = rmfield(PN, mx);
    for j = 1:numel(current_module_Ports),
        tname = current_module_Ports{j};
        tx = check_valid_transition(tname);
        module_membership(2,tx) = 1;
    end    
    eval(['module_name = PN.module_', int2str(i), '_name;']);
    mx = ['module_', int2str(i), '_name'];
    PN = rmfield(PN, mx);
    module_names = [module_names {module_name}];
end
PN.module_membership = module_membership;
PN.module_names = module_names;

