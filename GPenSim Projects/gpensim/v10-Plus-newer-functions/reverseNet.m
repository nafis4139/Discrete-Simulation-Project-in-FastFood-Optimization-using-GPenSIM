function [pnR] = reverseNet()
% [pnR] = reverseNet()
%     "reverse a Petri Net"
%
% Purpose:
% This function reverses a PN so that input places of a transition 
% becomes output places and vice versa. 
%
% Define variables: 
% E.g. pnR = reversePN(); 
%
% Arguments: 
% Inputs: (none)
% Output: reversed PN 
% 
% Functions called : 
%
% Reggie.Davidrajuh@uis.no  (c) 19 Dec 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

pnR = PN;

Ps = PN.No_of_places;
A = PN.incidence_matrix;

inputIA = A(:, 1:Ps);
outputIA = A(:, Ps+1:end);
AR = [outputIA, inputIA]; 
pnR.incidence_matrix = AR;
