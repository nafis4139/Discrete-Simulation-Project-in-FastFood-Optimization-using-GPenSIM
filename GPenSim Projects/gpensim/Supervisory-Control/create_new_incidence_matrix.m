function [] = create_new_incidence_matrix(Dc, lenConstr)
% function [] = create_new_incidence_matrix(Dc, lenConstr)

global PN

Ps = PN.No_of_places;
Ts = PN.No_of_transitions;

%%%% compute the incidence matrix of the controller
Cin = []; Cout = [];
for i = 1:lenConstr,
    zero_vector = zeros(1, Ts);
    d = Dc(i, :);
    dpos_index = find(d > 0); dneg_index = find(d < 0);
    dp = zero_vector; dp(dpos_index) = d(dpos_index);
    dn = zero_vector; dn(dneg_index) = abs(d(dneg_index));    
    Cin = [Cin dn'];  Cout = [Cout dp'];
end;

% the incidence matrix of the process
Ain =  PN.incidence_matrix(:, 1:Ps);
Aout = PN.incidence_matrix(:, Ps+1:end);

% the incidence matrix of the controlled process (process + controller)
Acontrolled_in = [Ain Cin];
Acontrolled_out = [Aout Cout];

% add the new incidence matrix to the system
PN.incidence_matrix = [Acontrolled_in Acontrolled_out];
