function [] = png_inhibitormatrix(global_set_of_Is)
%        [] = png_inhibitormatrix(global_set_of_Is)
% This function computes the inhibitor matrix of a Petri net
% Use: [] = png_inhibitormatrix(PN, global_set_of_Is)
% Inputs:
%       global_set_of_Is : Set of Inhibitor Arcs

%  Reggie.Davidrajuh@uis.no (c) Version 8.0 (c) 04 may 2013  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

Ps = PN.No_of_places;   Ts = PN.No_of_transitions;
Is = length(global_set_of_Is)/3;

% declare empty Inhibitor matrix  with 
IA = zeros(Ts, Ps);

for i = 1:3:Is*3, %
    p1 = global_set_of_Is{i};     t1 = global_set_of_Is{i+1};
    wt = global_set_of_Is{i+2};
    if not(isnumeric(wt)),
        error(['Check PDF: The inhibitor arc weight must be numeric: "',...
            p1, '",  "', t1, '", ', wt, ' !!']);
    end;
    pi = is_place(p1);   %'from place'
    tj = is_trans(t1);   %'to transition'
    if and(pi, tj),
        IA(tj, pi) = wt; % input place 
    else
        error(['Check PDF: the names in the Inhibitor arc :  "',...
            p1, '",  "', t1, '", ', int2str(wt)]);
    end;
end;

set_of_Inhibited_Transitions = any(IA, 2);
PN.Inhibited_Transitions = set_of_Inhibited_Transitions';
PN.Inhibitors_exist = any(set_of_Inhibited_Transitions);

% transform IA into more managable 
if (PN.Inhibitors_exist), 
    % make the zero elements of IA as 'inf'
    [m, n] = size(IA);
    for i = 1:m, 
        for j = 1:n,
            if not(IA(i,j)),
                IA(i,j) = inf;
            end;
        end;
    end;
    PN.inhibitor_matrix = IA;
else
    PN.inhibitor_matrix = [];
end;
