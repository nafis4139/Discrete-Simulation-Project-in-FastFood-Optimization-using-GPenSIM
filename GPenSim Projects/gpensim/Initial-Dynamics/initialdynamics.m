function [PNI] = initialdynamics(png, dynamicpart)
%        [PNI] = initialdynamics(png, dynamicpart)
%               (create Petri Net initial dynamic structure)
%
% Purpose:
%   To create a Petri Net structure with initial dynamics (PNI) by
%   combining the static Petri net structure with initial dynamics.
%   PNI will be ready for simulation by gpensim
%
% Arguments:
%   Inputs:  Static Petri net structure (output from ‘pnstruct’)
%                     initial dynamics
%   Outputs: Petri Net structure with initial dynamics
%
% Usage:	
%   % in main simulation file
%   [pni] = initialdynamics(pns, dyn);
%
% Uses:     set_options, set_initial_dynamics, 
%           set_pre_post_files_register
% Used by:	[main simulation file]

%  Reggie.Davidrajuh@uis.no (c) Version 8.0 (c) 10 June 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global global_info;
if isempty (global_info),
    global_info.DUMMY = 'DUMMY';
end;

global PN;
PN = png;    % PN is global PetriNet model that will be bulid here

if (nargin==1), % no initial dynamics given 
    warning('initialdynamics expects 2 parameters: pns & initial dyn'); disp(' ');
    dynamicpart = [];
end;

% handle OPTIONS
set_options();    

% handle dynamic informations  such as "initial markings (m0)", 
%   "firing times (ft)", "initial priority (ip)", and "resources"
set_initial_dynamics(dynamicpart);

% check whether Preconditions and Postactions are available:
%      files: tdf_pre, tdf_post, COMMON_PRE, and COMMON_POST
set_pre_post_files_register();  % if exist, set the flag for TDF  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finally, return the PN structure with initial dynamics
PNI = PN;
