function [] = dispMultipleCR(numberOfCR)
% function [] = dispMultipleCR(numberOfCR)
% This function prints a number of carriage returns (empty lines) on screen
%
% Input: numberOfCR - number of carriage returns wanted
%
%    Reggie.Davidrajuh@uis.no   (C) 26 October 2017

if ne(nargin, 1)
    disp('This function prints a number of "Carriage Returns" on screen');
    disp(' Please input the number of CR wanted');
    return
end

for i = 1:numberOfCR
    disp(' ');
end
    