
%% % Zeige den Elefanten
elefant = logical(imread('elefant-50x50.png'));
%elefant = logical(imread('elefant-2-100x100.png'));
%elefant = ~logical(imread('myelephant.bmp'));
%elefant = logical(imread('mycircle.png'));

figure(1); imagesc(elefant); 

% Passe das Plot an
colormap([0 0 0; 1 1 1]);
title('Elefant');
grid on; grid minor;
                                                                            

%% % Zeige einen Blob
zahlBlobs = 100;
[blob,blobGenen] = baueBlob(zahlBlobs,elefant);
%blob = phenotypBlob(blobGenen,size(elefant,1));

% Ist der Blob ein Elefant? Frag dem Orakel. Es weiß alles.
[qualitaet] = orakel(blob,elefant);

figure(2); zeigeblob(blob); 
grid on; grid minor;
title(['Blob Qualität: ' num2str(qualitaet) ' /100']);

%% % Evolviere den Blob zum Elefanten
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


