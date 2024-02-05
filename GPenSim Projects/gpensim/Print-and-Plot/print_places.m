function [] = print_places (M, lead_string)
% function [] = print_places (M, lead_string)
% Matrix M (k, Ps) contains rows of places
% which is prduced by function siphons and traps, and place invariants
% 
% Reggie.Davidrajuh@uis.no    (c)  August 2016

global PN

if isempty(M), return; end

[m, n] = size(M); 

if eq(nargin, 1)
    % no lead string
    disp_str = '';
else
    disp_str = lead_string;
end

for i = 1:m
    disp_str = [disp_str '{'];
    for j = 1:n
        if M(i,j)
            disp_str = [disp_str, PN.global_places(j).name, ','];
        end
    end
    disp_str(end) = '}';
    disp(disp_str); disp_str = '';
end
