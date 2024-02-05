function [Tm] = traps_minimal(PN)
%        [Tm] = traps_minimal(PN)
% This functions finds the minimal traps

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ps = PN.No_of_places;   

A = PN.incidence_matrix;   
Ain = A(:, 1:Ps);  Aout = A(:, Ps+1:end);
Pre  = Ain';  Post = Aout';
T = PNCT_traps(Pre, Post);
if isempty(T), Tm = []; return; end;

st = sum(T');    % count the number of places (no. of ps) in each row
AT = [st' T];    % add the count as 1st column
sAT = sortrows(AT, 1); % sort the AT based on 1st column (no. of ps)
Minimal_Traps = [];  % start collecting minimal traps 

while not(isempty(sAT)),
    minimal_traps_row = sAT (1,:);
    no_of_ps = minimal_traps_row(1);
    minimal_trap = minimal_traps_row(2:end);
    Minimal_Traps = [Minimal_Traps; minimal_trap];
    sAT = sAT(2:end, :); % delete the current minimal trap
    m = size(sAT, 1);
    for i = 1: m,
        productXY = minimal_trap .* sAT(i, 2:end);
        if eq(sum(productXY), no_of_ps),
            sAT(i, 1) = inf; % this is not minimal trap
        end;        
    end;
    
    % now purge the sAT
    sAT2 = [];
    for i = 1: m,
        no_of_ps = sAT(i, 1);
        if not(isinf(no_of_ps)), % valid ps
            sAT2 = [sAT2; sAT(i, :)];
        end;
    end;
    sAT = sAT2; 
end;

disp(' '); disp('Minimal traps in this net:');
print_places(Minimal_Traps);
Tm = Minimal_Traps;