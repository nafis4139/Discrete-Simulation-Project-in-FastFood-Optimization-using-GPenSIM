function [] = prnsys_connection
%        [] = prnsys_connection
%

global PN

Ps = PN.No_of_places;
Ts = PN.No_of_transitions;
A = PN.incidence_matrix;

if isfield(PN, 'No_of_control_places')
    Cs = PN.No_of_control_places;
else
    Cs = 0;
end

ProPs = Ps - Cs; % process places ONLY

for ti = 1:Ts % number of transitions
    tname = PN.global_transitions(ti).name;
    
    Input_places = A(ti, 1:ProPs);
    if not(any(Input_places))
        disp([tname, ' is a source transition, has NO input places ']);
    else
        str = [tname, ' : input places: ']; 
        for pi = 1: ProPs
            awt = A(ti, pi); % arc weight between pi -> ti
            if awt
                pname = PN.global_places(pi).name;
                str = [str, '(', pname,' -> ', tname, ...
                    ' : ', int2str(awt),')  '];
            end
        end % pi = 1: ProPs
        disp(str);
    end % not(any(Input_places))

    Output_places = A(ti, Ps+1:2*Ps-Cs);
    if not(any(Output_places))
        disp([tname, ' is a sink transition, has NO output places ']);
    else
        str = [tname, ' : output places: ']; 
        for pi = 1: ProPs
            awt = A(ti, Ps+pi); % arc weight between pi -> ti
            if awt
                pname = PN.global_places(pi).name;
                str = [str, '(', tname, ' -> ', pname,...
                    ' : ', int2str(awt),')  '];
            end
        end % pi = 1: ProPs
        disp(str);
    end % not(any(Output_places))    
end % for ti = 1:Ts

disp(' ');
% checking for orphan places
for pi = 1:Ps    
    pA = transpose(or(A(:,pi), A(:,pi+Ps)));
    if not(sum(pA))
        piname = PN.global_places(pi).name;
        disp([' !!: ', piname, ' is an orphan place!!']); 
    end
end


