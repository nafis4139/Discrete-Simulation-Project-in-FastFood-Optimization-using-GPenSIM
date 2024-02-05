function [M] = eliminating_postive_duc(M, dim)
%        [M] = eliminating_postive_duc(M, dim)
% elimination of positive elements from Duc
% Algorithm 5.2, by Moody & Antsaklis, 1995, p. 55

n = dim(1); nc = dim(2); nuc = dim(3); nuo = dim(4); 

i = 1;
while le(i, min(nuc, n)),
    m = M(i:n, i);
    x = find(m < 0);
    if not(isempty(x)),
        j = x(1);
        mi = M(i,:);    mj = M(j, :);
        M(i, :) = mj;   M(j, :) = mi;
        p = i; j = i; 
        [M] = column_zeroing(M, p, j, dim);
    else
        m = M(n+1:n+nc, i);
        y = find(m > 0);
        if not(isempty(y)),
            disp('A controller arc can not be eliminated ');
            disp('because there are no negative elements in');
            error('the corresponding column of Duc.');
        end; % not(isempty(z)), 
    end; 
    i = i + 1;
end; % while le(i, 
