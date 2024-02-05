function [] = write_places_in_pnml(PNI, fid)
%  function [] = write_places_in_pnml(PNI, fid)
%
% Writes information about the places into pnml file %
%
% Used by: "gpensim2pnml"
%
%  Reggie.Davidrajuh@uis.no (c) September 2013 

Ps = PNI.No_of_places;
for i = 1:Ps
    place_i = PNI.global_places(i);
    placeName = place_i.name;
    tokens = place_i.tokens;    
    
    lineStr = ['    <place id="', placeName, '">']; 
    fprintf(fid, '%s\n', lineStr);    
    lineStr = ['      <name>']; 
    fprintf(fid, '%s\n', lineStr);    
    lineStr = ['         <text>', placeName, '</text>']; 
    fprintf(fid, '%s\n', lineStr);        
    lineStr = ['      </name>']; 
    fprintf(fid, '%s\n', lineStr);        

    lineStr = ['      <initialMarking>']; 
    fprintf(fid, '%s\n', lineStr);    
    lineStr = ['         <text>', int2str(tokens), '</text>']; 
    fprintf(fid, '%s\n', lineStr);        
    lineStr = ['      </initialMarking>']; 
    fprintf(fid, '%s\n', lineStr);            

    lineStr = '    </place>'; 
    fprintf(fid, '%s\n', lineStr);        
end