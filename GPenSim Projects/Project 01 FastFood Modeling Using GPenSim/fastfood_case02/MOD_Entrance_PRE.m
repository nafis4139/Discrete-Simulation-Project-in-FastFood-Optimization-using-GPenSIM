function [fire, transition] = MOD_Entrance_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In Entrance PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));
CurrentTime = current_time();
disp(transition.name)

if strcmp(transition.name, 'tEntEnter')
    if ge(CurrentTime, global_info.ClosingTime)
        fire = 0;
    else
        fire= 1;
    end
end