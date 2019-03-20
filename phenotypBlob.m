function blob = phenotypBlob(blobGenen,wieGross)
blob = ones(wieGross,wieGross);

for i = 1:size(blobGenen,2)
    radius = floor(0.5*blobGenen(1,i)*wieGross);
    center = [floor(blobGenen(2,i)*wieGross),floor(blobGenen(3,i)*wieGross)];
    x = [1:wieGross]; y = x; [X,Y] = ndgrid(x,y);
    distanzen = pdist2([X(:),Y(:)],center);
    %if blobGenen(4,i) < 0.5
    %    blob(distanzen < radius) = 0;
    %else
        blob(distanzen < radius) = 0;
    %end
end

end