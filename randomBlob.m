function [blob,blobGenen,wieGross,grid] = randomBlob(zahlGenen,elefant)


wieGross = size(elefant,1);
x = [1:wieGross]; y = x; [grid.X,grid.Y] = ndgrid(x,y);
blobGenen = [0.3 1 1]'.*rand(3,zahlGenen);

blob = phenotypBlob(blobGenen,wieGross,grid);


%%


end
