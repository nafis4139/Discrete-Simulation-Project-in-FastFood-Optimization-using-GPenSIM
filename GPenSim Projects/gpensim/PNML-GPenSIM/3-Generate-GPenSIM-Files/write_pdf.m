function [] = write_pdf(PNMLfile, global_places, global_transitions, ...
                        global_arcs)
% function [] = write_pdf(PNMLfile, global_places, global_transitions, ...
%                       global_arcs)
PDFfileName = ['pdf', num2str(floor(unifrnd(1, 10000))),'_pdf.m']; 
fid = fopen(PDFfileName, 'w'); % open the file with write permission

lineStr = ['% GPenSIM PDF file generated from', PNMLfile, ' ...'];
fprintf(fid, '%s\n', lineStr);
lineStr = '% PDF: ''pdf_pdf.m''  '; fprintf(fid, '%s\n\n', lineStr);
lineStr = 'function [png] = pdf_pdf()'; fprintf(fid, '%s\n\n', lineStr);
lineStr = ['png.PN_name = ', char(39), 'PDFxxx', char(39), ';'];
fprintf(fid, '%s\n', lineStr);

pairs = 0;
lineStr = 'png.set_of_Ps = {';
for i = 1:length(global_places)
    pairs = pairs + 1;
    if eq(pairs, 4)
        lineStr = [lineStr, '...']; fprintf(fid, '%s\n', lineStr); 
        lineStr = '          ';
        pairs = 0;          
    end
    lineStr = [lineStr, char(39), global_places(i).id, char(39),','];
end
lineStr=[lineStr(1:end-2), char(39), '};']; fprintf(fid,'%s\n',lineStr);

pairs = 0;
lineStr = 'png.set_of_Ts = {';
for i = 1:length(global_transitions)
    pairs = pairs + 1;
    if eq(pairs, 4)
        lineStr = [lineStr, '...']; fprintf(fid, '%s\n', lineStr); 
        lineStr = '          ';
        pairs = 0;          
    end
    lineStr = [lineStr, char(39), global_transitions(i).id, char(39),','];
end
lineStr=[lineStr(1:end-2),char(39),'};']; fprintf(fid,'%s\n',lineStr);

lineStr = 'png.set_of_As = {';
arcs = 0;
for i = 1:length(global_arcs)
    arcs = arcs + 1;
    if eq(arcs, 3)
        lineStr = [lineStr, '...']; fprintf(fid, '%s\n', lineStr); 
        lineStr = '       ';
        arcs = 0;
    end
    lineStr = [lineStr, char(39), global_arcs(i).source, char(39),','];
    lineStr = [lineStr, char(39), global_arcs(i).target, char(39),','];
    lineStr = [lineStr, global_arcs(i).weight, ', '];    
end
lineStr = [lineStr(1:end-2), '};']; fprintf(fid, '%s\n', lineStr);

fclose(fid);
