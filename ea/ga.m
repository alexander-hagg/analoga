function [population,elite,maxfit] = ga(blobExample,orakel,elefant)
% Setze Konfigurationsvariablen
%pc = 0.8;
pm = 3/numel(blobExample);
mutdist = 0.1;
popsize = 15;
maxGen = 2000;

tsize = 2;
drawProgress = true;

x = [1:size(elefant,1)]; y = x; [imgGrid.X,imgGrid.Y] = ndgrid(x,y);

% Initiiere Variablen
elites = []; pops = [];

%% GA
%freshpopulation = rand(popsize,size(blobExample,1),size(blobExample,2));

sobSequence = scramble(sobolset(size(blobExample,1)*size(blobExample,2),'Skip',1e3),'MatousekAffineOwen');
freshpopulation = sobSequence(1:popsize,:);
freshpopulation = reshape(freshpopulation,popsize,size(blobExample,1),size(blobExample,2));
freshpopulation(:,1,:) = 0.1*freshpopulation(:,1,:);

population = freshpopulation;


for s=1:size(population,1)
    blob = phenotypBlob(squeeze(population(s,:,:)),size(elefant,1),imgGrid);
    fitness(s) = orakel(blob,elefant);
end


%%
h = figure(1);
subplot(1,2,1);
zeigeblob(elefant);
axis tight manual % this ensures that getframe() returns a consistent size
grid on; grid minor;
title('Ziel');
filename = 'testAnimated.gif';
% Capture the plot as an image
frame = getframe(h);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,2);
% Write to the GIF File
imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
startFrame = false;


for gen = 1:maxGen
    disp([int2str(gen) '/' int2str(maxGen) ' - max fit: ' num2str(max(fitness))]);
    [maxfit(gen), elite] = max(fitness);
    distToElite(gen) = median(pdist2(population(2:end,:),population(1,:)));
    
    medianFit(gen) = median(fitness(:));
    elites = [elites;squeeze(population(elite,:,:))];
    if gen > 1 && maxfit(gen) > maxfit(gen-1)
        drawProgress = true;
    end
    newpop = zeros(size(population));
    
    % Recombination
    % Selection
    parents1 = randi(popsize,2*(popsize-1),tsize);
    firstBetter = fitness(parents1(:,1)) > fitness(parents1(:,2));
    parents1 = [parents1(firstBetter,1);parents1(~firstBetter,2)];
    
    % Biased SUS
    motherIDs = parents1(1:end/2);
    fatherIDs = parents1(end/2+1:end);
    mothersBetter = fitness(motherIDs)>fitness(fatherIDs);
    mothers = population(parents1(1:end/2),:,:);
    fathers = population(parents1(end/2+1:end),:,:);
    crossoverGenes = rand(size(mothers,1),size(mothers,2),size(mothers,3)) > 0.6;
    for par=1:size(motherIDs,1)
        if mothersBetter(par)
            mergedParents(par,:,:) = squeeze(mothers(par,:,:));
            mergedParents(crossoverGenes(par,:,:)) = squeeze(fathers(crossoverGenes(par,:,:)));
        else
            mergedParents(par,:,:) = squeeze(fathers(par,:,:));
            mergedParents(crossoverGenes(par,:,:)) = squeeze(mothers(crossoverGenes(par,:,:)));
        end
    end
    newpop(2:end,:,:) = mergedParents;
    
    % Mutation
    doMutation = rand(size(population))<pm;
    mutationValue = randn(size(population))*mutdist;
    newpop = newpop + mutationValue.*doMutation;
    
    % Clamp to boundary values
    newpop(newpop>1) = 1;
    newpop(newpop<0) = 0;
    radii = newpop(:,1,:);
    radii(radii>0.2) = 0.2;
    newpop(:,1,:) = radii;
    
    %newpop(:,1:3,1:2) = fixedGenes;
    % Elitism
    newpop(1,:,:) = population(elite,:,:);
    fitness(1) = maxfit(gen);
    
    population = newpop;
    for s=2:size(population,1)
        blob = phenotypBlob(squeeze(population(s,:,:)),size(elefant,1),imgGrid);
        fitness(s) = orakel(blob,elefant);
    end
    
    if drawProgress && ~mod(gen,10)
        figure(1);
        subplot(1,2,2);
        solution = squeeze(population(elite,:,:));
        blob = phenotypBlob(solution,size(elefant,1),imgGrid);
        %subplot(1,2,2);
        zeigeblob(blob);
        title(['Generation: ' int2str(gen) ' Qualität: ' num2str(sprintf('%0.2f', maxfit(end))) '%']);
        drawnow;
        
        % Capture the plot as an image
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        % Write to the GIF File
        imwrite(imind,cm,filename,'gif','WriteMode','append');
        
        showNumMembers = 9; %size(population,1);
        for pp=1:showNumMembers
             solution = squeeze(population(pp,:,:));
             blob = phenotypBlob(solution,size(elefant,1),imgGrid);
             figure(2); 
             subplot(floor(sqrt(showNumMembers)),ceil(sqrt(showNumMembers)),pp);
             zeigeblob(blob);
             grid on; grid minor;
             title(['Blob Qualität: ' num2str(fitness(pp))]);
        end
        
        %figure(size(population,1)+2); hold off; plot(maxfit); hold on;
        %plot(medianFit); xlabel('Generationen'); ylabel('Fitness');axis([0 maxGen 0 100]);
        %figure(size(population,1)+3); plot(distToElite); xlabel('Generationen'); ylabel('Median Distanz zu Elite');axis([0 maxGen 0 3]);
        %figure(10);imagesc(reshape(population,size(population,1),[]))
        %drawnow;
        %drawProgress = false;
    end
end


%% END OF CODE
