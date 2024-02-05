function [X0] = get_initial_marking(initial_dynamics)
%        [X0] = get_initial_marking(initial_dynamics)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function extracts a group of elements from a given inputs of
% global_elements and elements. The resulting output is an element matrix.
% function elements_m = elements_matrix(pn.global_elements, elements)
% Inputs:
%       -global elements
%      - elements
% Output: elemets matrix

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

Ps = PN.No_of_places;
X0 = zeros(1, Ps);  % initially

if not(isfield(initial_dynamics, 'm0')) % initial_markings
    warning('initial markings: NOT given ...'); disp(' ');
    
else
    imarkings = initial_dynamics.m0;
    
    if iscell(imarkings)  % sources = {'p1',1, 'p2', 3, ...}}
        no_of_sources = length(imarkings)/2; % number of places  
        % extracting places
        for i = 1:no_of_sources
            curr_source_name = imarkings{2*i -1};
            source_nr = check_valid_place(curr_source_name);    
            initial_tokens = imarkings{2*i};          
            X0(source_nr) = initial_tokens;       
        end
        
    else  % sources is a vector: imarkings = [1 3 0 0 1]
        if ne(length(imarkings), Ps)
            error('initial marking must be same length as number of places');
        end
        X0 = imarkings;
    end
end

