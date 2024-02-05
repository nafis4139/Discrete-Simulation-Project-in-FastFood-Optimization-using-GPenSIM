function [] = prnVirtualState(any_text_input)
% function [] = prnVirtualState(any_text_input)
%    Print Virtual State
% prints the current virtual tokens (markings) with any preceding remarks.
%
% Usage:
%     prnVirtualState('We have the following virtual tokens: ')
%       echos the following:
%     >> We have the following virtual tokens: p11 + p21
%
% Uses markings_string 

%      Reggie.Davidrajuh@uis.no (c) August 2015

global PN

if not(nargin),  % no additonal text to display
    any_text_input = '';
end;

markings = PN.VX;
markings_str = markings_string (markings);
disp([any_text_input, ' ', markings_str]); 