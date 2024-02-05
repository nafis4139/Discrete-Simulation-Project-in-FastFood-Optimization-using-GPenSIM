function [scc] = is_stronglyconn(PN)
% function [classtype] = is_stronglyconn(PN)
%       is strongly connected? 
% Purpose:
% This function checks whether the Petri net is strongly connected 
%
% Uses:
%   SCC = stronglyconn(PN)   % strongly connected components
%
% Used by: 
%
%       Reggie.Davidrajuh@uis.no (c) February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SCC = stronglyconn(PN); % find the strongly connected components
scc = eq(size(SCC,1), 1); % number of strongly connected components == 1?
