function [] = plotGC(PN, Process_group, timePeriod, titleText)
% function[]= plotGC(PN, Process_group, timePeriod, titleText)
% This function plots the resource usage as a Gantt chart
%
% IMPORTANT !!!!!: In the Gantt chart, instances within a resource
%                  will not be differenciated. 
% Input parameters: 
%   1) PN: simulation results from the function gpensim
%   2) Process_group:  grouping transitions into a vect or process index
%       e.g. [1 1 2 2 2 3 3]   t1-t2 belongs to process-1, 
%                              t3-t5 belongs to process-2, and
%                              t6-t7 belongs to process-3 
%       Note: if Process_group is not given ot empty ([]), then 
%               
%   3) timePeriod: [lower_time_limit, upper_time_limit] 
%              If not given, whole results will be plotted.
%   4) titleText: text for the figure (Gnatt Chart) title
%              If not given, the default title will be used.

%  Reggie.Davidrajuh@uis.no (c) GPenSIM Version 10.0 (c) 28 June 2016
%  based on original contibution by Damian Krenczyk (damian.krenczyk@polsl.pl) 
%  in his file plotschedule.m  Version 1.0 (c) 19 May 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LOG = PN.Resource_usage_LOG;
if isempty(LOG), disp('No resources used ...' ); return, end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROCESS THE INPUT PARAMETERS
% INPUT PARAMETER-2: process group
% if process group (second argument) is not given, then use arbitary plotcolor 
if lt(nargin, 2)
    Process_group = 1:PN.No_of_transitions; 
elseif isempty(Process_group)
    Process_group = 1:PN.No_of_transitions; 
end

% INPUT PARAMETER-3: time duration for the plot
% if time period (third argument) is not given, then plot the whole series 
if lt(nargin, 3)
    lowerTimeLimit = 0; upperTimeLimit = inf; 
else
    lowerTimeLimit = timePeriod(1); upperTimeLimit = timePeriod(2); 
end

% INPUT PARAMETER-4: text for figure title
if lt(nargin, 4) % if title text is not given, show the deafult
    titleText = 'Gantt chart: Scheduling of resources';
end


res = PN.system_resources;
Rs = PN.No_of_system_resources;
rows = size(LOG, 1); 

DELTA_TIME = 0.1;   % just to make a tiny gap between the reource usage

% PREPARE THE PLOT
plotColors = {'red','blue','green','yellow','magenta','cyan','black'};
maxPlotColors = length(plotColors); % number of plot colors
figure; plot(lowerTimeLimit,0); hold all; plot(lowerTimeLimit+0.5, Rs+0.5); 
hold all; grid on; grid minor;

% Prepare the Y-label: e.g. "Resources:  1: X,   2: Y 
y_label = 'Resources:';  
for i = 1:Rs % no_of_resources,
    y_label = [y_label, '    ', int2str(i), ': ', res(i).name, ','];
end

% IMPORTANT: LOG file row
% [resource, transition, start_time, end_time, resource_instance]   
for current_res = 1:Rs % no_of_resources,
    resource_index = ones(2, 1) * current_res; 
    for i = 1:rows
        if eq(LOG(i,1), current_res)
            transition = LOG(i,2);  
            
            start_time = LOG(i,3);  end_time   = LOG(i,4);
            if lt(start_time, lowerTimeLimit)
                continue
            end
%             Transitions = [Transitions transition];
            time_frame = [start_time + DELTA_TIME ; end_time - DELTA_TIME];
            plotColors_index = Process_group(transition);
            if gt(plotColors_index, maxPlotColors)
                plotColors_index = mod(plotColors_index, maxPlotColors); 
            end
            if not(plotColors_index), plotColors_index = 1; end
            plot(time_frame, resource_index, 'Color',...
                    plotColors{plotColors_index}, 'LineWidth', 22);            
            hold all
                                
            if ge(end_time, upperTimeLimit)
                break
            end
        end % if eq(LOG(i,1), current_res),
    end % for i = 1:rows, 
end
xlabel('Time'); ylabel(y_label(1:end-1), 'FontSize',8,'FontWeight','bold'); 
title(titleText); 

hold off
