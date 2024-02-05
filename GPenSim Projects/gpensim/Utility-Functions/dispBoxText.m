function [] = dispBoxText(textString, lengthFirst)
% function [] = dispBoxText(textString, lengthFirst)

lenTS = length(textString);
if eq(nargin,1)
    lengthFirst = lenTS + 40; 
    FirstString(1:lengthFirst) = '*'; 
else
    if gt(lengthFirst, lenTS+6)
        FirstString(1:lengthFirst) = '*'; 
    else
        lengthFirst = lenTS+6;
        FirstString(1:lengthFirst) = '*'; 
    end
end

startingPt = floor(lengthFirst/2 -  lenTS/2);
MiddleString = FirstString;
MiddleString(startingPt:startingPt+lenTS-1) =  textString;
MiddleString(startingPt-2:startingPt-1) =  ' ';
MiddleString(startingPt+lenTS:startingPt+lenTS+1) =  ' ';
SecondString = FirstString;
SecondString(startingPt-2:startingPt+lenTS+1) = ' ';  

disp(FirstString);
disp(SecondString);
disp(MiddleString);
disp(SecondString);
disp(FirstString);
