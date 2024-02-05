function [global_set_of_Ps, global_set_of_Ts, global_set_of_As, ...
    global_set_of_Is] = png_process_DEF_files_extract_elements(fileNames)
% function [global_set_of_Ps, global_set_of_Ts, global_set_of_As, ...
%    global_set_of_Is] = png_process_DEF_files_extract_elements(fileNames)


global PN

if ischar(fileNames), fileNames = {fileNames}; end;
No_of_files = length(fileNames);
global_set_of_Ps = []; global_set_of_Ts = [];  % places and transitions
global_set_of_As = []; global_set_of_Is = [];  % arcs and inhibitor arcs

module_number = 0;
System_name = '';

for i = 1:No_of_files,
    funcname = char(fileNames(i)); filename = [funcname '.m']; check_valid_file(filename);
    [png] = feval(str2func(funcname));
    
    if isfield(png, 'PN_name'),  % extract module/File names
        pn_name = png.PN_name;
    else pn_name = funcname;
    end;
    
    if isfield(png, 'set_of_Ps'), % extract the places
        global_set_of_Ps = [global_set_of_Ps png.set_of_Ps];
    end;
    
    if isfield(png, 'set_of_Ts'),  % extract the transitions
        global_set_of_Ts = [global_set_of_Ts png.set_of_Ts];
    end;
    
    if isfield(png, 'set_of_As'),  % extract the arcs
        global_set_of_As = [global_set_of_As png.set_of_As];
    end;
    
    if isfield(png, 'set_of_Is'),   % extract the inhibiting arcs
        global_set_of_Is = [global_set_of_Is png.set_of_Is];
    end;
    
    if isfield(png, 'set_of_Ports'),  % extract the ports
        module_number = module_number + 1;        
        eval(['PN.module_', int2str(module_number), '_name = pn_name;']); 
        eval(['PN.module_', int2str(module_number), '_Ts = png.set_of_Ts;']); 
        eval(['PN.module_', int2str(module_number), '_Ports = png.set_of_Ports;']); 
    end;    
    System_name = [System_name, pn_name, ' + '];
end;

PN.No_of_modules = module_number; 
PN.name = System_name(1:end-3); % erase the final " + " in systems_name
