function [Dm, D, Dp] = matrixD
%function [Dm, D, Dp]= matrixD
% This function computes the following matrices 
%  from the GPenSIM extended incidence matrix (PN.incidence_matrix):
%    Dm (same as Ai - the input incidence matrix), 
%    D  (same as A - the incidence matrix), and 
%    Dp (same as Ao - the output incidence matrix) 
%
%    Reggie.Davidrajuh@uis.no (c) June 2016

global PN;

Ps = PN.No_of_places;
AA = PN.incidence_matrix;
Dm = AA(:, 1:Ps);
Dp = AA(:, Ps+1:end);
D = Dp - Dm;
