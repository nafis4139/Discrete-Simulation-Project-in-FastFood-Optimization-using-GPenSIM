function [] = write_transitions_in_pnml(PNI, fid)
%  function [] = write_transitions_in_pnml(PNI, fid)
%
% Writes information about the transitions into pnml file %
%
% Used by: "gpensim2pnml"
%
%  Reggie.Davidrajuh@uis.no (c) September 2013 

Ts = PNI.No_of_transitions;
for i = 1:Ts
    trans_i = PNI.global_transitions(i);
    transName = trans_i.name;
    firingtime = trans_i.firing_time;    
    
    lineStr = ['    <transition id="', transName, '">']; 
    fprintf(fid, '%s\n', lineStr);    
    lineStr = ['      <name>']; 
    fprintf(fid, '%s\n', lineStr);    
    lineStr = ['         <text>', transName, '</text>']; 
    fprintf(fid, '%s\n', lineStr);        
    lineStr = ['      </name>']; 
    fprintf(fid, '%s\n', lineStr);        

    if firingtime 
        lineStr = ['      <rate>']; 
        fprintf(fid, '%s\n', lineStr);    
        lineStr = ['         <text>', num2str(firingtime), '</text>']; 
        fprintf(fid, '%s\n', lineStr);        
        lineStr = ['      </rate>']; 
        fprintf(fid, '%s\n', lineStr);         
        lineStr = ['      <timed>']; 
        fprintf(fid, '%s\n', lineStr);    
        lineStr = ['         <text>', 'true', '</text>']; 
        fprintf(fid, '%s\n', lineStr);        
        lineStr = ['      </timed>']; 
        fprintf(fid, '%s\n', lineStr);                 
    else
        lineStr = ['      <timed>']; 
        fprintf(fid, '%s\n', lineStr);    
        lineStr = ['         <text>', 'false', '</text>']; 
        fprintf(fid, '%s\n', lineStr);        
        lineStr = ['      </timed>']; 
        fprintf(fid, '%s\n', lineStr);                       
    end
    lineStr = '    </transition>'; 
    fprintf(fid, '%s\n', lineStr);        
end