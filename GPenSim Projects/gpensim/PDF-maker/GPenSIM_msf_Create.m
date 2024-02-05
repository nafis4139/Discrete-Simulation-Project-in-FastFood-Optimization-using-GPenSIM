function varargout = GPenSIM_msf_Create(varargin)
%GPenSIM_msf_Create M-file for GPenSIM_msf_Create.fig
%      GPenSIM_msf_Create, by itself, creates a new GPenSIM_msf_Create or raises the existing
%      singleton*.
%
%      H = GPenSIM_msf_Create returns the handle to a new GPenSIM_msf_Create or the handle to
%      the existing singleton*.
%
%      GPenSIM_msf_Create('Property','Value',...) creates a new GPenSIM_msf_Create using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GPenSIM_msf_Create_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GPenSIM_msf_Create('CALLBACK') and GPenSIM_msf_Create('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GPenSIM_msf_Create.M with the given input
%      arguments.
%


% Last Modified by GUIDE v2.5 23-Apr-2014 09:31:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GPenSIM_msf_Create_OpeningFcn, ...
                   'gui_OutputFcn',  @GPenSIM_msf_Create_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GPenSIM_msf_Create is made visible.
function GPenSIM_msf_Create_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for GPenSIM_msf_Create

global newmenu;
global newmenu2;
global f_Name;
handles.output = hObject;

% Update handles structure

guidata(hObject, handles);
%clear all;
% UIWAIT makes GPenSIM_msf_Create wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GPenSIM_msf_Create_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global newmenu;
global newmenu2;
global f_Name;
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit3_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global newmenu;
global new_remove_menu;
new_remove_menu =[];
currentItems = get(handles.listbox1, 'String'); 
curI1=get(handles.listbox2,'String'); 
list_entry = cellstr(currentItems);
index_selected = get(handles.listbox1,'value');
choice_listbox1 = list_entry(index_selected);
%curI1=cellstr(curI1);
    newmenu = [curI1;choice_listbox1];
set(handles.listbox2,'String', newmenu);
set(handles.listbox1, 'Value', []); 
newItems = currentItems; 
newItems(index_selected) = []; 
set(handles.listbox1, 'String', newItems); 
if ~isempty(newItems) 
    if length(newItems) >= 1
        set(handles.listbox1, 'Value', 1);
    end
end
%clear handles;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global new_remove_menu;
global newmenu;
newmenu=[];
currentItems2 = get(handles.listbox2, 'String'); 
list_entry = cellstr(currentItems2);
index_selected = get(handles.listbox2,'value');
choice_lstbox2 = list_entry(index_selected);
curI2=get(handles.listbox1,'String'); 
    new_remove_menu = [curI2;choice_lstbox2];
set(handles.listbox1,'String', new_remove_menu);
set(handles.listbox2, 'Value', []); 
newItems = currentItems2; 
newItems(index_selected) = []; 
set(handles.listbox2, 'String', newItems); 
if ~isempty(newItems) 
    if length(newItems) >= 1
        set(handles.listbox2, 'Value', 1);
    end
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)

my_list = dir('*_def.m'); % choose png files from directory
pics_cell = cell(numel(my_list),1);
for k=1:numel(my_list)
    pics_cell{k} = my_list(k).name;
end
set(handles.listbox1,'String',pics_cell) % my_list is the name of your listbox
set(handles.listbox2,'String','') 


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global f_Name;
global x;
x = inputdlg('Enter Main simulation file name_MSF:', 'MSF');
lst=get(handles.listbox2,'String');
ind=get(handles.listbox2,'value');
if(isempty(lst)),
    disp('Please add one or more modules');
%     exit(pushbutton3_Callback);
else
%disp(lst{1})
str0='clear all;clc;';
str1='global global_info;';
str2='global_info.STOP_AT=10;';
str3p='png=petrinetgraph({';
len=length(lst);
str44=[];
for i=1:len
    tem=lst{i};
    lengd=length(tem);
    tem(lengd)=[];
    tem(lengd-1)=[];
str44=[str44,',','''',tem,''''];    
end
str44(1)=[];
str3=[str3p,str44,'});'];
disp('=============')
str4='dyn.m0={};';

str5='dyn.ft = {};';
str6='pni=initialdynamics(png,dyn);';
str7='sim=gpensim(pni);';
str8='print_statespace(sim);';
str9='plotp(sim,{});';
data=cellfun(@num2str,x,'UniformOutput',0);
temps=data{1};

FN=[temps,'.m'];
fName2=FN;%['Result_files\',FN];%pdf file name
fid=fopen(fName2,'w');
if fid ~= -1
  fprintf(fid,'%s\r\n',str0);    %# Print the string  
  fprintf(fid,'%s\r\n',str1);    %# Print the string
  fprintf(fid,'%s\r\n',str2);        
  fprintf(fid,'%s\r\n',str3);        
  fprintf(fid,'%s\r\n',str4);        
  fprintf(fid,'%s\r\n',str5);        
  fprintf(fid,'%s\r\n',str6);        
  fprintf(fid,'%s\r\n',str7);        
  fprintf(fid,'%s\r\n',str8);        
  fprintf(fid,'%s\r\n',str9);        
  fclose(fid);                         %# Close the file
end
dlmwrite(fName2,'','-append',...  %# Print the matrix
         'delimiter','\t',...
         'newline','pc');
%edit(fName2);
f_Name=fName2;%[pathname,filename];
fid = fopen(f_Name,'r');
disp(fid)
if fid~=-1 %if the file doesn't exist ignore the reading code
set(handles.edit3,'String',fscanf(fid,'%c'))
fclose(fid);
end
end
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% A program to create a new module
close(MSF)
try
    %run(GPenSIM_Create.m);
    eval(MSF);
catch err
    disp(err)
end

 clear all;clc; % clear the mess


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global fName2;
global x;
lst=get(handles.listbox2,'String');
ind=get(handles.listbox2,'value');

if(isempty(lst)),
    disp('Please add one or more modules');
%     exit(pushbutton3_Callback);
else
%disp(lst{1})
str0='clear all;clc;';
str1='global global_info;';
str2='global_info.STOP_AT=10;';
str3p='png=petrinetgraph({';
len=length(lst);
str44=[];
for i=1:len
    tem=lst{i};
    lengd=length(tem);
    tem(lengd)=[];
    tem(lengd-1)=[];
str44=[str44,',','''',tem,''''];    
end
str44(1)=[];
str3=[str3p,str44,'});'];
disp('=============')
str4='dyn.m0={};';
str5='dyn.ft = {};';
str6='pni=initialdynamics(png,dyn);';
str7='sim=gpensim(pni);';
str8='print_statespace(sim);';
str9='plotp(sim,{});';
data=cellfun(@num2str,x,'UniformOutput',0);
temps=data{1};
FN=[temps,'.m'];
% fName2=FN;%gpensim_msf_create file name
fid=fopen(FN,'w');
if fid ~= -1
  fprintf(fid,'%s\r\n',str0);    %# Print the string  
  fprintf(fid,'%s\r\n',str1);    %# Print the string
  fprintf(fid,'%s\r\n',str2);        
  fprintf(fid,'%s\r\n',str3);        
  fprintf(fid,'%s\r\n',str4);        
  fprintf(fid,'%s\r\n',str5);        
  fprintf(fid,'%s\r\n',str6);        
  fprintf(fid,'%s\r\n',str7);        
  fprintf(fid,'%s\r\n',str8);        
  fprintf(fid,'%s\r\n',str9);        
  fclose(fid);                     %# Close the file
end
dlmwrite(FN,'','-append',...  %# Print the matrix
         'delimiter','\t',...
         'newline','pc');
end
[cdata] = imread('image.jpg'); 
  h = msgbox('File Saved', 'info!','custom',cdata);
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global f_Name; 
edit(f_Name);
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
clear all;clc;
close(MSF)

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
delete(hObject);
clear all;clc;
