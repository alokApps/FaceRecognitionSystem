function varargout = MAIN(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MAIN_OpeningFcn, ...
    'gui_OutputFcn',  @MAIN_OutputFcn, ...
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



function MAIN_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);




function varargout = MAIN_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


function TEST_Callback(hObject, eventdata, handles)


function ON_callback(hObject, eventdata, handles)
mkdir('C:\Users\alok\Desktop\project\TestDatabase');
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
img = getsnapshot(vid);
axes(handles.axes6);
imshow(img);
guidata(hObject,handles);
FDetect=vision.CascadeObjectDetector('Nose');
BB=step(FDetect,img);
axes(handles.axes7);
imshow(img);
hold on
for i=1:size(BB,1)
    rectangle('position',BB(i,:),'Linewidth',5,'Linestyle','-','Edgecolor','r');
end
hold off
N=size(BB,1);
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Users\alok\Desktop\project\TestDatabase\' ,num2str(counter), '.jpg');
    baseDir  = 'C:\Users\alok\Desktop\project\TestDatabase\';

    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[240,320]);
    imwrite(fac,newName);
    axes(eval(['handles.axes', num2str(i)]));
    imshow(face);
    guidata(hObject,handles);
    pause(5);
end


function CameraOff_Callback(hObject, eventdata, handles)
off=handles.vid;
delete(off);

function EXIT_Callback(hObject, eventdata, handles)
close;


function Test_Callback(hObject, eventdata, handles)
rec=handles.N;
TrainDatabasePath = 'C:\Users\alok\Desktop\project\TrainDatabase\';
TestDatabasePath = 'C:\Users\alok\Desktop\project\TestDatabase\';
v=rec;
 for j = 1:v
     TestImage  = num2str(j);
     s=strcat('a',TestImage);
     TestImage = strcat(TestDatabasePath,'\',char( TestImage),'.jpg');
     T = CreateDatabase(TrainDatabasePath);
     [m, A, Eigenfaces] = EigenfaceCore(T);
     OutputName = Recognition(TestImage, m, A, Eigenfaces);
     SelectedImage = strcat(TrainDatabasePath,'\',  OutputName);
     SelectedImage = imread(SelectedImage);
     axes(eval(['handles.axes', num2str(s)]));
     imshow(SelectedImage);
 end

function ADDPHOTO_Callback(hObject, eventdata, handles)
function ADD_Callback(hObject, eventdata, handles)

for ind=1:3
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
img = getsnapshot(vid);
axes(handles.axes6);
imshow(img);
guidata(hObject,handles);
FDetect=vision.CascadeObjectDetector('FrontalFaceCART');
htextinsface = vision.TextInserter('Text', 'face   : %2d', 'Location',  [5 2],'Font', 'Courier New','FontSize', 14);
BB=step(FDetect,img);
axes(handles.axes7);
imshow(img);
hold on
for i=1:size(BB,1)
    rectangle('position',BB(i,:),'Linewidth',5,'Linestyle','-','Edgecolor','r');
end
hold off
N=size(BB,1);
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Users\alok\Desktop\project\TrainDatabase\' ,num2str(counter), '.jpg');
    baseDir  = 'C:\Users\alok\Desktop\project\TrainDatabase\';
    %     baseName = 'image_';
    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[240,320]);
    imwrite(fac,newName);
   
    axes(eval(['handles.axes', num2str(i)]));
    imshow(face);
    guidata(hObject,handles);
    pause(2);
end
delete(vid);
end


% --------------------------------------------------------------------
function DetectByFace_Callback(hObject, eventdata, handles)
% hObject    handle to DetectByFace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mkdir('C:\Users\alok\Desktop\project\TestDatabase');
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
img = getsnapshot(vid);
axes(handles.axes6);
imshow(img);
guidata(hObject,handles);
FDetect=vision.CascadeObjectDetector('FrontalFaceLBP');
BB=step(FDetect,img);
axes(handles.axes7);
imshow(img);
hold on
for i=1:size(BB,1)
    rectangle('position',BB(i,:),'Linewidth',5,'Linestyle','-','Edgecolor','r');
end
hold off
N=size(BB,1);
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Users\alok\Desktop\project\TestDatabase\' ,num2str(counter), '.jpg');
    baseDir  = 'C:\Users\alok\Desktop\project\TestDatabase\';

    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[240,320]);
    imwrite(fac,newName);
    axes(eval(['handles.axes', num2str(i)]));
    imshow(face);
    guidata(hObject,handles);
    pause(5);
end


% --------------------------------------------------------------------
function DetectByNose_Callback(hObject, eventdata, handles)
% hObject    handle to DetectByNose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mkdir('C:\Users\alok\Desktop\project\TestDatabase');
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
img = getsnapshot(vid);
axes(handles.axes6);
imshow(img);
guidata(hObject,handles);
FDetect=vision.CascadeObjectDetector('Nose');
BB=step(FDetect,img);
axes(handles.axes7);
imshow(img);
hold on
for i=1:size(BB,1)
    rectangle('position',BB(i,:),'Linewidth',5,'Linestyle','-','Edgecolor','r');
end
hold off
N=size(BB,1);
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Users\alok\Desktop\project\TestDatabase\' ,num2str(counter), '.jpg');
    baseDir  = 'C:\Users\alok\Desktop\project\TestDatabase\';

    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[240,320]);
    imwrite(fac,newName);
    axes(eval(['handles.axes', num2str(i)]));
    imshow(face);
    guidata(hObject,handles);
    pause(5);
end



% --------------------------------------------------------------------
function DetectByEyes_Callback(hObject, eventdata, handles)
% hObject    handle to DetectByEyes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mkdir('C:\Users\alok\Desktop\project\TestDatabase');
axes(handles.axes5);
vid = videoinput('winvideo',1);
handles.vid=vid;
vidRes = get(vid, 'VideoResolution');
nBands = get(vid, 'NumberOfBands');
hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
preview(vid,hImage);
img = getsnapshot(vid);
axes(handles.axes6);
imshow(img);
guidata(hObject,handles);
FDetect=vision.CascadeObjectDetector('EyePairSmall');
BB=step(FDetect,img);
axes(handles.axes7);
imshow(img);
hold on
for i=1:size(BB,1)
    rectangle('position',BB(i,:),'Linewidth',5,'Linestyle','-','Edgecolor','r');
end
hold off
N=size(BB,1);
handles.N=N;
counter=1;
for i=1:N
    face=imcrop(img,BB(i,:));
    savenam = strcat('C:\Users\alok\Desktop\project\TestDatabase\' ,num2str(counter), '.jpg');
    baseDir  = 'C:\Users\alok\Desktop\project\TestDatabase\';

    newName  = [baseDir num2str(counter) '.jpg'];
    handles.face=face;
    while exist(newName,'file')
        counter = counter + 1;
        newName = [baseDir num2str(counter) '.jpg'];
    end
    fac=imresize(face,[240,320]);
    imwrite(fac,newName);
    axes(eval(['handles.axes', num2str(i)]));
    imshow(face);
    guidata(hObject,handles);
    pause(5);
end
