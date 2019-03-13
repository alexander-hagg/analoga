function [blob,blobGenen] = baueBlob(zahlGenen,elefant)


wieGross = size(elefant,1);
blob = ones(wieGross,wieGross);

blobGenen = [0.3 1 1]'.*rand(3,zahlGenen);
blobGenen(:,1:2) = [0.3,0.4,0.5; 0.4, 0.5, 0.7]';

for i = 1:size(blobGenen,2)
    radius = floor(0.5*blobGenen(1,i)*wieGross);
    center = [floor(blobGenen(2,i)*wieGross),floor(blobGenen(3,i)*wieGross)];
    x = [1:wieGross]; y = x; [X,Y] = ndgrid(x,y);
    distanzen = pdist2([X(:),Y(:)],center);
    blob(distanzen < radius) = 0;
end
%figure(2);imagesc(blob); colormap([0 0 0; 1 1 1]);


%%


end
