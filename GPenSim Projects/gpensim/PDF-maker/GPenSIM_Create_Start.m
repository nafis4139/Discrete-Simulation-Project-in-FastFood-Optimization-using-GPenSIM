function varargout = GPenSIM_Create_Start(varargin)
%GPenSIM_Create_Start M-file for GPenSIM_Create_Start.fig
%      GPenSIM_Create_Start, by itself, creates a new GPenSIM_Create_Start or raises the existing
%      singleton*.
%
%      H = GPenSIM_Create_Start returns the handle to a new GPenSIM_Create_Start or the handle to
%      the existing singleton*.
%
%      GPenSIM_Create_Start('Property','Value',...) creates a new gpensim_create_start using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GPenSIM_Create_Start_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GPenSIM_Create_Start('CALLBACK') and GPenSIM_Create_Start('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GPenSIM_Create_Start.M with the given input
%      arguments.
% Last Modified by GUIDE v2.5 23-Apr-2014 12:28:13
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GPenSIM_Create_Start_OpeningFcn, ...
                   'gui_OutputFcn',  @GPenSIM_Create_Start_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT,it will create a mess

% --- Executes just before GPenSIM_Create_Start is made visible.
function GPenSIM_Create_Start_OpeningFcn(hObject, eventdata, handles, varargin)
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% varargin   command line arguments to GPenSIM_Create_Start 
% Choose default command line output for GPenSIM_Create_Start

global Place_hold;
handles.output = hObject;
handles.Place_hold=Place_hold;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GPenSIM_Create_Start wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GPenSIM_Create_Start_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args;
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data
% Get default command line output from handles structure
% Global variables take the data variables through out the system
global Place_hold;
handles.pushbutton12=Place_hold;
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
pop_place = getCurrentPopupString(handles.popupmenu1); % no of places
set(handles.edit4,'String',pop_place);
%sprintf('You have choosen %s places',pop_place);
disp('The number of places is: ');
disp(pop_place);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)

pop_trans = getCurrentPopupString(handles.popupmenu2); % no of places
%sprintf('You have choosen %s places',pop_place);
set(handles.edit5,'String',pop_trans);
disp('The number of trans is: ');
disp(pop_trans);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, ~, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
clc;
global temp1;
global temp2;
global temp3
global temp4;
temp1 = get(handles.edit1,'String');% name of the module
temp2 = get(handles.edit2,'String');%name of the petrinet definition file
temp3 = getCurrentPopupString(handles.popupmenu1); % no of places
temp4 = getCurrentPopupString(handles.popupmenu2);% no of transitions
[cdata] = imread('image.jpg'); 
if str2double(temp3)<=0 && str2double(temp4)<=0 && isempty(temp2),
    msgbox('Please fill the above fields!', 'Warning!','warn');return;
end
set(handles.uitable1,'enable','on');
set(handles.uitable3,'enable','on');
if ~isempty(temp1),
    msgbox('Info Saved.. Start writing places and trans name...', 'info!','custom',cdata);
end

% --- Executes on button press in pushbutton2.
function str = getCurrentPopupString(hh)
%# getCurrentPopupString returns the currently selected string in the popupmenu with handle hh
%# could test input here

if ~ishandle(hh) || strcmp(get(hh,'Type'),'popupmenu')
error('getCurrentPopupString needs a handle to a popupmenu as input')
end

%# get the string - do it the readable way
list = get(hh,'String');
val = get(hh,'Value');
if iscell(list)
   str = list{val};
else
   str = list(val,:);
end

function pushbutton2_Callback(hObject, eventdata, handles)

% setCurrentPopupString(handles.popupmenu1,'0'); % no of places

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)

pop_IS = getCurrentPopupString(handles.popupmenu3); % no of places
%sprintf('You have choosen %s places',pop_place);
set(handles.edit6,'String',pop_IS);
disp('The number of Inhibitor arcs is: ');
disp(pop_IS);

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in connect output
function pushbutton5_Callback(hObject, eventdata, handles)
% a function to create output arc
global outArcStore;
global OutWeig;
%global flag_btn;
getlst1=get(handles.listbox4,'String');
getlst2=get(handles.listbox5,'String');

if ~isempty(getlst1)&& ~isempty(getlst2),
    
    set(handles.pushbutton6,'Enable','on'); % for save output arcs.. we should enable and click it
    OutWeig=getCurrentPopupString(handles.popupmenu6);
    selected1 = get(handles.listbox4,'String');
    selected11=transpose(selected1);
    index1=get(handles.listbox4,'Value');
    selected2 = get(handles.listbox5,'String');
    index2=get(handles.listbox5,'Value');
    selected22=transpose(selected2);
    
    outputpl=selected11{index1};
    outputtr=selected22{index2};
    disp('selected place is');
    disp(outputpl)
    disp('-------------')
    disp('selected trans is');
    disp(outputtr)
    outArc=['''',outputpl,'''',',','''',outputtr,'''',',',OutWeig,','];
    disp(outArc);
    outArcStore=[outArcStore,outArc];
    disp(outArcStore)
else
    msgbox('There is no place or transition. Please fill the above table', 'Error','error');return; 
end

% --- Executes on button press in ok button for connect output module.
function pushbutton6_Callback(hObject, eventdata, handles)
global flag3;
select1 = get(handles.listbox4,'String');

if(~isempty(select1))

[cdata] = imread('image.jpg'); 
msgbox('Output arc is formed continue to module creation...','Success','custom',cdata);
flag3=1;
else
msgbox('No Out put arc is formed try to create if there is Ps and Ts','Error','error');
end

% --- Executes on button press in connect input placeto transition.
function pushbutton3_Callback(hObject, eventdata, handles)
global InputWeig;
global inArcStore;
global semafor1;
global flag2;
try
if(~strcmp(semafor1,' '))
    InputWeig=getCurrentPopupString(handles.popupmenu7);
    select1 = get(handles.listbox2,'String');
    select11=transpose(select1);
    ind_1=get(handles.listbox2,'Value');
    select2 = get(handles.listbox3,'String');
    ind_2=get(handles.listbox3,'Value');
    select22=transpose(select2);
    inputpl=select11{ind_1};
    inputtr=select22{ind_2};
    disp('selected place is');
    disp(inputpl)
    disp('-------------')
    disp('selected trans is');
    disp(inputtr)
    inArc=['''',inputpl,'''',',','''',inputtr,'''',',',InputWeig,','];
    
    inArcStore=[inArcStore,inArc];
    disp(inArcStore)
    flag2=1;
else
    disp('clear fleids first')
    flag2=0;
end
catch err
   msgbox('There is no place or transition. Please fill the above table', 'Error','error');return; 
  
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

global inArcStore;
global flag_btn;% flag to pass massage to the next buttons to be active
global flag2;
if flag2==1,
flag_btn=1;
  if ~isempty(inArcStore),
    [cdata] = imread('image.jpg');
    h = msgbox('input arc is formed continue to output...','Success','custom',cdata);
  end
else
    msgbox('Please Create one or more Input Arcs first','Message','warn');
end



% --- Executes on key press with focus on popupmenu1 and none of its controls.
function popupmenu1_KeyPressFcn(hObject, eventdata, handles)
% --- Executes on button press in Create module
%this module,pushbutton7_Callback, is the heart of the system 
function pushbutton7_Callback(hObject, eventdata, handles)
global myglobalvar;
global myglobalvar2;
global inArcStore;
global outArcStore;
global file_Name;
global iSStore; % stores the inhibitors temporarly 
global semafore1; %To copy the places in a clipboard
global semafore2; % To copy the transitions into a clipboard
global semafore3; % To copy the arcs into a clipboard
global Place_hold; % To export places for further project % Optional
    
    temp1 = get(handles.edit1,'String');% name of the module
    temp2 = get(handles.edit2,'String');%name of the petrinet definition file
    t4=get(handles.edit3,'String');
    str0=['%',t4,';'];
    str1=['function[png] = ',temp2,'_def()'];
    str2=['%',temp1];
    str3='png.PN_name=';
    str4=[str3,'''',temp1,''''];%pn name
    str5='png.set_of_Ps ={';
    a=transpose(myglobalvar);
    disp('----------------set_of_places-----------------');
    disp(a);
    
    stra=[];
    try
        stra=cellfun(@num2str,a,'UniformOutput',0);
        Place_hold=stra;
        tempstr=[];
        for i=1:length(stra)
            tempstr=[tempstr,',','''',stra{i},''''];
        end
        tempstr(1)=[];
        str55=strcat(str5,tempstr);
    catch err
         msgbox('No place Saved, please create and save places and create arc', 'Empty place','error');return;
    end
    disp('----------------set_of_Transitions-----------------');
    str6='png.set_of_Ts ={';
    b=transpose(myglobalvar2);% to make it horizontal cell array of transitions.
    try
        strb=cellfun(@num2str,b,'UniformOutput',0);
        tempstr2=[];
        for i=1:length(strb)
            tempstr2=[tempstr2,',','''',strb{i},''''];
        end
        tempstr2(1)=[];
        str65=strcat(str6,tempstr2);
    catch err
        msgbox('No Transition saved, please save transitions and creat arc', 'Empty Transition','error');
        return;
    end
    disp(b);
    disp('-------------------set_of_As-----------------------')
    str7='png.set_of_As ={';
    disp(inArcStore)
    str77=[str7,inArcStore];
    % cst=textwrap(str77,50);
    % strcat({char(39)}, cstr, {[char(39), ', ...']});
    % disp(cst)
    str78=outArcStore;
    %str78(len2)=[];
    if(~isempty(outArcStore)),
        str78(end)=[];
    else
        disp('No output arc');
    end
    
    disp('-------------------------Set_of_Is------------------------')
    disp(iSStore);
    semafore1=inArcStore;
    semafore2=outArcStore;
    semafore3=iSStore;
    str8='png.set_of_Is ={';
    str88=[str8,iSStore];
    len3=length(str88);
    str88(len3)=[];
    str88=[str88,'};'];
    FN=[temp2,'_def','.m'];
    fName=FN;%['Result_files\',FN];%pdf file name FN=[temps,'.m'];
    file_Name=[temp2,'_def'];
    fid=fopen(fName,'w');
    if fid ~= -1
        fprintf(fid,'%s\r\n',str0);    %# Print the string
        fprintf(fid,'%s\r\n\n',str1);    %# Print the string
        fprintf(fid,'%s\r\n',str2);
        fprintf(fid,'%s;\r\n\n',str4);
        fprintf(fid,'%s};\r\n',str55);
        fprintf(fid,'%s};\r\n',str65);
        fprintf(fid,'%s...\n',str77);
        fprintf(fid,'                %s};\r\n',str78);
        if(~isempty(iSStore))
            fprintf(fid,'%s\r\n\n',str88);
        else
            disp('no Inhibitor arc');
        end
        fclose(fid);                         %# Close the file
    end
    dlmwrite(fName,'','-append',...  %# Print the matrix
        'delimiter','\t',...
        'newline','pc');
    %%%We need to copy the icon info icon using the followin command
    %          copyfile(fullfile(matlabroot,...
    %          'help','image.png'));
    
    [cdata] = imread('image.jpg');
    msgbox('Model successfully created!','Success','custom',cdata);
    % Place_hold = get(hObject,'String');
    % set(hObject,'UserData',Place_hold);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% A program to create a new module
close(GPenSIM_Create_Start)% close if any opened figure.
try
    %run(GPenSIM_Create_Start.m);
    eval(GPenSIM_Create_Start);
catch err
    disp(err)
end

 clear all;clc; % clear the mess
% --- Executes on button press in connect inhibitor arcs.
function pushbutton10_Callback(hObject, eventdata, handles)
global InputWeig;
global iSStore;
InputWeig=getCurrentPopupString(handles.popupmenu7); 
selected1 = get(handles.listbox2,'String');
selected11=transpose(selected1);
index1=get(handles.listbox2,'Value');
selected2 = get(handles.listbox3,'String');
index2=get(handles.listbox3,'Value');
selected22=transpose(selected2);

inputpl=selected11{index1};
inputtr=selected22{index2};
disp('selected place is');
disp(inputpl)
disp('-------------')
disp('selected trans is');
disp(inputtr)
inArc=['''',inputpl,'''',',','''',inputtr,'''',',',InputWeig,','];
iSStore=[iSStore,inArc];

disp(iSStore)
% --- Executes on button press in Start MSF.
function pushbutton12_Callback(hObject, eventdata, handles)
GPenSIM_msf_Create;
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
handles=waitbar(progress,'please wait...');
waitbar(eventdata,handles);
steps=1000;
hwb=waitbar(0, 'Calculating ...', 'Name', 'Time marching');
for step=1:steps
    %computations take place here
    waitbar(step/steps,hwb);
end
close(h);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
GPenSIM_Modul_delet;

% --- Executes on button press in "import button" from the main function
% modules 
function pushbutton14_Callback(hObject, eventdata, handles)
global im_place;%import places
global im_trans;%import trans
global im_arcs;%import arcs
try
    %[filename,pathname] = uigetfile('Result_files\*_def.m','Select a PDF file');
    [filename,pathname] = uigetfile('*_def.m','Select a PDF file');
    file=[pathname,filename];
    copyfile(file,'temp_val.m','f')
    % open('temp_val.m');
    a=eval('temp_val');
    im_place=a.set_of_Ps;
    im_trans=a.set_of_Ts;
    im_arcs=a.set_of_As;
    
    fileprt=filename;
    le=length(fileprt);
    fileprt(le)=[];
    for i=1:5
        fileprt(le-i)=[];
    end
    
    im_name=a.PN_name;
    set(handles.edit1,'String',im_name);
    set(handles.edit2,'String',fileprt);
    %%%%
    fid = fopen('temp_val.m');
    tline = fgetl(fid);
    fclose(fid);
    set(handles.edit3,'String',tline);
    set(handles.listbox2,'String',im_place);
    set(handles.listbox5,'String',im_place);
    set(handles.listbox3,'String',im_trans);
    set(handles.listbox4,'String',im_trans);
    leng1=length(im_place);
    leng2=length(im_trans);
    % leng3=length(im_is);
    
    set(handles.edit4,'String',leng1)
    set(handles.popupmenu1,'Value',leng1+1)
    set(handles.popupmenu2,'Value',leng2+1)
    set(handles.edit5,'String',leng2)
    % Put into the table data
    set(handles.uitable1,'Data','');
    Data=get(handles.uitable1,'Data');
    List=get(handles.listbox2,'string');
    D2 = Data;%(:,1);
    S = strtrim(D2);
    C=cellstr(S);
    ktemp=C(~cellfun(@isempty, C));
    disp(ktemp)
    Data2=[ktemp;List];
   
    set(handles.uitable1,'Data',Data2);
    %%%%%%similarly for listbox2
    set(handles.uitable3,'Data','');
    Data4=get(handles.uitable3,'Data');
    List2=get(handles.listbox3,'string');
    D3 = Data4;%(:,1);
    S2 = strtrim(D3);
    C2=cellstr(S2);
    ktemp2=C2(~cellfun(@isempty, C2));
    Data2=[ktemp2;List2];
    set(handles.uitable3,'Data',Data2);
catch err
    disp(err)
end
clear all;

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
global myglobalvar;
msg=get(handles.uitable1,'Data');
D2 = msg(:,1);
S = strtrim(D2);
% disp(S);
C=cellstr(S);
ktemp=C(~cellfun(@isempty, C));
myglobalvar=ktemp;
if isempty(myglobalvar),
    h=msgbox('No place has been entered','Erro','error');
else
set(handles.listbox2,'String',ktemp);
set(handles.listbox5,'String',ktemp);
end
function pushbutton17_Callback(hObject, eventdata, handles)
% This function is clear table fields, Clear table
global temp3;
global temp4;
set(handles.uitable1,'enable','on');
set(handles.uitable3,'enable','on');
set(handles.listbox2,'String','');
set(handles.listbox3,'String','');
set(handles.listbox4,'String','');
set(handles.listbox5,'String','');
% % Get entire existing table.
try
%     set(handles.uitable1,'CellSelectionCallBack',@(h,e) set(h,'UserData',e))
    D=get(handles.uitable1,'Data');
%   Index=get(handles.uitable1,'UserData');
    %disp(Index)
    % row selection
    D(:,1) = [];
    set(handles.uitable1,'Data',D);
    set(hObject, 'Enable', 'On');
catch err
    disp(err);
end
pushbutton21_Callback(hObject, eventdata, handles);% for transtion table clear data


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all;clc;
disp('-------------------------§§--------------------------')
disp('           Thank you for using the software')
disp('-------------------------§§--------------------------')
close(GPenSIM_Create_Start)

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','Write Module Comment here');
%
%set(handles.popupmenu1,'String','');
set(handles.listbox2,'String','');
set(handles.listbox3,'String','');
set(handles.listbox4,'String','');
set(handles.listbox5,'String','');
try
set(handles.uitable1,'CellSelectionCallBack',@(h,e) set(h,'UserData',e))
D1=get(handles.uitable1,'Data');
Index=get(handles.uitable1,'UserData');
% D(Index.Indices(:,1), :) = [];
D1(:,Index.Indices(:,1)) = [];
set(handles.uitable1,'Data',D1);
set(hObject, 'Enable', 'On');
%-----------------------------------------------------------------------
set(handles.uitable3,'CellSelectionCallBack',@(h,e) set(h,'UserData',e))

D2=get(handles.uitable3,'Data');

Index2=get(handles.uitable3,'UserData');
D2(:,Index2.Indices(:,1)) = [];
set(handles.uitable3,'Data',D2);
set(hObject, 'Enable', 'On');
catch err
    disp(err);
end
pushbutton8_Callback(hObject, eventdata, handles);

function uitable1_CellSelectionCallback(hObject, eventdata, handles)

leng=getCurrentPopupString(handles.popupmenu1); 

if(str2double(leng)<=0)
    h=msgbox('Please select the number of places from left & press ok ','info','warn');
    set(handles.uitable1,'enable','off')
    return;
else
    setappdata(hObject,'CurrentCell',eventdata.Indices);
end
 
function uitable3_CellSelectionCallback(hObject, eventdata, handles)

leng2=getCurrentPopupString(handles.popupmenu2); %  get number of transitions
msg=get(handles.uitable3,'Data');
D2 = msg(:,1);
S = strtrim(D2);
C=cellstr(S);
ktemp=C(~cellfun(@isempty, C));

if(str2double(leng2)<=0),
    h=msgbox('Please select the number of trans from left','info','warn');
    set(handles.uitable3,'enable','off');return;
elseif(length(ktemp) < str2double(leng2))
    %setappdata(hObject,'CurrentCell',eventdata.Indices);
elseif(length(ktemp) == str2double(leng2)),
    disp('------------Equal---cellselection')    
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
global myglobalvar2;
%%%%for transitions
msg2=get(handles.uitable3,'Data');
D2trans = msg2(:,1);
Strans = strtrim(D2trans);
Ctrans=cellstr(Strans);
ktemp2=Ctrans(~cellfun(@isempty, Ctrans));
car=strtrim(Ctrans);
ktrans=char(car);
myglobalvar2=ktemp2;
if isempty(myglobalvar2),
    h=msgbox('No Transition has been entered','Erro','error');
else
set(handles.listbox3,'String',ktemp2);
set(handles.listbox4,'String',ktemp2);
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','on');
end

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
global temp4;
% set(handles.uitable3,'CellSelectionCallBack',@(h,e) set(h,'UserData',e))
D=get(handles.uitable3,'Data');
D(:,1) = [];
set(handles.uitable3,'Data',D);
set(hObject, 'Enable', 'On');

% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
global OutWeig;

OutWeig=getCurrentPopupString(handles.popupmenu6); 

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.

function Menu1_1_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% New module creation
close(GPenSIM_Create_Start)
try
    %run(GPenSIM_Create_Start.m);
    eval(GPenSIM_Create_Start);
catch err
    disp(err)
end

 clear all;clc;

% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
%This function is similar to import module,, ,they have the same
%functionaluty
global im_place; %Stores the places globaly
global im_trans;%stores the trans globally
global im_arcs;%stores the arcs globally

try
    % [filename,pathname] = uigetfile('Result_files\*_def.m','Select a PDF file');
    [filename,pathname] = uigetfile('*_def.m','Select a PDF file');
    file=[pathname,filename];
    copyfile(file,'temp_val.m','f')
    % open('temp_val.m');
    a=eval('temp_val');
    m=a.set_of_Ps;
    im_place=a.set_of_Ps;
    im_trans=a.set_of_Ts;
    im_arcs=a.set_of_As;
    
    fileprt=filename;
    le=length(fileprt);
    fileprt(le)=[];
    for i=1:5
        fileprt(le-i)=[];
    end

    im_name=a.PN_name;
    set(handles.edit1,'String',im_name);
    set(handles.edit2,'String',fileprt);
    set(handles.listbox2,'String',im_place);
    set(handles.listbox5,'String',im_place);
    set(handles.listbox3,'String',im_trans);
    set(handles.listbox4,'String',im_trans);
    leng1=length(im_place);
    leng2=length(im_trans);
    set(handles.edit4,'String',leng1)
    set(handles.edit5,'String',leng2)
    %clear the field
    set(handles.uitable1,'Data','');
    Data=get(handles.uitable1,'Data');
    List=get(handles.listbox2,'string');
    D2 = Data; S = strtrim(D2);
    C=cellstr(S);
    ktemp=C(~cellfun(@isempty, C));
    Data2=[ktemp;List];
    
    set(handles.uitable1,'Data',Data2);
    %%%%%%similarly for listbox2
    set(handles.uitable3,'Data','');
    Data4=get(handles.uitable3,'Data');
    List2=get(handles.listbox3,'string');
    D3 = Data4; S2 = strtrim(D3); C2=cellstr(S2);
    ktemp2=C2(~cellfun(@isempty, C2));
    Data2=[ktemp2;List2];
    set(handles.uitable3,'Data',Data2);
catch err
    disp(err)
end
clear all;

% --------------------------------------------------------------------
%The below codes are used for menu. i.e.file, edit, and so on...
function Untitled_4_Callback(hObject, eventdata, handles)
% to save the module, similar to create module(pushbutton7)
% [filename,path] = uiputfile('myfile.m','Save file name');
pushbutton7_Callback(hObject, eventdata, handles);
[cdata] = imread('image.jpg'); 
h = msgbox('File Saved', 'info!','custom',cdata);

% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% This function is for saveas menu function. can be developed further... but 
% dont have much use for the time being 

% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
GPenSIM_Modul_delet; % This function does exactly like the delete module

% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% This is to rename a module,,, cab be further modified... or is under
% constraction.
disp('Under Constraction');
% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% this function invokes a import module function... 
pushbutton14_Callback(hObject, eventdata, handles);

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
global file_Name;
% this function is just to edit in matlab script editor.
%fName=['Result_files\',file_Name,'.m'];
fName=[file_Name,'.m'];
edit(fName);
% --- If Enable == 'on', executes on mouse press 
% --- Otherwise, executes on mouse press 

function edit3_ButtonDownFcn(hObject, eventdata, handles)
% this runs on button donw event.
set(hObject, 'Enable', 'On');
uicontrol(handles.edit3);

% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
clc;
% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
clear all;

% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
global InputWeig;
InputWeig=getCurrentPopupString(handles.popupmenu7); 

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
leng=getCurrentPopupString(handles.popupmenu1); 
msg=get(handles.uitable1,'Data');
D2 = msg(:,1);
S = strtrim(D2);
C=cellstr(S);
ktemp=C(~cellfun(@isempty, C));
if(str2double(leng)<=0)
    h=msgbox('Please select the number of places','info','warn');
    set(handles.uitable1,'enable','off');
    return;
elseif (length(ktemp)<str2double(leng))
    setappdata(hObject,'CurrentCell',eventdata.Indices);
else
    h=msgbox('Limit of place reached, please click on the Save_places and continue','info','warn');
    set(handles.uitable1,'enable','inactive');
end

% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
leng2=getCurrentPopupString(handles.popupmenu2); 
msg=get(handles.uitable3,'Data');
D2 = msg(:,1);
S = strtrim(D2);
C=cellstr(S);
ktemp=C(~cellfun(@isempty, C));
if(str2double(leng2)<=0),
    h=msgbox('Please select the number of transitions from the left','info','warn');
    set(handles.uitable3,'enable','off')
    return;
elseif(length(ktemp) < str2double(leng2))
    setappdata(hObject,'CurrentCell',eventdata.Indices);
else
    h=msgbox('Limit of transition reached, please click on the Save_trans and continue','info','warn');
    set(handles.uitable3,'enable','inactive');
    return;
end

function edit1_Callback(hObject, eventdata, handles)
% A textbox to read the petrinet name.... png.PN_name
function edit2_Callback(hObject, eventdata, handles)
% An input textbox for reading a petrinet defintion file... _def.m

function pushbutton16_ButtonDownFcn(hObject, eventdata, handles)

% --- Executes on key press with focus on uitable1 and none of its controls.
function uitable1_KeyPressFcn(hObject, eventdata, handles)
% global temp3;
% leng=getCurrentPopupString(handles.popupmenu1); 
% msg=get(handles.uitable1,'Data');
% D2 = msg(:,1);
% S = strtrim(D2);
% C=cellstr(S);
% ktemp=C(~cellfun(@isempty, C));
% % Index=get(handles.uitable1,'UserData');
% % Index.Indices
% if(str2double(leng)<=0)
%     h=msgbox('Please select the number of places','info','warn');
% elseif (length(ktemp)<str2double(leng))
%     setappdata(hObject,'CurrentCell',eventdata);
% else
%     h=msgbox('Limit of place reached Click on "Edit" to edit','info','warn');
% end
% --------------------------------------------------------------------
function uitable1_ButtonDownFcn(hObject, eventdata, handles)
leng=getCurrentPopupString(handles.popupmenu1); 
msg=get(handles.uitable1,'Data');
D2 = msg(:,1);
S = strtrim(D2);

C=cellstr(S);
ktemp=C(~cellfun(@isempty, C));
if(str2double(leng)<=0)
    h=msgbox('Please select the number of places','info','warn');
elseif (length(ktemp)<str2double(leng))
    setappdata(hObject,'CurrentCell',eventdata.Indices);
else
    h=msgbox('Limit of place reached Click on "Edit" to edit','info','warn');
end


function edit4_Callback(hObject, eventdata, handles)
% every object should be called in GUIDE by callback event...
% otherwise creates a
% conflict for the compiler.

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
% every called back should be called in GUIDE... otherwise creates a
% conflict for the compiler.

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
% every called back should be called in GUIDE... otherwise creates a
% conflict for the compiler.

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on key press with focus on edit3 and none of its controls.
function edit3_KeyPressFcn(hObject, eventdata, handles)
set(handles.edit3,'String','');
% --- Executes when selected object is changed in the radio button for create module.
function uipanel7_SelectionChangeFcn(~, eventdata, handles)
% A program to select 
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton1'
        set(handles.pushbutton14,'Enable','off');
        set(handles.pushbutton7,'Enable','on');
        
    case 'radiobutton2'
        %display('Radio button 2');
        set(handles.pushbutton14,'Enable','on');
        set(handles.pushbutton7,'Enable','off');
   
end
% --- Executes during object creation, after setting all properties.
function uipanel7_CreateFcn(hObject, eventdata, handles)

function edit3_Callback(hObject, eventdata, handles)
% every called back should be called in GUIDE... otherwise creates a
% conflict for the compiler.

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

delete(hObject);clear all;clc;

% --------------------------------------------------------------------
function uitable3_ButtonDownFcn(hObject, eventdata, handles)
leng2=getCurrentPopupString(handles.popupmenu2); 
msg=get(handles.uitable3,'Data');
D2 = msg(:,1);
S = strtrim(D2);
% disp(S);
C=cellstr(S);
ktemp=C(~cellfun(@isempty, C));

if(str2double(leng2)<=0),
    h=msgbox('Please select the number of transitions from the left','info','warn');
elseif(length(ktemp) < str2double(leng2))
    setappdata(hObject,'CurrentCell',eventdata.Indices);
else
    h=msgbox('Limit of transition reached Click "Edit" to edit','info','warn');
end

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
set(handles.uitable1,'enable','on');
set(handles.uitable3,'enable','on');

% --- Executes on key press with focus on uitable3 and none of its controls.
function uitable3_KeyPressFcn(hObject, eventdata, handles)
% leng2=getCurrentPopupString(handles.popupmenu2); 
% msg=get(handles.uitable3,'Data');
% D2 = msg(:,1);
% S = strtrim(D2);
% % disp(S);
% C=cellstr(S);
% ktemp=C(~cellfun(@isempty, C));
% 
% if(str2double(leng2)<=0),
%     h=msgbox('Please select the number of transitions from the left','info','warn');
% elseif(length(ktemp) < str2double(leng2)),
%    %setappdata(hObject,'CurrentCell',eventdata.Indices);
% else
%     h=msgbox('Limit of transition reached Click "Edit" to edit','info','warn');
% end
