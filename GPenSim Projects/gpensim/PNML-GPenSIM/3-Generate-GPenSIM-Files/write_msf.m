function [] = write_msf(PNMLfile, global_places)
% function [] = write_msf(PNMLfile, global_places)

fid = fopen('msf.m', 'w');  % open the file with write permission

lineStr='% GPenSIM Main Simulation File ';fprintf(fid,'%s\n',lineStr);
lineStr =['% this MSF is generated from PNML file "', PNMLfile, '"'];
fprintf(fid, '%s\n', lineStr);
lineStr = '% MSF: ''msf.m''  '; fprintf(fid, '%s\n\n', lineStr);
lineStr = 'clear all; clc; '; fprintf(fid, '%s\n\n', lineStr);
lineStr = 'global global_info; % global user data attached to global_info';
fprintf(fid, '%s\n', lineStr);
lineStr='global_info.PRINT_LOOP_NUMBER = 1; ';fprintf(fid,'%s\n\n',lineStr);
lineStr='pns = pnstruct(''pdf_pdf'');';fprintf(fid,'%s\n',lineStr);

lineStr = 'dyn.m0 = {';
pairs = 0;
for i = 1:length(global_places)
    % just a fix for Ian Liu's problem: 
    % if m0 is defined as a sting 'Default,1' or 'Default,0', and NOT 
    % just as a character like '1','2', or '1000' as expected 
    if strfind(global_places(i).m0, 'Default,')
        global_places(i).m0 = global_places(i).m0(9:end);
    end

    if eval(global_places(i).m0)  % initial tokens not zero
        pairs = pairs + 1;
        if eq(pairs, 4)
            lineStr = [lineStr, '...'];fprintf(fid, '%s\n', lineStr); 
            lineStr = '          ';
            pairs = 0;          
        end
        lineStr = [lineStr, char(39), global_places(i).id, char(39),','];
        lineStr = [lineStr, global_places(i).m0, ', '];    
    end
end
lineStr = [lineStr(1:end-2), '};']; fprintf(fid, '%s\n\n', lineStr);
lineStr = 'pni = initialdynamics(pns, dyn);';fprintf(fid,'%s\n', lineStr);
lineStr = 'sim = gpensim(pni);'; fprintf(fid, '%s\n\n', lineStr);
lineStr = 'prnss(sim);'; fprintf(fid, '%s\n\n', lineStr);

fclose(fid);

