function [] = prncontroller(Sys)
%        [] = prncontroller(Sys)
%  Print Controller Info

global PN
PN = Sys;
Ps = PN.No_of_places;
Cs = PN.No_of_control_places;
Ts = PN.No_of_transitions;
A = PN.incidence_matrix;

disp(' ');
disp('======= Controller Composition ======= ');

disp(' '); 
for i = 1:Cs
    pcx = Ps-Cs+i;
    place_name = pname(pcx);
    disp(['Control place: ', place_name]);
    % print the input arcs from the control places to transitions 
    ain = A(:, pcx);
    str = '    ';
    for j = 1: Ts,
        if ain(j),
            trans_name = tname(j);
            str = [str, '(', place_name, ' -> ', trans_name, ' : ',...
                int2str(ain(j)), ')   '];
        end;
    end;
    disp(str);
    
    % print the output arcs, from transitions to the control places
    aout = A(:, Ps+pcx:end);
    str = '    ';
    for j = 1: Ts,
        if aout(j),
            trans_name = tname(j);
            str = [str, '', trans_name, ' -> ', place_name, ' : ',...
                int2str(aout(j)), ')   '];
        end;
    end;
    disp(str);     
end;

% print initial markings (tokens) on the control places 
if any(PN.No_of_control_places), 
    disp(' '); disp('Initial markings on the Control places : '); 
    str = markings_string (PN.X, [Ps-Cs+1 Ps]); 
    if not(isempty(str)), disp(str); 
    else disp('(no tokens in control variables)'); 
    end;
end;
disp(' ');
