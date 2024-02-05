function [PN] = pnstruct(fileNames) 
% function [PN] = pnstruct(set_of_PDF_files)
%                (create Petri Net Structure) 
%
% Purpose: 
% This function reads the petri net definition file(s), which
% are identified by the input filename. Then, it creates 
% the structure for the Petri net.
%
% Arguments: 
%   Inputs: PDF_filename(s)
%   Output: PN: The Petri net structure
% 
% Usage:    
%   PN = pnstruct('test0506_pdf');
%   PN = pnstruct({'test0506_pdf', 'module1_pdf', 'module1_pdf'});
%
% Functions called : 
%   png_places, png_trans, png_incidencematrix, png_inhibitormatrix
%   (utility) check_valid_file
%                      
%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%  renamed "pnstruct" from "petrinetgraph" 15 November 2013 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN % because of incidencematrix() 

%%%% for single definition file %%%%%
[global_set_of_As, global_set_of_Is] = png_process_DEF_files(fileNames);
png_Vplaces(); % PN = png_Vplaces(PN);
png_incidencematrix(global_set_of_As);
png_inhibitormatrix(global_set_of_Is);
png_modules(); % creating module-membership table (MMT)and PN.name

