function [tokCreationTime] = get_tokCT (placeI, tokID)
% function [tokCreationTime] = get_tokCT (placeI, tokID)
%    get_token_creation_time
%
% Usage: to get the creation time of a token 
% Exanple: [tokCreationTime] = get_tokCT ('p1', 121);
%
% Uses: get_tokens(pi, tokID);
%
%    Reggie.Davidrajuh@uis.no (c) v10 (c) 18. Oct 2017

token_info = get_token(placeI, tokID);
tokCreationTime = token_info.creation_time;
