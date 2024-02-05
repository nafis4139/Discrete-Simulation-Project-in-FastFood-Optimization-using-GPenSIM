function [] = dispSetOfTrans(Name_of_set, Set_of_trans)
% function [] = dispSetOfTrans(Name_of_set, Set_of_trans)

disp(' ');
disp(Name_of_set);
if isempty(Set_of_trans)
    disp('   ---  none ---  ');
    return
end

for i = 1:numel(Set_of_trans)
    disp(tname(Set_of_trans(i)));
end
