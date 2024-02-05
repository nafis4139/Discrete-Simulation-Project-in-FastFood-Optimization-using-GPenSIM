function [] = dispSetOfPlaces(Name_of_set, Set_of_places)
% function [] = dispSetOfPlaces(Name_of_set, Set_of_places)

disp(' ');
disp(Name_of_set);
if isempty(Set_of_places)
    disp('   ---  none ---  ');
    return
end

for i = 1:numel(Set_of_places)
    disp(pname(Set_of_places(i)));
end
