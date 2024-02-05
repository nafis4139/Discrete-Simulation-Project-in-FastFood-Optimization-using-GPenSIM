function [COTREE] = cotreei(pni, sizeOfcotree)   
% function [COTREE] = cotree(pni, sizeOfcotree)   
%           Coverability Tree for Petri net with inhibitor arcs
% Purpose:	
%           Creates coverability tree of a Petri net with inhibitor arcs
%           and then print the tree on screen.
%
% Input parameters:	
%   pni: the marked petri net (obtained from "initialdynamics")
%   sizeOfcotree: the maximum number of states of the cotree
%
% Output parameters:	
%   A structure for COTREE
%       
% Uses:	
%   build_cotree_i
%
% Example:	
%   % in main simulation file
%   pns = pnstruct('cotree_example_def');
%   dyn.m0 = {'p1',2, 'p4', 1};  % initial markings
%   pni = initialdynamics(pns, dyn);
%   cotree(pni, 10);   % find the cotree, max sixe 10m states

%   Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 10.september 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;
PN = pni;
X0 = pni.X;

if not(PN.Inhibitors_exist), 
    disp(' function "cotreei" is for Petri net with INHIBIOTOR arcs');
    disp(' This Petri net does not has INHIBIOTOR arcs');
    disp('use "cotree" instead');
    return
end;

if eq(nargin, 1), % 
    disp(' '); 
    disp(' finding the cotree for Petri net with INHIBITOR ARCS'); 
    disp('  cotree_i takes three input arguments (parameters)'); 
    disp('        cotreei(pni, sizeOfCotree)'); 
    disp('  e.g. "cotreei(pni, 10)" '); disp(' '); 
    return
end;

[COTREE] = build_cotree_i(X0, sizeOfcotree); 
print_cotree(COTREE); 
