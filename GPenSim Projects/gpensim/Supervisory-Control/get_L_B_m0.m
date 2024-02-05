function [L, B] = get_L_B_m0(constraints)
%        [L, B] = get_L_B_m0(constraints)
%


global PN


Ps = PN.No_of_places;

lenConstr = length(constraints);

L = zeros(lenConstr, Ps);   
B = zeros(lenConstr, 1);

for i = 1:lenConstr,
    l = constraints(i).l;   b = constraints(i).b;
    B(i, 1) = b;
    for j = 1:length(l)/2,
        p_name = l{2*j - 1}; p_index = check_valid_place(p_name);
        L(i, p_index) = l{2*j};
    end;
end;

% handle initial makrings
%m0 = get_initial_marking(initial_dynamics); % intial marking

