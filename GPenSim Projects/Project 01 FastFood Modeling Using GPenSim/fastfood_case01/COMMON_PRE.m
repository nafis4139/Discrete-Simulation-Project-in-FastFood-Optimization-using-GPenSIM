function [fire, transition] = COMMON_PRE (transition)
global global_info
global PN
fire = 1;
%disp(transition.name);
disp(['In Common PRE enabled trans is: ', transition.name]);
disp(markings_string(PN.X));

CurrentTime = current_time();

if strcmp(transition.name, 'tIMCExit') 
    if ge(CurrentTime, global_info.ClosingTime) %Transition will not fire if Current Time passes Closing Time
        fire = 1;
    else
        probabilityVariable = randi([1,global_info.ExitProbability]); %Probability of Exiting FastFood Restaurant from IMC
        if probabilityVariable == 1
            fire = 1;
        else
            fire = 0;
        end
    end

elseif strcmp(transition.name, 'tCEnter')   %Probability of Entering Counter Module
    if ge(CurrentTime, global_info.ClosingTime)
        fire = 0;
    else
        probabilityVariable = randi([1,global_info.CounterEnterProbability]); 
        if probabilityVariable == 1
            fire = 1;
        else
            fire = 0;
        end
    end

elseif strcmp(transition.name, 'tTabEnter')   %Probability of Entering Table Module
    if ge(CurrentTime, global_info.ClosingTime)
        fire = 0;
    else
        probabilityVariable = randi([1,global_info.TableEnterProbability]); 
        if probabilityVariable == 1
            fire = 1;
        else
            fire = 0;
        end
    end
    
elseif strcmp(transition.name, 'tTEnter')   %Probability of Entering Toilet Module
    if ge(CurrentTime, global_info.ClosingTime)
        fire = 0;
    else
        probabilityVariable = randi([1,global_info.ToiletEnterProbability]); 
        if probabilityVariable == 1
            fire = 1;
        else
            fire = 0;
        end
    end

elseif strcmp(transition.name, 'tKZEnter')   %Probability of Entering KidsZone Module
    if ge(CurrentTime, global_info.ClosingTime)
        fire = 0;
    else
        probabilityVariable = randi([1,global_info.KidsZoneEnterProbability]); 
        if probabilityVariable == 1
            fire = 1;
        else
            fire = 0;
        end
    end

elseif strcmp(transition.name, 'tCDEnter')   %Probability of Entering ChargingDock Module
    if ge(CurrentTime, global_info.ClosingTime)
        fire = 0;
    else
        probabilityVariable = randi([1,global_info.ChargDockEnterProbability]); 
        if probabilityVariable == 1
            fire = 1;
        else
            fire = 0;
        end
    end

end
