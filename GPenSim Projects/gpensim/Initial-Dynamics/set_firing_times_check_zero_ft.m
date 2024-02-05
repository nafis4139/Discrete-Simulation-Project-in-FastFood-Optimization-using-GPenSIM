function [] = set_firing_times_check_zero_ft(allOthers)
% function [] = set_firing_times_check_zero_ft(allOthers)
% check for any zero firing times AMONG non-zero firing times
% and warn if there are some firing times zero and others non-zero

global PN;
Ts = PN.No_of_transitions;
DUMMY_NaN = 100; % for replacing any NaN (stochastic time) '
sft = PN.Set_of_Firing_Times;

if allOthers,   % allothers are given (not zero)
    for i = 1:Ts,
        if eq(sft(i), 0),
            PN.Set_of_Firing_Times(i) = allOthers;
            PN.global_transitions(i).firing_time = allOthers;
        end;
    end;
    return
end;
    
% check for any zero firing times AMONG non-zero firing times
% and warn if there are some firing times zero and others non-zero
sft(isnan(sft)) = DUMMY_NaN; % just replace any NaN (stochastic time) with dummy value
any_NZ_ft = any(sft);   % any non-zero firing times
all_NZ_ft = all(sft);   % all firing times are non-zero?
only_some_NZ =  and(any_NZ_ft, not(all_NZ_ft)); % only some are non-zero firing times

if (only_some_NZ), 
    disp(' '); disp('Error:   Error:   Error:  ');
    disp('Some firing times are zero...');
    disp('simulations will be stuck with repeated firings'); 
    disp('of the zero time tansitions'); 
    disp(' '); 
    disp('Firing times of the transitions ');
    for i = 1:Ts,
        ft = PN.global_transitions(i).firing_time;
        if not(ischar(ft)), ft = num2str(ft); end;
        disp([PN.global_transitions(i).name, ': ', ft]);
    end;
    error('Some firing times are zero ....');
end;