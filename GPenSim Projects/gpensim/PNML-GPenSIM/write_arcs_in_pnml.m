function [] = write_arcs_in_pnml(PNI, fid)
%  function [] = write_arcs_in_pnml(PNI, fid)
% Writes information about the arcs into pnml file %
%
% Used by: "gpensim2pnml"
%
%  Reggie.Davidrajuh@uis.no (c) September 2013 

A = PNI.incidence_matrix;
Ps = PNI.No_of_places; 
Ts = PNI.No_of_transitions;

for i = 1:Ts
    trans_name = PNI.global_transitions(i).name;
    
    % input connections of ti
    input_places = A(i, 1:Ps);
    for j = 1:Ps
        if input_places(j)
            place_name = PNI.global_places(j).name;
            arcID = [place_name, ' to ', trans_name];
            lineStr = ['    <arc id="', arcID, '" ', ...
                    'source="', place_name, '" ', ...
                    'target="', trans_name, '">']'; 
            fprintf(fid, '%s\n', lineStr);    
            lineStr = '      <inscription>';
            fprintf(fid, '%s\n', lineStr);                
            lineStr = ['        <text>', int2str(A(i,j)),'</text>'];
            fprintf(fid, '%s\n', lineStr);               
            lineStr = '      </inscription>';
            fprintf(fid, '%s\n', lineStr);
            lineStr = '    </arc>'; 
            fprintf(fid, '%s\n', lineStr);
        end % if input_places(j)
    end % j = 1:Ps
    
    % output connections of ti
    output_places = A(i, Ps+1:end);
    for j = 1:Ps
        if output_places(j)
            place_name = PNI.global_places(j).name;
            arcID = [trans_name, ' to ', place_name];
            lineStr = ['    <arc id="', arcID, '" ', ...
                    'target="', place_name, '" ', ...
                    'source="', trans_name, '">']; 
            fprintf(fid, '%s\n', lineStr);    
             lineStr = '      <inscription>';
            fprintf(fid, '%s\n', lineStr);                
            lineStr = ['        <text> ', int2str(A(i,Ps+j)),' </text>'];
            fprintf(fid, '%s\n', lineStr);               
            lineStr = '      </inscription>';
            fprintf(fid, '%s\n', lineStr);
            lineStr = '    </arc>'; 
            fprintf(fid, '%s\n', lineStr);            
        end % if output_places(j)
    end  % for j = 1:Ps
end % for i = 1:Ts
