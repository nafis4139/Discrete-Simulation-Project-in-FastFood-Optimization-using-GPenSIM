function [M] = zeroing_duo(M, dim)
%        [M] = column_zeroing(M, p, j, dim)
% Zeroing of all elements in Duo
% Algorithm by Moody & Antsaklis, 1995
% This is the algorithm 5.3, p. 56

n = dim(1); nc = dim(2); nuc = dim(3); nuo = dim(4); 

i = 1;

while le(i, min(nuc+nuo, n)),
    m = M(i:n, i);
    x = find(m < 0);
    if not(isempty(x)),
        j = x(1);
        mi = M(i,:);    mj = M(j, :);
        M(i, :) = mj;   M(j, :) = mi;
        k = 1;
    else
        k = 0;
    end; % if not(isempty(x))
    
    m = M(i:n, i);
    y = find(m > 0);
    if not(isempty(y)),
        j = y(1);
        mik = M(i+k,:);    mj = M(j, :);
        M(i+k, :) = mj;   M(j, :) = mik;
        
        p = i + k; j = i; % pivot position
        [M] = column_zeroing(M, p, j, dim);
    end; % if notisempty(y)
    
    if eq(k, 1),
        p = i; j = i;
        [M] = column_zeroing(M, p, j, dim);
    end; % if eq(k, 1)
    
    m = M(n+1:n+nc, i);
    z = find(m ~= 0);
    if not(isempty(z)),
        disp('Controller arc(s) can not be eliminated ');
        disp('from the unobservable portion of the plant.');
        error('Controller is not realizable.');
    end; % not(isempty(z)), 
    
    i = i + 1;
end; % while le(i
