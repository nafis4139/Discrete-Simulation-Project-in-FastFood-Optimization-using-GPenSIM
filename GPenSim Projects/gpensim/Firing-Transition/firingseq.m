function [allowed] = firingseq()
%        [allowed] = firingseq()
% Purpose:
%   To fire only the transition declared in the OPTION
%   global_info.FIRING_SEQ 
%   The transitions declared in this sequence will be allowed 
%   to fire in the strict sequence order. 
%
% Declaration (OPTION) in the MSF:
%   global_infoFIRING_SEQ = {'t1','t3', 't2'}; the firing sequence
%   global_info.FS_REPEAT = 3; % how many times the sequence has to be
%          repeated; if this option is missing, then default value of 1 
%          will be set.
%   global_info.FS_ALLOW_PARALLEL = false; % whether to allow a transition 
%          to start firing, when the previous one is still firing
%          (overlapping firings). if this option is missing, then default 
%          value of 'false' will be set.
%
%    
% Usage:	
%   % in the pre-processors (specific, COMMON_PRE, or modular common_pre)  
%   % put any code for pre-processor here
%   fire = sequence; 
%
% CAUTION !!!!!!!
%     In the pre-processor files, the output argument "fire" 
%     must be ONLY assigned with the value of the function "firingseq". 
%     Otherwise, the program will malfunction.

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 05 February 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global global_info
global PN
t = PN.attempting_trans;

% whether it is the enabled transition's turn to fire 
allowed = 0; % no, just to start

% check whether the firing sequences are declared in MSF
if not(isfield(global_info, 'FIRING_SEQ')),
    prnerrormsg(['"global_info.FIRING_SEQ" is not set.', ...
                 'Type "help firingseq" ...']);
end

% check whether the firing sequences are already completed
if gt(global_info.FS_Repeat_Count, global_info.FS_REPEAT),% fseq complete
    return
end

% check whether overalpping (parallel) firing is not allowed
if not(global_info.FS_ALLOW_PARALLEL),
    % if overalpping (parallel) firing is not allowed
    if is_firing(), % is any transition firing now
        return      % then this enables transition can not fire 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now the main part
ptr = global_info.FS_Current_Ptr; % current index in the sequence
FSeq = global_info.FIRING_SEQ;    % get a copy of the constant

current_trans_id = FSeq(ptr); % get the trans 
% current_trans_id = is_trans(current_trans_on_Seq); % get the tid
% if not(current_trans_id), % not a valid tid?
%     prnerrormsg(['Wrong trans name in the firing sequence: "', ...
%         current_trans_on_Seq, '"']);
% end   

% see whether the tid of enabled trans is the same as current index in FSeq
if eq(current_trans_id, t),   
    allowed = 1;
    if eq(ptr, 1), % ptr ===1 means start of a new sequence
        disp(' '); disp(['Starting a sequence nr. ',...
              int2str(global_info.FS_Repeat_Count)]);
    end 
    ptr = ptr + 1;  % shift the current index to next in line in the seq
    if gt(ptr, length(FSeq)), % if index overflows means a new sequence 
        ptr = 1;    
        global_info.FS_Repeat_Count = global_info.FS_Repeat_Count + 1;
        if gt(global_info.FS_Repeat_Count, global_info.FS_REPEAT), % zero
            disp(' ');
            disp('************************************');
            disp('Completing the Firing Sequences ....');
            disp('************************************'); disp(' ');
        end        
    end
    global_info.FS_Current_Ptr = ptr;
end
