%% Workshop: Wie macht man aus einem Blob einen Elefanten?
% 
% In diesem Workshop werden wir sehen, wie man ein Bild nachbauen kann mit
% Hilfe eines evolutionären Algorithmus.
%
% Der Code enthält nicht alle Inhalte des Workshops, und ist in Matlab
% geschrieben. 
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% March 2019


%% % Zeige den Elefanten
elefant = logical(imread('elefant-50x50-2.png'));
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
title('Wie können wir den Blob anpassen?');


%% % Evolviere den Blob zum Elefanten
%elefant = logical(imread('mycircle.png'));
elefant = logical(imread('elefant-50x50-2.png'));
zahlBlobs = 100;
[~,blobGenen] = randomBlob(zahlBlobs,elefant);
set(0,'DefaultFigureWindowStyle','default')
[population,elite,maxfit] = ga(blobGenen,@orakel,elefant);
solution = squeeze(population(elite,:,:));


