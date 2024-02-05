function [PN, dynamicpart] = prepare_supervisor(PN, dynamicpart, constraints)
%        [PN, dynamicpart] = prepare_supervisor(PN, dynamicpart, constraints)
%

% process initial makrings
if not(isfield(dynamicpart, 'initial_markings')),
    error('dynamicpart does not has initial_markings');
else
    imarkings = dynamicpart.initial_markings;
    X = process_marking(imarkings); % intial marking
    PN.X = X;  % current state element is established in PN structure    
end;

m0 = PN.X;    % initial markings % m0 = [0 0 1 0 0 0 0 0 0 1];        
lenConstr = length(constraints);
Ps = PN.No_of_places;   Ts = PN.No_of_transitions;

L = zeros(lenConstr, Ps);   B = zeros(lenConstr, 1);
for i = 1:lenConstr,
    l = constraints(i).l;   b = constraints(i).b;
    B(i, 1) = b;
    for j = 1:length(l)/2,
        p_name = l{2*j - 1}; p_index = check_valid_place(p_name);
        L(i, p_index) = l{2*j};
    end;
end;

[~,~,Dp] = gpensim_2_PNCT(PN); % incidence matrix of the process
Dc = -1 * L * Dp;  
muC = B  - L * m0'; 
dynamicpart.initial_markings = [PN.X muC'];
PN.X = [PN.X muC'];

slack_places = [];
for i = 1:lenConstr,
    slack_pl.name = ['slack' int2str(i)]; slack_pl.tokens = 0;
    slack_places = [slack_places slack_pl]; 
end;
PN.global_places = [PN.global_places slack_places];
PN.No_of_places = PN.No_of_places + lenConstr;
PN.No_of_control_places = lenConstr;

Cin = []; Cout = [];
for i = 1:lenConstr,
    zero_vector = zeros(1, Ts);
    d = Dc(i, :);
    dpos_index = find(d >= 1); dneg_index = find(d < 0);
    dp = zero_vector; dp(dpos_index) = d(dpos_index);
    dn = zero_vector; dn(dneg_index) = abs(d(dneg_index));    
    Cin = [Cin dn'];  Cout = [Cout dp'];
end;

Ain =  PN.incidence_matrix(:, 1:Ps);
Aout = PN.incidence_matrix(:, Ps+1:end);
Acontrolled_in = [Ain Cin];
Acontrolled_out = [Aout Cout];
PN.incidence_matrix = [Acontrolled_in Acontrolled_out];
