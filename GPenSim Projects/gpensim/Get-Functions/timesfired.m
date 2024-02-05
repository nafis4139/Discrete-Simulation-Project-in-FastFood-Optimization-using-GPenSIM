function [ntf] = timesfired(t_index)
% function [ntf] = timesfired(t_index)
%                "Number of Times Fired" 
%
% Purpose:
% This function return the number of times 
% the transitions has already fired. 
%
% Arguments: 
% Inputs:  t_index: transition name (string) or transition index (number) %
% Output:  an integer ( >= 0) representing the number of times fired
%
% Usage:
% E.g. ntf = timesfired('Robot_1'); 
%      ntf = timesfired(3);  % t_index is 3
%
% Functions called : get_trans
%

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 01 September 2016  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tx = get_trans(t_index); % get a local copy of the transitions
ntf = tx.times_fired;    % see how many times it has fired
