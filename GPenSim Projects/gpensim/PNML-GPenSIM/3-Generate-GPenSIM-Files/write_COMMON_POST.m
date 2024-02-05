function [] = write_COMMON_POST(PNMLfile, global_transitions)
% function []= write_COMMON_POST(PNMLfile, global_transitions)

fid = fopen('COMMON_POST.m', 'w'); % open the file with write permission

lineStr = ['% COMMON_POST file generated from PNML file "', PNMLfile, '"'];
fprintf(fid, '%s\n', lineStr);

lineStr = '% ''COMMON_POST.m''  '; 
fprintf(fid, '%s\n\n', lineStr);

lineStr = 'function [] = COMMON_POST(transition)';
fprintf(fid,'%s\n',lineStr);

lineStr = '%function [] = COMMON_POST(transition)';
fprintf(fid, '%s\n\n', lineStr);


lineStr = ['if (strcmpi(transition.name, ', char(39), ...
    global_transitions(1).id, char(39), ')),'];
fprintf(fid, '%s\n\n', lineStr);

for i = 2:length(global_transitions)
    lineStr = ['elseif (strcmpi(transition.name, ', char(39), ...
        global_transitions(i).id, char(39), ')),'];
    fprintf(fid, '%s\n\n', lineStr);
end;

lineStr = 'else'; 
fprintf(fid, '%s\n', lineStr);
lineStr = '    % error ([''Error in the transition name: '', transition.name]);';
fprintf(fid, '%s\n', lineStr);

lineStr = 'end;'; 
fprintf(fid, '%s\n\n', lineStr);

fclose(fid);
