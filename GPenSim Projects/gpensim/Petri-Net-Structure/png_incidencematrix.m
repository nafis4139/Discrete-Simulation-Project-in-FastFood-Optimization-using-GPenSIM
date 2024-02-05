function [] = png_incidencematrix(global_set_of_As)
%        [] = png_incidencematrix(global_set_of_As)
%
% This function computes the incidence matrix of a Petri net
% Use: [] = incidence_matrix(global_set_of_As)
% Inputs:
%       global_set_of_As : Set of Arcs
%
% Outputs: -
%
%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%  Reggie.Davidrajuh@uis.no (c) Version 10  (c) 11 March 2019 (PN.No_of_arcs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN
Ps = PN.No_of_places;
Ts = PN.No_of_transitions;

As = length(global_set_of_As)/3;

% declare empty incidence matrix  with 
%       row    == no of transitions, and 
%       column == twice the number of places
A = zeros(Ts, 2*Ps);
for i = 1:3:As*3 %
    e1 = global_set_of_As{i};
    e2 = global_set_of_As{i+1};
    wt = global_set_of_As{i+2};
    
    pi = is_place(e1);   ti = is_trans(e2);
    tj = is_trans(e1);   pj = is_place(e2);       
    if and(pi, ti)
        A(ti, pi) = wt; % input place 
    elseif and(tj, pj)
        A(tj, pj + Ps) = wt; % output place
    else
        disp('Error in PDF');
        error(['Check the names in the arc :  "',e1, '",  "', e2, ...
            '", ', int2str(wt)]);
    end;
end;
PN.incidence_matrix = A;
