function [pIs, pNames] = get_inputplace(t_index)
% [p_indices, pNames] = get_inputplace('trans_name' or t_index)
%
% Purpose: This function returns the set of input places of a transition.
% 
% Sample Use:
%      [p_indices, pNames] = get_inputplace('tbuffer_1');
%      [p_indices, pNames] = get_inputplace(5);
%
% Parameters: 
% Inputs: 	
%          trans_name: name (string) identifying the transition 
%         OR  t_index: index identifying the transition 
%
% Output:  set of places (both indices and names)
% 
% Functions called : (check_valid_transition)

% Reggei.Davidrajuh@uis.no (c) 19.April.2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

Ps = PN.No_of_places;
A = PN.incidence_matrix;

if ischar (t_index)
    t_index = check_valid_transition(t_index);
end

inputPlaces = A(t_index,1:Ps);
pIs = find(inputPlaces);
pNames = {PN.global_places([pIs]).name};

