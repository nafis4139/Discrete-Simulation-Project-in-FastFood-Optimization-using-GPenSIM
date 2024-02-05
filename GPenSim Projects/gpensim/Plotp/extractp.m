function [TOKEN_MATRIX] = extractp(set_of_places)
% [TOKEN_MATRIX] = extractp(set_of_places)
% 
% Name:	extractp
% Purpose:	To extract tokens from the Simulation results structure. 
% Input parameters:	Simulation Results (the structure output by ‘gpensim’)
%                   {set_of_place_names}
% Out parameters:	TOKEN_MATRIX 
%            First row :[0 set_of_place_indices]
%            Second & subsequent rows: 
%                [first column is time, other columns are tokens]
% Uses:	None
% Used by:	[main simulation file], 
%           plotp
% Example:	
%   % in main simulation file
%   sim = gpensim(png, dynamic);
%   plotp(sim, {'p1','p2','p3'});
%   extractp(sim, {'p1','p2','p3'}) % print the token matrix
% 

%  Reggie.Davidrajuh@uis.no (c) Version 7.0 (c) 30 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
Ps = PN.No_of_places;

nr_rows = size(PN.LOG, 1);

TOKEN_MATRIX = zeros(1, nr_rows); % transpose of the final

P_INDICE = 0; %start with 0 element

for i = 1:length(set_of_places)
    place_name = set_of_places{i};  pi = check_valid_place(place_name);
    
    tok_mat = transpose(PN.LOG(:, pi));
    TOKEN_MATRIX = [TOKEN_MATRIX; tok_mat]; 
    P_INDICE = [P_INDICE pi];
end;

TOKEN_MATRIX = transpose(TOKEN_MATRIX);
time_series = PN.LOG(:, Ps+6); % !!!! IMPORTANT: Ps+6 is the finishing time
if any (time_series)
    TOKEN_MATRIX(:,1) = time_series;
else
    TOKEN_MATRIX(:,1) = (1:nr_rows)';
end;

TOKEN_MATRIX = [P_INDICE; TOKEN_MATRIX]; %% add place indice
