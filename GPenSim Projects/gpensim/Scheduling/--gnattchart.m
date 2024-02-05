function [] = gnattchart(PN, timeLimit)
% function [] = gnattchart(PN, timeLimit)
%   plot gnatt chart for the resource usage 
% This function plots the resource usage as a Gantt chart
%
% IMPORTANT !!!!!: In the Gantt chart, instances within a resource
%                  will not be differenciated. 

%  Reggie.Davidrajuh@uis.no (c) Version 10.0 (c) 28 June 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LOG = PN.Resource_usage_LOG;
if isempty(LOG), disp('No resources used ...' ); return; end;

% if time limit (second argument) is not given, then plot the whole series 
if lt(nargin, 2),
    timeLimit = inf;
end;

res = PN.system_resources;
Rs = PN.No_of_system_resources;
rows = size(LOG, 1); 

DELTA_TIME = 0.25;   % just to make a tiny gap between the reource usage

% PREPARE THE PLOT
plotColors = {'green','yellow','magenta','cyan','red','blue','black'};
maxPlotColors = length(plotColors); % number of plot colors
plotColors_index = 0;
figure; plot(0,0); hold all; plot(0.5, Rs+0.5); hold all; grid on; grid minor;

% Prepare the Y-label: e.g. "Resources:  1: X,   2: Y 
y_label = 'Resources:';  
for i = 1:Rs, % no_of_resources,
    y_label = [y_label, '    ', int2str(i), ': ', res(i).name, ','];
end;

% IMPORTANT: LOG file row
% [resource, transition, start_time, end_time, resource_instance]   
for current_res = 1:Rs, % no_of_resources,
    settimes = [];
    for i = 1:rows,
        if eq(LOG(i,1), current_res),
            start_time = LOG(i,3);  end_time   = LOG(i,4);
            settimes = [[settimes] [start_time + DELTA_TIME ; ...
                                    end_time - DELTA_TIME]];    
            if ge(end_time, timeLimit),
                break;   
            end;
        end; % if eq(LOG(i,1), current_res),
    end; % for i = 1:rows, 
    
    resource_index = ones(size(settimes)) * current_res; 
    plotColors_index = plotColors_index + 1;
    if gt(plotColors_index, maxPlotColors), plotColors_index = 1; end;  
    plot(settimes, resource_index, 'Color', plotColors{plotColors_index}, 'LineWidth', 22);
    hold all
end;
xlabel('Time'); ylabel(y_label(1:end-1), 'FontSize',12,'FontWeight','bold'); 
title('Gantt chart: Scheduling of resources'); 
hold off
