function [] = write_COMMON_PRE(PNMLfile, global_transitions)
% function []= write_COMMON_PRE(PNMLfile, global_transitions)

fid = fopen('COMMON_PRE.m', 'w'); % open the file with write permission

lineStr = ['% COMMON_PRE file generated from PNML file "', PNMLfile, '"'];
fprintf(fid, '%s\n', lineStr);

lineStr = '% ''COMMON_PRE.m''  ';
fprintf(fid, '%s\n\n', lineStr);

lineStr = 'function [fire, transition] = COMMON_PRE(transition)';
fprintf(fid, '%s\n', lineStr);

lineStr = '%function [fire,transition] = COMMON_PRE(transition)';
fprintf(fid, '%s\n\n', lineStr);

lineStr = ['if (strcmpi(transition.name, ', char(39), ...
    global_transitions(1).id, char(39), ')),'];
fprintf(fid, '%s\n\n', lineStr);

for i = 2:length(global_transitions)
    lineStr = ['elseif (strcmpi(transition.name, ', char(39), ...
        global_transitions(i).id, char(39), ')),'];
    fprintf(fid, '%s\n\n', lineStr);
end

lineStr = 'else'; fprintf(fid, '%s\n', lineStr);
lineStr = '    % error ([''Error in the transition name: '', transition.name]);';
fprintf(fid, '%s\n', lineStr);
lineStr = 'end;'; fprintf(fid, '%s\n\n', lineStr);

lineStr = '% fire = 1; % let it fire'; fprintf(fid, '%s\n', lineStr);

fclose(fid);
