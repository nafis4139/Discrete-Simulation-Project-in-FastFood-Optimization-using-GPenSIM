function [] = write_def(set_of_Ps, set_of_Ts, set_of_As)
% function [] = write_def(set_of_Ps, set_of_Ts, set_of_As)

PDFfileName = 'def_def.m'; 
fid = fopen(PDFfileName, 'w'); % open the file with write permission

%lineStr = ['% GPenSIM PDF file generated from PNML file "', PNMLfile , '"'];
%fprintf(fid, '%s\n', lineStr);
lineStr = ['% DEF: ', PDFfileName] ; fprintf(fid, '%s\n\n', lineStr);
lineStr = 'function [png] = def_def()'; fprintf(fid, '%s\n\n', lineStr);
lineStr = ['png.PN_name = ', char(39), 'DEFxxx', char(39), ';'];
fprintf(fid, '%s\n', lineStr);

pairs = 0;
lineStr = 'png.set_of_Ps = {';
for i = 1:length(set_of_Ps),
    pairs = pairs + 1;
    if eq(pairs, 7),
        lineStr = [lineStr, '...']; fprintf(fid, '%s\n', lineStr); 
        lineStr = '          ';
        pairs = 0;          
    end;          
    lineStr = [lineStr, char(39), set_of_Ps{i}, char(39),','];
end;
lineStr=[lineStr(1:end-2), char(39), '};']; fprintf(fid,'%s\n',lineStr);

pairs = 0;
lineStr = 'png.set_of_Ts = {';
for i = 1:length(set_of_Ts),
    pairs = pairs + 1;
    if eq(pairs, 7),
        lineStr = [lineStr, '...']; fprintf(fid, '%s\n', lineStr); 
        lineStr = '          ';
        pairs = 0;          
    end;          
    lineStr = [lineStr, char(39), set_of_Ts{i}, char(39),','];
end;
lineStr=[lineStr(1:end-2),char(39),'};']; fprintf(fid,'%s\n',lineStr);

lineStr = 'png.set_of_As = {';
arcs = 0;
for i = 1:3:length(set_of_As),
    arcs = arcs + 1;
    if eq(arcs, 4),
        lineStr = [lineStr, '...']; fprintf(fid, '%s\n', lineStr); 
        lineStr = '       ';
        arcs = 0;
    end;        
    lineStr = [lineStr, char(39), set_of_As{i}, char(39),','];
    lineStr = [lineStr, char(39), set_of_As{i+1}, char(39),','];
    lineStr = [lineStr, int2str(set_of_As{i+2}), ', '];    
end;
lineStr = [lineStr(1:end-2), '};']; fprintf(fid, '%s\n', lineStr);

fclose(fid);