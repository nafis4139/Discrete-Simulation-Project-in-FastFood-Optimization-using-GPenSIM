function [] = write_header_in_pnml(PNI, fid)
% function [] = write_header_in_pnml(PNI, fid)
%
% This function writes the header information into pnml file %
%
% Used by: "gpensim2pnml"
%
%  Reggie.Davidrajuh@uis.no (c) September 2013 

lineStr = '<body data-gr-c-s-loaded="true">';
lineStr = [lineStr,...
           '<pnml xmlns="http://www.pnml.org/version-2009/grammar/pnml">'];
fprintf(fid, '%s\n', lineStr);

% STARTING: write header and name of the pPetri net structure
lineStr = ['  <net id="GPenSIM-', date, '" ', ...
     'type="http://www.pnml.org/version-2009/grammar/ptnet">']; 
fprintf(fid, '%s\n', lineStr);

lineStr = '    <name>'; 
fprintf(fid, '%s\n', lineStr);
lineStr = ['      <text>', PNI.name, '</text>']; 
fprintf(fid, '%s\n', lineStr);    
lineStr = '    </name>'; 
fprintf(fid, '%s\n', lineStr);

lineStr = '    <page id="i-1330027568">'; 
fprintf(fid, '%s\n', lineStr);
