 function [] = verify_supervisor(sys1, COTREE, constraints)
%        [] = verify_supervisor(sys1, COTREE, constraints)

disp('Now verifying the proposed controlller action !!!!');
disp(' Please wait ......');

global PN;
PN = sys1;
Ps = PN.No_of_places;

[L, B, ~] = get_L_B_m0(sys1, [], constraints);

lenConstr = length(constraints);
rows_of_CT = size(COTREE, 1);

%all_ok = 1; % optimistic assumption, to begin with
for ci = 1:lenConstr,
    Li = L(ci, :);
    bi = B(ci, :);

    for rowj = 1:rows_of_CT,
        tokens = COTREE(rowj, 1:Ps);
        toksum = tokens * Li';       % disp(int2str(toksum));
        if gt(toksum, bi),
            disp(['invalid control action in row-', int2str(rowj)]);
            error('wrong here');
        end;
    end;
end;

disp('All the constraints are verfied !!!!');
%util_wakeup;