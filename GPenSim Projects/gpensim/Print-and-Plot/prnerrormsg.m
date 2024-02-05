function [] = prnerrormsg(msg_str) 
% function [] = prnerrormsg(msg_str) 

disp('Error: ');
disp('************************************************');
disp('*');
disp(['*      ', msg_str]);
disp('*');
disp('************************************************');
error(msg_str);
