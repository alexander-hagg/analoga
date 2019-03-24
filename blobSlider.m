zahlBlobs = 1;
[~,blobGenen,wieGross,gridBlobs] = randomBlob(zahlBlobs,elefant);
blob = phenotypBlob(blobGenen,wieGross,gridBlobs);

blob_slider(blobGenen,wieGross,gridBlobs);

function blob_slider(blobGenen,wieGross,gridBlobs)
hfig = figure(3);
blob = phenotypBlob(blobGenen,wieGross,gridBlobs);
imagesc(blob); colormap([0 0 0; 1 1 1]); 
setappdata(hfig,'genom',blobGenen);
slider1 = uicontrol('Parent', hfig,'Style','slider',...
    'Units','normalized',...
    'Position',[0.3 0.0 0.4 0.05],...
    'Tag','slider1',...
    'UserData',struct('val',blobGenen(2),'blobGenen',blobGenen,'wieGross',wieGross,'gridBlobs',gridBlobs),...
    'Callback',@slider_callback);

slider2 = uicontrol('Parent', hfig,'Style','slider',...
    'Units','normalized',...
    'Position',[0.3 0.05 0.4 0.05],...
    'Tag','slider2',...
    'UserData',struct('val',blobGenen(3),'blobGenen',blobGenen,'wieGross',wieGross,'gridBlobs',gridBlobs),...
    'Callback',@slider_callback_2);


%slider3 = uicontrol('Parent', hfig,'Style','slider',...
%    'Units','normalized',...
%    'Position',[0.3 0.1 0.4 0.05],...
%    'Tag','slider2',...
%    'UserData',struct('val',blobGenen(1),'blobGenen',blobGenen,'wieGross',wieGross,'gridBlobs',gridBlobs),...
%    'Callback',@slider_callback_3);

slider1.Value = blobGenen(2);
slider2.Value = blobGenen(3);
%slider3.Value = blobGenen(1);
end

function slider_callback(hObject,eventdata)
h = findobj('Tag','slider1');
data = h.UserData;
genom = getappdata(hObject.Parent,'genom');
genom(2) = hObject.Value;
blob = phenotypBlob(genom,data.wieGross,data.gridBlobs);
setappdata(hObject.Parent,'genom',genom);
imagesc(blob);
end

function slider_callback_2(hObject,eventdata)
h = findobj('Tag','slider2');
data = h.UserData;
genom = getappdata(hObject.Parent,'genom');
genom(3) = hObject.Value;
blob = phenotypBlob(genom,data.wieGross,data.gridBlobs);
setappdata(hObject.Parent,'genom',genom);
imagesc(blob)
end

function slider_callback_3(hObject,eventdata)
h = findobj('Tag','slider2');
data = h.UserData;
genom = getappdata(hObject.Parent,'genom');
genom(1) = hObject.Value;
blob = phenotypBlob(genom,data.wieGross,data.gridBlobs);
setappdata(hObject.Parent,'genom',genom);
imagesc(blob)
end