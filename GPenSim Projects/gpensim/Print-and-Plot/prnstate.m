function [] = prnstate(any_text_input)
% function [] = printstate(any_text_input)
%     Print Current State
%
% prints the current state (markings) with any preceding remarks.
%
% Usage:
%     prnstate('this is the final state:')
%       echos the following:
%     >> this is the final state: 5p1 + 7p2
%
% Uses markings_string 

%      Reggie.Davidrajuh@uis.no (c) August 2015

global PN

if not(nargin)  % no additonal text to display
    any_text_input = '';
end

markings = PN.X;
markings_str = markings_string (markings);
disp([any_text_input, ' ', markings_str]); 