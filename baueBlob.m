function [blob,blobGenen] = baueBlob(zahlGenen,elefant)


wieGross = size(elefant,1);
x = [1:wieGross]; y = x; [grid.X,grid.Y] = ndgrid(x,y);
%blobGenen = [0.3 1 1 1]'.*rand(4,zahlGenen);
%blobGenen(:,1:2) = [0.2,0.4,0.5,0; 0.2, 0.5, 0.7,0]';

blobGenen = [0.3 1 1]'.*rand(3,zahlGenen);
blobGenen(:,1:2) = [0.2,0.4,0.5; 0.2, 0.5, 0.7]';


blob = phenotypBlob(blobGenen,wieGross,grid);


%%


end
