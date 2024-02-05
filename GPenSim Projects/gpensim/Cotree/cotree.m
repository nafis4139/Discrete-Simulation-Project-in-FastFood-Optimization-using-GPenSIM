function [COTREE] = cotree(pni, plot_ct, print_ct)   
% function [COTREE] = cotree(pni, plot_ct, print_ct)   
%           Coverability Tree
% Purpose:	
%           Creates the coverability tree of a Petri net 
%           and then plot it and print (ASCII listing) it.
%
% Input parameters:	
%   pni is the marked petri net (obtained from "initialdynamics")
%   plot_ct  = 1, if graphical plot if needed
%   print_ct = 1, if ASCII listing on screeen is needed 
%   e.g. "cotree(pni, 1, 1)" for both plot and print
%
% Output parameters:	
%   A structure for COTREE
%       
% Uses:	
%   plot_cotree    (plot_cotree is a modified code of Cagliari Univ). 
%   print_cotree   
%
% Example:	
%   % in main simulation file
%   pns = pnstruct('cotree_example_def');
%   dyn.m0 = {'p1',2, 'p4', 1};  % initial markings
%   pni = initialdynamics(pns, dyn);
%   cotree(pni,1);   % only one argument: the graphical plot only
%   cotree(pni,1,1); % two arguments: graphical plot and/or ASCII display
%
% NOTE: function "cotree" is for Petri net without INHIBIOTOR arcs
%       For Petri net with INHIBIOTOR arcs, use the function "cotreei"

%   Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 10.september 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN
PN = pni;
X0 = pni.X;

if (PN.Inhibitors_exist)
    disp(' ');
    disp('Function "cotree" is for Petri net without INHIBIOTOR arcs');
    disp('This Petri net has INHIBIOTOR arcs');
    disp('Use "cotreei" instead');
    return
end

[COTREE] = build_cotree(X0);
PN.COTREE = COTREE;

if ge(nargin, 2) % now plot the cotree with the function plot_cotree
    if plot_ct, plot_cotree(X0); end
end

if eq(nargin, 3) % now print ASCII cotree 
     if print_ct 
        print_cotree(COTREE); 
    end
end