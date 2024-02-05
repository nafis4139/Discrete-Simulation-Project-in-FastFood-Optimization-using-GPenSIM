function [global_transitions] = png_trans(set_of_trans, Ps)
%        [global_transitions] = png_trans(set_of_trans, Ps)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% treating set_of_transitions
no_of_trans = length(set_of_trans); %number of elements to be extracted

% allocate empty matrix for accomodating elements extracted
global_transitions = []; 

% extracting elements
for i = 1:no_of_trans,
    trans.name = set_of_trans{i};
    trans.firing_time = 0; % default 
    trans.firing_cost = 0; % default 
    trans.times_fired = 0; % number of times fired initially, is zero
    %trans.resources_on_use   = []; % resources currently used by tx
    %trans.resources_reserved = []; % resources currently reserved by tx
    trans.absorbed_tokens = zeros(1, Ps);  % absorbed tokens during firing

    global_transitions = [global_transitions trans];
end;
