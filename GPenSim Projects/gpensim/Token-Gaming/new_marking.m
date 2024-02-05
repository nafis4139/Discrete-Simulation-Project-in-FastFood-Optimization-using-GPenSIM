function [X1] = new_marking(t)
%	function X1 = new_markings(t)
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

A = PN.incidence_matrix;
X = PN.X;
Ps = PN.No_of_places; 

Removals = A(t,1:Ps);
Deposits = A(t,Ps+1:2*Ps);
X1 = X + Deposits - Removals;

