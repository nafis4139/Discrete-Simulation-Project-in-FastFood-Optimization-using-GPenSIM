function [combinations] = combinatorics(N)
% function [combinations] = combinatorics(N)
%
% Usage:  CASE-I: [combinations] = combinatorics ([1:2:5])
%         CASE-II: [combinations] = combinatorics ([7 2 1])
%
% CASE-I: N is a vector of consisting of a series
% find the different combinations of [1..n] (or [1:2:n+1])
% E.g.  size N = 1:      Output = [1];
%       size N = [1:2]:  Output = [1 2; 2 1];
%       size N = [1:2:5] Output = [5 3 1;3 5 1; 3 1 5; ... ; 1 3 5];
%
% CASE-II: N is a vector of diverse numbers [3.1, 5.2, -3]
% find the different combinations of [m, n, o]
%       size N = 3: Output = [ -3 5.2 3.1; 5.2 -3 3.1; 3.1 5.2 -3]
%
% Reggie.Davidrajuh@uis.no    (c)  10 March 2015  (c) 10 May 2019

Max_Itertaions = length(N);
if eq(Max_Itertaions, 1), combinations = N; return; end

iteration = 1;
combinations = N(1);

% create all combinations of 1..N
while lt(iteration, Max_Itertaions)
    iteration = iteration + 1;
    Matrix = combinations;
    [m, n] = size(Matrix);
    New_item = N(n+1);  
    combinations = zeros(factorial(n+1), n+1);
    New_Matrix_row = 0;
    
    for i = 1:m
        row = Matrix(i,:);
        %New_Matrix = [New_Matrix; New_item row]
        for j = 1:n
            new_row = [row(1:j-1), New_item, row(j:end)];
            New_Matrix_row = New_Matrix_row + 1;
            combinations(New_Matrix_row, :) = new_row;
        end
        New_Matrix_row = New_Matrix_row + 1;
        combinations(New_Matrix_row, :) = [row, New_item];
    end
end

