function [M] = column_zeroing(M, p, j, dim)
%        [M] = column_zeroing(M, p, j, dim)
% Column Zeroing algorithm by Moody & Antsaklis, 1995
% This is the algorithm 5.4, p. 57

n = dim(1); nc = dim(2); nuc = dim(3); nuo = dim(4); 

i = p + 1;
while le(i, (n+nc)),
    if lt(M(i,j)*M(p,j), 0),
        while M(i,j),
            if gt(abs(M(p,j)), abs(M(i,j))),
                d = floor(-1 * M(p,j)/M(i,j));
                if not(mod(M(p,j), M(i,j))),
                    d = d - 1;
                end; % if not(mod(M(p,j
                M(p,:) = M(p, :) + d * M(i,:);
            else
                d = floor(-1 * M(i,j)/M(p,j));
                M(i,:) = M(i, :) + d * M(p,:);
            end; % gt(abs
        end; % while M(i,j),
    end; % lt(M(i,j)*M(p,j)
    i = i + 1;
end; % while le(i, 
