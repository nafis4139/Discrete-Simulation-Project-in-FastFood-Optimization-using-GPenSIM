function [Sm] = siphons_minimal(PN)
%        [Sm] = siphons_minimal(PN)
% This functions finds the minimal siphons

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = PN.No_of_places;   

A = PN.incidence_matrix;
Ain = A(:, 1:Ps); Aout = A(:, Ps+1:end);
Pre  = Ain';  Post = Aout';
S = PNCT_siphons(Pre, Post);
if isempty(S), Sm = []; return; end;

ss = sum(S');    % count the number of places (no. of ps) in each row
AS = [ss' S];    % add the count as 1st column to make augmented S
sAS = sortrows(AS, 1); % sort the AS based on 1st column (no. of ps)
Minimal_Siphons = [];  % start collecting minimal siphons

while not(isempty(sAS)),
    minimal_siphons_row = sAS (1,:);
    no_of_ps = minimal_siphons_row(1);
    minimal_siphon = minimal_siphons_row(2:end);
    Minimal_Siphons = [Minimal_Siphons; minimal_siphon];
    sAS = sAS(2:end, :); % delete the current minimal siphons
    m = size(sAS, 1);
    for i = 1: m,
        productXY = minimal_siphon .* sAS(i, 2:end);
        if eq(sum(productXY), no_of_ps),
            sAS(i, 1) = inf; % this is not minimal siphons
        end;        
    end;
    
    % now purge the sAS
    sAS2 = [];
    for i = 1: m,
        no_of_ps = sAS(i, 1);
        if not(isinf(no_of_ps)), % valid ps
            sAS2 = [sAS2; sAS(i, :)];
        end;
    end;
    sAS = sAS2; 
end;

disp(' '); disp('Minimal siphons in this net:');
print_places(Minimal_Siphons);
Sm = Minimal_Siphons;