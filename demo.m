
%% % Zeige den Elefanten
elefant = logical(imread('elefant-50x50.png'));
figure(1); imagesc(elefant); 

                                                                            % Passe das Plot an
                                                                            colormap([0 0 0; 1 1 1]);
                                                                            title('Elefant');
                                                                            

%% % Zeige einen Blob
blob = baueBlob(elefant);

% Ist der Blob ein Elefant? Frag dem Orakel. Es weiß alles.
[qualitaet,~] = orakel(blob,elefant);



figure(2); zeigeblob(blob); 
%title(['Blob: ' num2str(wieVieleRichtig) ' von ' num2str(numel(elefant))]);
title(['Blob Qualität: ' num2str(qualitaet)]);

