function [] = write_GPenSIM_files(PNMLfile, global_places, ...
                  global_transitions, global_arcs)
%function [] =write_GPenSIM_files(PNMLfile, global_places, ...
%                 global_transitions, global_arcs)
%
% This function write the GPenSIM files on the current directory
%  Input:   PNMLfile: name of the PNML file
%           global_places, global_transitions, global_arcs

%  Reggie.Davidrajuh@uis.no (c) September 2013

write_pdf(PNMLfile, global_places, global_transitions, global_arcs);
write_msf(PNMLfile, global_places);
write_COMMON_PRE(PNMLfile, global_transitions);
write_COMMON_POST(PNMLfile, global_transitions);