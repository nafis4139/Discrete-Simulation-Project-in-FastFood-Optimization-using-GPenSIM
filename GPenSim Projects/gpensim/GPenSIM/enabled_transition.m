function [enabled] = enabled_transition(t) 
% function [enabled] = enabled_transition(t) 
%     Does the transiiton is enabled or not
%
% Purpose:
%   This function checks whether a given transition is enabled 
%   to fire or not. To be anbled, all the input places of the 
%   given transition must has enough tokens.
%
% Parameters:
%   Input:     t: transition name or transition index
%   Output:    boolean value:  enabled or not

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

% if tansition name is given then convert it to number 
if ischar(t), t = check_valid_transition(t); end;
    
A =  PN.incidence_matrix;
X =  PN.X;
Ps = PN.No_of_places;      % number of places

Input_Places = A(t, 1:Ps); % get the input places with arcs weights

if any(Input_Places), % transitions with input places 
   % input_place = A(t, 1:Ps); % input places for transition t
   % check if there are non_ zero numbers along the input place array
   index_IP = any(Input_Places, 1); % index of input place
   
   %input arcs extending from input places to a given transition
   input_arcs = Input_Places(index_IP); 
   input_tokens = X(index_IP); %tokens in input places

   % check if all input tokens er greater than or equal all corresponding-
   % input arcs
   % only when all input tokens are greater than or equal to the input-
   % arcs is a given transition is enabled
   enabled = all(ge(input_tokens, input_arcs));
else  % transitions with no input places 
   enabled = 1; % transitions with no input places are always enabled
end; %if any(Places)

if (PN.Inhibitors_exist),
    if  PN.Inhibited_Transitions(t),
        inhibiting_values = PN.inhibitor_matrix(t,:);
        current_tokens = PN.X;
        ct_lessthan_iv = lt(current_tokens, inhibiting_values);
        not_inhibited_this_time = all(ct_lessthan_iv);
        enabled = and(enabled, not_inhibited_this_time);
    end;
end;
