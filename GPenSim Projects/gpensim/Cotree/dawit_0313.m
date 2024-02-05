%----- In this section the required data will be stored in the "data" struct.-----%

information = cotree(pni, 1, 1); % "information" will store the output of cotree function. 
data = struct(); %Intiliazing the struct that will store the required data.

for i=1:length(information)
    
    % the "code paragraph" bellow was extracted from cotree.m and
    % print_cotree.m files. Reason for that is because the cotree function 
    % does not return all the information required such as state parents. 
    PN=pni;
    Ps = PN.No_of_places; 
    X0=pni.X;
    lil=build_cotree(X0);
    Current_row = lil(i,:);
    Parent_row = Current_row(:, Ps+2);
    X = Current_row(:, 1:Ps);
    markings_string(X)
    
    data(i).no = i; % storing the state number.
    data(i).type = char(information(i,pni.No_of_places+3));
    % Intiliazing the fields bellow to NaN, because some of the fields 
    % possibly wont have a value.
    data(i).time = NaN;
    data(i).cost = NaN;
    data(i).row = NaN;
    data(i).duplicate = NaN;
    
    if Parent_row>0 % If the state is located in the 0th row, then both the 
                %parent and tfired should be NaN otherwise store the values.
        data(i).parent = Parent_row;
        data(i).tfired = strcat('t',num2str(information(i,pni.No_of_places+1)));
    else
        data(i).parent = NaN;
        data(i).tfired = NaN;
    end
    
    if isnan(data(1).row) % Here the first data get to have row 1,and from 
                          % there every state gets +1 row from its parent. 
        data(1).row = 1;
    else
        data(i).row = data(Parent_row).row +1 ;
    end
    
 % The following section is where the markings get stored in the "info" field.
    C={}; % initiliazing a cell array to store the markings in.
    infotext = split(markings_string(X),[' ','+']);
    vari='';
    
    for w=1:length(infotext) %Here the "Inf" gets replaced with "w" .
        if contains(infotext(w),'Inf')
            infotext(w)=strrep(infotext(w),'Inf','w');
        end
        if w>1 % Adding the plus sign infront anything that isn't the first marking.
            infotext(w) = strcat('+',infotext(w));
        end
        
        vari = infotext(w);
        vari = strip(vari,' ');
        C{end+1} = char(vari);
    end
    C{end+1} = markings_string(X); % Adding the unmodified markings in to 
                                % the last place in the cell array, so that
                                % it can be used to detect duplicates
    data(i).info = C; % storing the cell array in the info field
    
end
%---------- Done storing the requiored data into the data struct ---------%

project_title = pni.name; % The title of the project.
startfrom = 1; % By default the first state is going to be state.no 1.

while startfrom > 0 % This while loop will keep going until the user type 
                       %in "0" when asked in the prompt.
    close all; clc; 
    axis([0 100 0 100])
    
    maxallowed=10; % maximum allowed states per figure.
    maxrows=5; % maximum allowed rows per figure.

    % Detecting and storing the duplicates into the "duplicate field" 
     for i = 1:length(data)
         for j = 1:length(data)
            if (strcmpi(data(i).info{end},data(j).info{end})) && (i<j) && isnan(data(i).duplicate)
                data(j).duplicate=data(i).no;
            end
         end
     end

%------- This section stores the nr. of states per rows-----------%    
% Stores the number of states per row, with limiting the rows to 5 per
% figure or 10 states per figure. Also store the relevant states that
% will be used
    
    rows=zeros(1,length(data)); % save the states distrubition per row here.
    
    current=0; % a variable to keep track of the number of states currntly.
    
    indexIncrease=0; % a variable to help increasing the index of the rows  
            % incase one row has been separated in 2 different figures

    usedata = zeros(1,length(data)); %Store the data that will be used here
    
    ind=1; % a variable to be used as "usedata" index, that will be 
            %increamented each loop
    
    rowschecker = 0; %a variable that is used to check if the rows reached
                    % the limited number of rows per figure "maxrows"
    
    for i = startfrom:length(data)
        
        % enter this section only if this is the first state chosen or
   % or the parent of the current state is already stored in the "usedata"
        if ismember(data(i).parent,usedata) || i == startfrom 
            
            if (current == maxallowed || rowschecker >= maxrows) && rows(data(i).row) == 0
                current = 0;
                rowschecker=0;    
            end

            if current == maxallowed && rows(data(i).row) ~= 0
                indexIncrease = indexIncrease + 1;
                current = 0;
                rowschecker=0;
            end
            
            if rows(data(i).row) == 0
                rowschecker = rowschecker+1;
            end
            
            rows(data(i).row+indexIncrease) = rows(data(i).row+indexIncrease) + 1;
            current = current+1;
            
            usedata(ind) = data(i).no;
            ind = ind + 1;
        end
    end
    % sort the rows to get the largest row on the first index
    largestrow=sort(rows,'descend');
    
    %--------the section ends here by returnining the relevant state.no in
    % "usedata", the number of states on each row (with respect to the
    % number of allowed rows and states per figure) in "rows" and finally
    % the largestrow in "rows", so that it can be used to decide the sizes
    % of the boxes.------------%
    

    % size of the x-axis depends on the number of states in the largest row.
    % limit the refernce size to be maximum 30.
    xsize = (100/largestrow(1))-1;
    if xsize > 30
        xsize = 30;
    end
    StateNoSize = xsize/7;
    StateInfoSize = xsize-StateNoSize;
    StateDuplicateSize = xsize/7;
    SmallBoxesSize = xsize/3;

    %the vertical size of the boxes is always
    BigYsize = 10;
    SmallYsize = 4;
    %initial start value for y-axis
    StartPtY = 87;
    StartPtYinitial=StartPtY;

    sizehelper=1;
    datanumber=startfrom;
    counter=0;

    tfirepositions = zeros(length(data),2); % 2 dimentional array to store 
    %the x and y axis of the states boxes to be used for connecting the 
    %boxes as well as printing the tfired names and child nodes.
    
    checker = zeros(length(data),1); % stores the states present in the 
    %current figure, so that later we can check whether we can connect the
    %parent and child nodes or not.
    
    useind=1; % index for the usedata (starts at 1 but will be incremented 
    %before first use, reason for that is that we don't need the first 
    %value of the usedata since we getting it directly from the startfrom
    %variable).
    
    maxrowscounter = 0; % variable to keep track on the number of rows in
    % the figure.
    
    
    for i=1:length(rows) % this loop goes through the indexes of row and 
                            % gets the number of states in that row.
        
        numberoftherow = rows(i); % assigning the number of states in that row.
        done=0; % a variable that helps checking if the current row is done.
        
        if numberoftherow ~=0
            maxrowscounter = maxrowscounter + 1;
            
            %title('TITLE HERE!')
            title(project_title)
            
            % "pinr" used to save state.no for each row,if it is the last
            %  one in the figure, then use it to assign child nodes.
            pinr = zeros(1,numberoftherow);
            
            for x=1:rows(i)

                %space between the states depending on how many states are there
                %in that row
                SumOfSpace = 100-(xsize*numberoftherow);

                %dived spaces equally into number of states +1
                OneSpace = SumOfSpace/(numberoftherow+1);

                if sizehelper==1
                    %then only have onespace befor the state
                    xstart = OneSpace;
                else 
                    %otherwise space times how many states we have + the size of the
                    %states we have excluding the curent one.
                    xstart = (OneSpace*sizehelper)+(xsize*(sizehelper-1));
                end

                % x position
                tfirepositions(datanumber,1) = xstart+SmallBoxesSize+2;

                % y position
                tfirepositions(datanumber,2) = StartPtY-4;
                checker(datanumber,1) = datanumber;
                
                %  assigning the colors
                if data(datanumber).type == 'T'
                    cola = [0.8500, 0.3250, 0.0980];
                    tryi = 'w';
                else
                    cola = 'none';
                    tryi = 'k';
                end
                
                % plotting the state.no box
                rectangle('Position',[xstart StartPtY StateNoSize BigYsize], 'FaceColor',cola)    
                text(xstart+0.3,StartPtY+8,...
                num2str(data(datanumber).no),...
                    'color',tryi);
               
               % If this is a duplicate state then adjust the boxes sizes 
               % for the markings box. And plot both. 
               if ~isnan(data(datanumber).duplicate)
                    rectangle('Position',[xstart+StateNoSize+StateInfoSize-StateDuplicateSize StartPtY StateDuplicateSize BigYsize], 'FaceColor','y')
                    text(xstart+StateNoSize+StateInfoSize-StateDuplicateSize+0.3,StartPtY+8,...
                        'D');
                    text(xstart+StateNoSize+StateInfoSize-StateDuplicateSize+0.3,StartPtY+2,...
                    num2str(data(datanumber).duplicate));

                    rectangle('Position',[xstart+StateNoSize StartPtY StateInfoSize-StateDuplicateSize BigYsize])
%                     text(xstart+StateNoSize+0.5,StartPtY+6,...
%                     data(datanumber).info);
                    str = data(datanumber).info(1,1:length(data(datanumber).info)-1);
                    text(xstart+StateNoSize+11,StartPtY+5,...
                        str,...
                        'HorizontalAlignment','center',...
                        'FontSize',9,...
                        'Margin',1);
               else
                
                % plot the markings box here if this state is not a duplicate.  
                rectangle('Position',[xstart+StateNoSize StartPtY StateInfoSize BigYsize])
%                 text(xstart+StateNoSize+0.5,StartPtY+6,...
%                    data(datanumber).info);%,...
                    str = data(datanumber).info(1,1:length(data(datanumber).info)-1);
                    text(xstart+StateNoSize+13,StartPtY+5,...
                        str,...
                        'HorizontalAlignment','center',...
                        'FontSize',9,...
                        'Margin',1);
               end
                % plot the time box here.
                rectangle('Position',[xstart StartPtY-4 SmallBoxesSize SmallYsize])
                text(xstart+0.3,StartPtY-2,...
                   num2str(data(datanumber).time));
               
                % plot the cost box here.
                rectangle('Position',[xstart+SmallBoxesSize StartPtY-4 SmallBoxesSize SmallYsize])
                text(xstart+SmallBoxesSize+0.3,StartPtY-2,...
                   num2str(data(datanumber).cost));
                
                % plot the parent box here.
                rectangle('Position',[xstart+SmallBoxesSize*2 StartPtY-4 SmallBoxesSize SmallYsize])
                text(xstart+SmallBoxesSize*2+0.3,StartPtY-2,...
                   num2str(data(datanumber).parent));
                
               % connecting the states, as long as their parents are in the
               % figure.
               if ~isnan(data(datanumber).parent) %check if it has parent
                   % connect with parent.
                    if ismember(data(datanumber).parent,checker) %check if it is in the figure
                        hold on;
                        plot([tfirepositions(data(datanumber).parent,1) tfirepositions(data(datanumber).no,1)], [tfirepositions(data(datanumber).parent,2) (tfirepositions(data(datanumber).no,2))+(BigYsize+SmallYsize)],'r')
                    end

                    % plotting the tfired names above the boxes.
                    xt = tfirepositions(data(datanumber).no,1);
                    yt = (tfirepositions(data(datanumber).no,2))+(BigYsize+SmallYsize);
                    str = data(datanumber).tfired;

                    text(xt-3,yt+2,str,'Color', 'm')    
               end

                sizehelper=sizehelper+1;
                counter = counter + 1;
                
                if x == numberoftherow
                    done = 1;
                end
                
                %---------LAST ROW WITH CHILDNOTES ------%
                pinr(x) = datanumber;
                % If this is the last allowed row and its done, or max 
                %allowed states in a figure is reached then plot the 
                %children of the states that didn't show.
                
                if counter == maxallowed || (maxrowscounter == maxrows && done==1)
                    cnr = datanumber; %cnr to be used in checking if the
                                    % states in pinr has child nodes or not.
                    
                    for z=1:(length(data)-datanumber)
                        cnr = datanumber + z;
                        
                        %if it has children then plot their state.no
                        %underneath.
                        if ismember(data(cnr).parent,pinr)    
                            txti = num2str(cnr);
                            hold on;
                            text(tfirepositions(data(cnr).parent,1)-10+z*4,tfirepositions(data(datanumber).no,2)-2,txti,'BackgroundColor',[0, 0.5, 0],'Color', 'w','EdgeColor','none','Margin',1)
                        end
                    end
               %---- the section is done after plotting the child node ---%
               
      %----- this section is to reinitiliaze the variables that needs to be
               % needs to be reset, after the current figure is plotted.---%
               
                    counter = 0;
                    StartPtY=StartPtYinitial+20.5;
                    checker=zeros(length(data),1);
                    sizehelper = 1;
                    maxrowscounter=0;
                    done = 0;
                    
                    if datanumber < length(data) %start a new figure if there is more data
                        figure;
                        axis([0 100 0 100])
                    end
                end
                
                useind=useind+1;
                if useind <= length(data) % if the is more data then get the next state.no 
                    datanumber=usedata(useind);
                end
            end
            StartPtY=StartPtY-20;
            sizehelper=1;
        end
    end
    maxrowscounter=0;
    answer = inputdlg('Which State do you want to start from? Exit using the cancel button or enter the number "0"','First State', [1 50]);     
    startfrom = str2num(answer{1});
end