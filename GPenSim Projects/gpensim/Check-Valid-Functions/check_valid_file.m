function [] = check_valid_file(filename)
%        [] = check_valid_file(filename)

if ~exist(filename, 'file'),  % wrong definition file
    prnerrormsg (['File "', filename '" does not exist !']);
end;