function [] = print_colormap_for_place(PN, pindex)
% [] = print_colormap_for_place(PN, place_index)
%
%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 14 June 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' '); disp(['Color Map for place: ', pname(pindex)]);

% extract color_map for given place
% disp(['extract color_map for given place....']);
color_map = PN.color_map;
new_CM = [];
for i = 1:length(color_map)
    cm = color_map(i);
    if isequal(pindex, color_map(i).place)
        new_CM = [new_CM cm];
    end
end
if isempty(new_CM), disp('(no colors)'); return, end

disp('% print the extracted color_map');
% print the extracted color_map
for i = 1:length(new_CM)
     if not(isnan(new_CM(i).time))
        colors = new_CM(i).color;
        n1Colors = size(colors, 1); % print all N colors of this colorset
        n2Colors = size(colors, 2); % print all N colors of this colorset
        nColors = max(n1Colors, n2Colors);
        colorset = ' '; 
        for k = 1:nColors
            colorset = [colorset, ' "', colors{k}, '" ']; 
        end
        disp_str = ['Time: ',num2str(new_CM(i).time), '     Colors: ',...
            colorset];
        disp(disp_str);
     end
end
