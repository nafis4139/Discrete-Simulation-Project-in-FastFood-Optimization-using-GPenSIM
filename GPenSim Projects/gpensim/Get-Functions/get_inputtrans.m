function [tIs, tNames] = get_inputtrans(p_index)
% [t_indices, tNames] = get_inputtrans('place_name' or p_index)
%
% Purpose: This function returns the set of input transitions of a place.
% 
% Sample Use:
%      [t_indices, tNames] = get_inputtrans('pbuffer_1');
%      [t_indices, tNames] = get_inputtrans(5);
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

Ps = PN.No_of_places;
A = PN.incidence_matrix;

if ischar (p_index)
    p_index = check_valid_place(p_index);
end

inputTrans = transpose(A(:, Ps+p_index));
tIs = find(inputTrans);
tNames = {PN.global_transitions([tIs]).name};
