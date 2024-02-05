function [delta_M0, delta_FT] = mincyctime_propose(max_index,TokenSum, TotalTD, expected_FR)
% function [delta_M0, delt_FT] = mincyctime_propose(max_index,TokenSum, TotalTD, expected_FR)

if not(expected_FR) % not given 
    rates_of_circuits =  TokenSum./TotalTD;
    rates_of_circuits = sort(rates_of_circuits);
    expected_FR = rates_of_circuits(2);
end

% expected_FR, max_value, max_index,sumM0, sumFT
sumFT = TotalTD(max_index); % sum of firing times in the crtical circuit
sumM0 = TokenSum(max_index); % sum of tokens in the crtical circuit

delta_M0 = ceil((sumFT * expected_FR) - sumM0);
delta_FT = sumFT - (sumM0/expected_FR);
disp(' ');
disp(['*** We can increase the current flow rate to ', ...
      num2str(expected_FR), ' tokens/TU, by improving the critical circuit alone ...']);
disp(['    In the circuit-', int2str(max_index), ' either: ']);
disp(['    1. increase the sum of tokens by ', int2str(delta_M0), ' tokens, or, ']);
disp(['    2. decrease the total delay (firing times) by ', num2str(delta_FT),' TU.']);
disp(' ');
