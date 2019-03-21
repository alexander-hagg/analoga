
%% % Zeige den Elefanten
elefant = logical(imread('elefant-50x50.png'));
%elefant = logical(imread('elefant-2-100x100.png'));
%elefant = ~logical(imread('myelephant.bmp'));
%elefant = logical(imread('mycircle.png'));

figure(1); imagesc(elefant); colormap([0 0 0; 1 1 1]); title('Elefant'); grid on; grid minor;
                                                                            

%% % Zeige einen Blob
zahlBlobs = 1;
[~,blobGenen,wieGross,gridBlobs] = randomBlob(zahlBlobs,elefant);
blob = phenotypBlob(blobGenen,wieGross,gridBlobs);

genEins = 0.5;
genZwei = 0.5;
genDrei = 0.5;

f = figure(2); colormap([0 0 0; 1 1 1]);
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.7]);
h = imagesc(ax,blob);

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'value',genEins, 'min',0, 'max',1);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
                'String','1','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
                'String','Damping Ratio','BackgroundColor',bgcolor);

b.Callback = @(blobGenen) imagesc(h, phenotypBlob(blobGenen,wieGross,gridBlobs) ); 
% Ist der Blob ein Elefant? Frag dem Orakel. Es weiß alles.
%[qualitaet] = orakel(blob,elefant);

%figure(2); zeigeblob(blob); grid on; grid minor; title(['Blob Qualität: ' num2str(qualitaet) ' /100']);

%% % Evolviere den Blob zum Elefanten
zahlBlobs = 100;
[~,blobGenen] = baueBlob(zahlBlobs,elefant);
set(0,'DefaultFigureWindowStyle','default')
%profile on;
[population,elite,maxfit] = ga(blobGenen,@orakel,elefant);
%profile off;
%profile viewer
solution = squeeze(population(elite,:,:));

%blob = phenotypBlob(solution,size(eleprfant,1));
%figure(3); zeigeblob(blob); 
%grid on; grid minor;
%title(['Blob Qualität: ' num2str(maxfit(end)) ' /100']);

%figure(4); plot(maxfit); xlabel('Generationen'); ylabel('Fitness');


