function [outvar1, outvar2, outvar3] = zipmatrix(invar1, invar2, invar3)
% function [outvar1, outvar2, outvar3] = zipmatrix(invar1, invar2, invar3)
%
% This function packs and unpacks a sparse matrix
%
%   Case-I: converting (packing) a sparse matrix into a vector 
%      E.g.: A1 = [5 0 0 1; 0 0 8 0; 0 0 0 5; 0 0 0 0];
%      [precedence1, N1, boolean] = zipmatrix(A1);
%       => precedence1 = [1,1,5,  1,4,1,  2,3,8,  3,4,5]
%          precedence1 contains indices of the non-zero elements, as 
%          well as the elemnt itself if A1 is not boolean
%       => N1 is the dimension of A1, which is 3
%       => boolean is 'false' as A1 contains elements greater than 1
%
%   Case-II: converting (unpacking) a vector into a sparse matrix 
%      E.g.: a packed vector precedence3 = [1,1, 1,4, 2,3, 3,4];
%            representing a boolean sparse matrix of dimention 4, then
%      A3 = zipmatrix(precedence3, 4, 1)           returns
%       => A3 = [1 0 0 1; 0 0 1 0; 0 0 0 1]
%          precedence1 contains indices of the non-zero elements, as 
%          well as the elemnt itself if A1 is not boolean
%       => N1 is the dimension of A1, which is 3
%       => boolean is 'false' as A1 contains elements greater than 1


if eq(nargin, 1),
    % pack a sparse matrix
    A = invar1;
    precedence = [];
    boolean = not(any(any(A>1)));
    N = size(A, 1);
    for i = 1:N,
        for j = 1:N,
            if A(i,j),
                if boolean,
                    precedence = [precedence, i, j];
                else
                    precedence = [precedence, i, j, A(i,j)];
                end;
            end;
        end;
    end;
    outvar1 = precedence;
    outvar2 = N;
    outvar3 = boolean;
    return
end;


% if ge(nargin, 2),
% create a sparse matrix from a set of non zeros elements
precedence = invar1;
dimension = invar2;
boolean = true;
if eq(nargin,3), boolean = invar3; end;

N = length(precedence);
A = zeros(dimension, dimension);

if boolean,
    for l = 1:2:N-1,
        i = precedence(l);
        j = precedence(l+1);
        A(i,j) = 1;
    end;
else
    for l = 1:3:N-2,
        i = precedence(l);
        j = precedence(l+1);
        arc_weight = precedence(l+2);
        A(i,j) = arc_weight;
    end;
end;
outvar1 = A;
