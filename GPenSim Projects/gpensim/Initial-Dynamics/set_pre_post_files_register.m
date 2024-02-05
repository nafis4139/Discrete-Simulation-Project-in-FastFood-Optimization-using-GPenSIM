function [] = set_pre_post_files_register()
%        [] = set_pre_post_files_register()
% Firstly, checks whether specific _PRE and _POST files are avialble 
% Secondly, checks whether COMMON_PRE and  COMMON_POST files
% the bits in PN structure are set accordingly
%   e.g.    PN.PRE_exist(5) = 1; % pre file exist for trans 5
%           PN.POST_exist(ti) = 1; % post file exist for trans 5
%

%  Reggie.Davidrajuh@uis.no (c) Version 6.0 (c) 10 july 2012  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global PN

Ts = PN.No_of_transitions;
Ms = PN.No_of_modules;

PRE_exist  = zeros(1, Ts);  
POST_exist = zeros(1, Ts);
MOD_PRE_exist = zeros(1, Ms);   
MOD_POST_exist = zeros(1, Ms);

%%%%%%%% 1:  Check for Individual _pre and _post files
for ti = 1:Ts,
    tname = PN.global_transitions(ti).name;
    file_pre  = [tname '_pre.m']; 
    file_post = [tname '_post.m'];
    if exist(file_pre, 'file'),  PRE_exist(ti)  = 1; end;
    if exist(file_post, 'file'), POST_exist(ti) = 1; end;    
end;
PN.PRE_exist = PRE_exist;
PN.POST_exist = POST_exist;


%%%%%%%% 2: Check for MOD_PRE and MOD_POST files
for mi = 1:Ms,
    mname = PN.module_names{mi};
    file_MOD_PRE  = ['MOD_', mname '_PRE.m'];
    file_MOD_POST = ['MOD_', mname '_POST.m'];
    if exist(file_MOD_PRE, 'file'),  MOD_PRE_exist(mi) = 1; end;
    if exist(file_MOD_POST, 'file'), MOD_POST_exist(mi) = 1; end;    
end;
PN.MOD_PRE_exist = MOD_PRE_exist;
PN.MOD_POST_exist = MOD_POST_exist;

%%%%%%%% 3:  Check for COMMON_PRE and COMMON_POST files
PN.COMMON_PRE = 0;  % initially
PN.COMMON_POST = 0;  % initially
if exist('COMMON_PRE', 'file'),  PN.COMMON_PRE = 1;  end;
if exist('COMMON_POST', 'file'), PN.COMMON_POST = 1; end;
