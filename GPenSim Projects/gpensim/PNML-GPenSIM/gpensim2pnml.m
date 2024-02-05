function [] = gpensim2pnml(pni)
% function [] = gpensim2pnml(pni)
%
% This function creates pnml file from gpensim "pnstructure": 
% "pnstructure" must be created by function either 
% "pnstruct" or "initialdynamics"
% 
% Input: pnstructure (created by functions "pnstruct" or "initialdynamics") 
% Output: PNML file
%         Name of the pnml file: 'pnmlxxx.xml'  xxx is a random number 
%                                   from 0 to 999
%               
%
% Example-1:
%   pns = pnstruct('example_pdf');
%   gpensim2pnml(pns);
% 
%   Note: the pnml file will state that all initial markings 
%         will be zero, and the Petri net is untimed.
%
% Example-2:
%   pns = pnstruct('example_pdf');
%   pni = initialdynamics(pns, dyn);
%   gpensim2pnml(pni)
%
%   Note: the pnml file will reflect the initial markings fron dyn;
%         Also, the Petri net is timed.
%
%
%  Reggie.Davidrajuh@uis.no (c) September 2013 

randomInteger = floor(unifrnd(1,1000));
randomIntStr = num2str(randomInteger); 
PNMLfileName = ['pnml_', randomIntStr, '.xml'];

fid = fopen(PNMLfileName, 'w'); % open file with write permission

write_header_in_pnml(pni, fid);

write_places_in_pnml(pni, fid);
write_transitions_in_pnml(pni, fid);    
write_arcs_in_pnml(pni, fid);    


write_closing_in_pnml(PNMLfileName, fid);
type(PNMLfileName);

