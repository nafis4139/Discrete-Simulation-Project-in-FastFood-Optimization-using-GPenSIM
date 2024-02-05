function [uniquess] = uniqueStates(CT)
% function [uniquess] = uniqueStates(CT)
%   uniques states in a coverability tree
% 
% Purpose: 
%    When the function "cotree" creates and plots the coverability tree
%    there are many duplicate states. 
%    These duplicate states are highlighted with yellow color 
%    in the cotree plot. Also, the duplicate states are indicated by the
%    char'D' (value = 68) in the last colums of the CT matrix
%    This functions returns the number of unique states in the CT matrix.
%
%  Input:   CT matrix gehnerated by the cotree function.
%  Output:  Number of unique states in the CT matrix
%
%  Sample use:  uniqueStatesinCT = uniqueStates(CT)
%
%      Reggie.Davidrajuh@uis.no  (C) 01 November 2019 
%
Ps = size(CT,2) - 2; % last two columns are firing trans, and state info
stateInfoIndex = size(CT,2); % the last column is the state info
No_of_overall_states = size(CT,1);

uniquess = No_of_overall_states; % to start with, assume all unique states

for i = 1:No_of_overall_states 
    if eq(CT(i, stateInfoIndex), double('D')) % is this a duplicate state
        uniquess = uniquess - 1;
    end
end
