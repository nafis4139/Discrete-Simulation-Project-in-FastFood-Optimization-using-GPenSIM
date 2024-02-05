function [L1, B1] = constraint_transformation(L, B, Duc, Duo, X0, dim)
%        [L1, B1] = constraint_transformation(L, B, Duc, Duo, X0, dim)
% Constraint Transformation algorithm (Algorithm 5.1), 
%  by Moody & Antsaklis, 1995, p. 54

n = dim(1); nc = dim(2); nuc = dim(3); nuo = dim(4);

LDuc = L * Duc; LDuc_not_positive = isempty(find(LDuc > 0));
LDuo = L * Duo; LDuo_all_zero = isempty(any(any(LDuo)));

if and(LDuc_not_positive, LDuo_all_zero),
    R1 = zeros(nc, n);  R2 = eye(nc);    
else
    M = [Duc, Duo; LDuc, LDuo]; 
    M = [M eye(n+nc)];
    M = eliminating_postive_duc(M, dim); % Algo 5.2
    m = M(n+1:n+nc, 1:nuc);
    y = find(m > 0);
    if not(isempty(y)),
        disp('Controller arcs were introduced by the');
        disp('row operations into the uncontrolled portion');
        disp('of the plant, and they can not be eliminated');
        disp('due to lack of negative elements in Duc.');
        error('Controller can not be realized');
    end; % not(isempty(y)),  
    
    M = zeroing_duo(M, dim); % Algo 5.3
    m = M(n+1:n+nc, nuc+1:nuc+nuo);
    z = find(m ~= 0);
    if not(isempty(z)),
        disp('The unobservable portion of the plant');
        disp('contains arcs which can not be eliminated');
        error('Controller can not be realized');
    end; % not(isempty(y)),                
    R1 = M(n+1:n+nc, nuc+nuo+1:nuc+nuo+n);
    R2 = M(n+1:n+nc, nuc+nuo+n+1:nuc+nuo+n+nc);    
end;

Duc_final = M(1:n, 1:nuc)
Duo_final = M(1:n, nuc+1:nuc+nuo)
LDuc_final = M(n+1:n+nc, 1:nuc)
LDuo_final = M(n+1:n+nc, nuc+1:nuc+nuo)
M
L
B
R1 = [0 0 1 0] 
R2  
L1 = R1 + (R2*L)
B1 = R2*(B+1) - 1

L1X0 = L1 * X0'; delta = L1X0 - B1
x = find(delta < 0);
if any(x), 
    disp('Control law is infeasible ...');
    error('Control law is infeasible ...');
end;
    