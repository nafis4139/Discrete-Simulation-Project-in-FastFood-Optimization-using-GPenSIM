function [tOs, tNames] = get_outputtrans(p_index)
% [t_indices, tNames] = get_outputtrans('place_name' or p_index)
%
% Purpose: This function returns the set of output transitions of a place.
% 
% Sample Use:
%      [t_indices, tNames] = get_outputtrans('pbuffer_1');
%      [t_indices, tNames] = get_outputtrans(5);
%
% Parameters: 
% Inputs: 	
%         place_name: name (string) identifying the place
%         OR  p_index: index identifying the place
%
% Output:  set of transitions (both indices and names)
% 
% Functions called : (check_valid_transition)

% Reggei.Davidrajuh@uis.no (c) 19.April.2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

A = PN.incidence_matrix;

if ischar (p_index)
    p_index = check_valid_place(p_index);
end

outputTrans = transpose(A(:, p_index));
tOs = find(outputTrans);
tNames = {PN.global_transitions(tOs).name};
