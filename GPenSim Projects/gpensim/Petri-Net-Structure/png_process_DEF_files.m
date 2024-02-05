function [global_set_of_As, global_set_of_Is] = ...
                   png_process_DEF_files(fileNames)
% function [global_set_of_As, global_set_of_Is] = ...
%                   png_process_DEF_files(fileNames)
%
%
%
%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN

[global_set_of_Ps,global_set_of_Ts,global_set_of_As,global_set_of_Is] = ...
    png_process_DEF_files_extract_elements(fileNames);

set_of_Ps = unique(global_set_of_Ps);
if ne(numel(global_set_of_Ps), numel(set_of_Ps))
    warning('some place(s) declared in more than one module'); 
end;

set_of_Ts = unique(global_set_of_Ts); 
if ne(numel(global_set_of_Ts), numel(set_of_Ts))
    error('some transiton(s) declared in more than one module'); 
end;

PN.global_places = png_places(set_of_Ps); 
PN.No_of_places = length(set_of_Ps); 
PN.global_transitions = png_trans(set_of_Ts, PN.No_of_places); 
PN.No_of_transitions = length(set_of_Ts); 

