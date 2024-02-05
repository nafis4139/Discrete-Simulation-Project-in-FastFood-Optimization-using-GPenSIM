function [S] = siphons(PN) 
%        [S] = siphons(PN) 
% SIPHONS : determines the siphons of a place/transition net
% This function returns a  matrix of 0's and 1's
%        of size (k x No_of_places)
%
%            X = [ x_1; x_2;  ... x_k]           
%
%        where for all i the support of x_i:   
%
%  A siphon is a set of places where 
%  the set of output transitions S_i*  is contained 
%        in the set of input transitions *S_i.

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ps = PN.No_of_places;   
A = PN.incidence_matrix;
Ain = A(:, 1:Ps); Aout = A(:, Ps+1:end);
Pre  = Ain';  Post = Aout';

S = PNCT_siphons(Pre, Post);

disp(' '); disp('Siphons in this net:');
print_places(S);
