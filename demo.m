
%% % Zeige den Elefanten
elefant = logical(imread('elefant-50x50.png'));
figure(1); imagesc(elefant); 

                                                                            % Passe das Plot an
                                                                            colormap([0 0 0; 1 1 1]);
                                                                            title('Elefant');
                                                                            

%% % Zeige einen Blob
zahlGenen = 3;
blob = baueBlob(zahlGenen,elefant);

% Ist der Blob ein Elefant? Frag dem Orakel. Es weiß alles.
[qualitaet,~] = orakel(blob,elefant);

figure(2); zeigeblob(blob); 
%title(['Blob: ' num2str(wieVieleRichtig) ' von ' num2str(numel(elefant))]);
title(['Blob Qualität: ' num2str(qualitaet) ' /100']);

%% % Evolviere den Blob zum Elefanten
[beispielBlob,blobGenen] = baueBlob(zahlGenen,elefant);
solution = ga(blobGenen,@orakel,elefant)