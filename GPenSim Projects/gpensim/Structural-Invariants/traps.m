function [T] = traps(PN)
%        [T] = traps(PN) 
% TRAPS : determines the traps of a place/transition net
% This function returns a  matrix of 0's and 1's
%        of size (No_of_places x k)
%
%            X = [ x_1 x_2  ... x_k ]           
%
%        where for all i the support of x_i:   
%
%           S_i = { p | x_i(p) = 1 } is a trap,  
%
%        i.e., the set of output transitions S_i*  is contained 
%        in the set of input transitions *S_i.
%
%

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ps = PN.No_of_places;   
A = PN.incidence_matrix;   

Ain = A(:, 1:Ps);  Aout = A(:, Ps+1:end);
Pre  = Ain';  Post = Aout';

T = PNCT_traps(Pre, Post);

disp(' '); 
disp('Traps in this net:');
print_places(T);
