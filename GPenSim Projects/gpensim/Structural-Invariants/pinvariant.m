function [PI] = pinvariant(PN)
%        [PI] = pinvariant(PN)
% Name:	pinvariant
% Purpose:	Finds place invariant
% Input parameters:	[]
% Uses:	PNCT_pinvar
%
% NOTE !!!!:	the function PNCT_pinvar is wholly 
%               developed by Univ. of Cagliari and are part of the 
%               their "Petri Net Control Toolbox"
%               these two functions are included with specific prefix
%               PCNT_, thus plottree is renamed as PNCT_plottree and
%                           graph is renamed as PNCT_graph 
%       
% Example:	
%   % in cotree or in main simulation file 
%   png = petrinetgraph('cotree_example_def');
%   dyn.initial_markings = {'p1',2, 'p4', 1};
%   plot_cotree(png, dyn.initial_markings);
%

%   Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) July 2012 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%
% convert GPenSIM PN structure into 
%           "Cagliari "Petri Net Control Toolbox" structure
[Pre_A, Post_A] = gpensim_2_PNCT(PN.incidence_matrix); 

% call "Cagliari Petri Net Control Toolbox" pinvar function 
PI = PNCT_pinvar(Post_A - Pre_A);
if isempty(PI)
    disp('there are no P-invariants ....  ');
    return 
end

PI = PI';
disp(' '); disp('P-invariants:  ');
print_places(PI); 
