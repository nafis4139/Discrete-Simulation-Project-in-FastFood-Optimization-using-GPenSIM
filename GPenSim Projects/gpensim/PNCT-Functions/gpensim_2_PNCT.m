function [Pre_A, Post_A, D] = gpensim_2_PNCT(A)
% function [Pre_A, Post_A, D] = gpensim_2_PNCT(A)
% 
% convert GPenSIM Incidence Matrix into Cagliari 
%    "Petri Net Control Toolbox" incidence matices

%   Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) July 2017 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = size(A, 2)/2; % No_of_places

Pre_A  = A(:, 1:Ps)';       % Pre  places
Post_A = A(:, Ps+1:2*Ps)';  % Post places 
D = Post_A - Pre_A;         % Incidence Matrix