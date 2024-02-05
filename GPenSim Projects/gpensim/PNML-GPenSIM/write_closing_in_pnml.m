function [] = write_closing_in_pnml(PNMLfileName, fid)
% function [] = write_closing_in_pnml(PNMLfileName, fid)
%
% Writes the closing lines into pnml file %
%
% Used by: "gpensim2pnml"
%
%  Reggie.Davidrajuh@uis.no (c) September 2013 

% CLOSING: write </net> and </pnml>

lineStr = '  </page>'; 
fprintf(fid, '%s\n', lineStr);
lineStr = '  </net>'; 
fprintf(fid, '%s\n', lineStr);

lineStr = '</pnml>';
fprintf(fid, '%s\n', lineStr);
lineStr = '</body>';
fprintf(fid, '%s\n', lineStr);
fclose(fid);
disp('***********'); 
disp(['PNML file "',PNMLfileName,'" is created.']);
disp('***********'); 


