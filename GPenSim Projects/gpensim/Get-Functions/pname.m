function [place_name] = pname(p_index)
% function [place_name] = pname(p_index)
%       (return the name of the place)
%
% Purpose:
%   To get the name (ASCII string) of the place 
%
% Input:    index of the place (1 - Ps)
% Output:   Name of the place as an ASCII string 
%
% Usage:	
%   place_name = pname(p_index));
%

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 20 September 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
Ps = PN.No_of_places;

if or(lt(p_index, 1), gt(p_index, Ps))
    error('Place index either less than 1 or greater than Ps');
end;

place_name = PN.global_places(p_index).name; 