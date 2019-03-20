function blob = phenotypBlob(blobGenen,wieGross,grid)
blob = ones(wieGross,wieGross);

radii = floor(0.5*blobGenen(1,:)*wieGross);
centers = [floor(blobGenen(2,:)*wieGross);floor(blobGenen(3,:)*wieGross)];
distanzen = pdist2([grid.X(:),grid.Y(:)],centers');

for i = 1:size(blobGenen,2)
    %radius = floor(0.5*blobGenen(1,i)*wieGross);
    %center = [floor(blobGenen(2,i)*wieGross),floor(blobGenen(3,i)*wieGross)];
    %distanzen = pdist2([grid.X(:),grid.Y(:)],center);
    blob(distanzen(:,i) < radii(i)) = 0;
end

end