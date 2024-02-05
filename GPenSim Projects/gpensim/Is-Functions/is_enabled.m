function [status] = is_enabled(transition1)
% function [status] = is_enabled(transition1)
%        Is the transition enabled, right now? 
%
% Purpose:
%   To check whether a specific transition is enabled right now.  
%
% Arguments:
%   Inputs:  Name of the transition (Alternatively: "tid" of transition)  
% 
%   Outputs: 0 = false, 1 = true
%
% Usage:	
%   status = is_enabled('tX1');
%
% Functions used:
%   is_trans (to check whether the input transition name is correct)

%  Reggie.Davidrajuh@uis.no (c) Version 8.0 (c) 10 June 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

%if t is name then convert into number
if ischar(transition1),
    transition1 = is_trans(transition1); 
end;

status = PN.Enabled_Transitions(transition1);

