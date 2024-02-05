function [TI] = tinvariant(PN)
%        [TI] = tinvariant(PN)
% Name:	tinvariant
% Purpose:	Finds transition invariant
% Input parameters:	[]
% Uses:	PNCT_tinvar
%
% NOTE !!!!:	the function PNCT_tinvar is wholly 
%               developed by Univ. of Cagliari and are part of the 
%               their "Petri Net Control Toolbox"
%               these two functions are included with specific prefix
%               PCNT_, thus plottree is renamed as PNCT_plottree and
%                           graph is renamed as PNCT_graph 
%       
% Example:	
%

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%
% convert GPenSIM PN structure into 
%           "Cagliari "Petri Net Control Toolbox" structure
[Pre_A, Post_A] = gpensim_2_PNCT(PN.incidence_matrix); 

% call "Cagliari Petri Net Control Toolbox" pinvar function 
TI = PNCT_tinvar(Post_A - Pre_A);
if isempty(TI), return; end;

TI = TI';
disp(' '); disp('T-invariants:  ');
print_transitions(TI);

