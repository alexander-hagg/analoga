%% % Zeige den Elefanten
elefant = logical(imread('elefant-50x50.png'));
figure(1); imagesc(elefant); colormap([0 0 0; 1 1 1]); title('Wie entsteht aus einem Blob einen Elefanten?'); grid on; grid minor;


%% % Zeige den Kreis
elefant = logical(imread('mycircle.png'));
figure(1); imagesc(elefant); colormap([0 0 0; 1 1 1]); title('Versuchen wir zuerst einen runden Blob zu bilden.'); grid on; grid minor;

%% % Zeige einen Blob
zahlBlobs = 1;
[~,blobGenen,wieGross,gridBlobs] = randomBlob(zahlBlobs,elefant);
blob = phenotypBlob(blobGenen,wieGross,gridBlobs);
figure(2); imagesc(blob); colormap([0 0 0; 1 1 1]); title('Das ist ein willkürlicher Blob.'); grid on; grid minor;
          

%% % Ändere den Blob
blobSlider;

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


