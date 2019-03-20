function [population,elite,maxfit] = ga(blobExample,orakel,elefant)
% Setze Konfigurationsvariablen
%pc = 0.8;
pm = 2/numel(blobExample);
mutdist = 0.3;
popsize = 20;
maxGen = 1000;

tsize = 2;
drawProgress = true;


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
    blob = zeigeBlob(squeeze(population(s,:,:)),elefant);
    fitness(s) = orakel(blob,elefant);
end


%%

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
    radii(radii>0.3) = 0.3;
    %radii(radii<0.05) = 0.05;
    newpop(:,1,:) = radii;
    
    %newpop(:,1:3,1:2) = fixedGenes;   
    % Elitism
    newpop(1,:,:) = population(elite,:,:);
    fitness(1) = maxfit(gen);
    
    population = newpop;
    for s=2:size(population,1)
        blob = zeigeBlob(squeeze(population(s,:,:)),elefant);
        fitness(s) = orakel(blob,elefant);
    end
    
    if drawProgress && ~mod(gen,100)
        solution = squeeze(population(elite,:,:));
        blob = phenotypBlob(solution,size(elefant,1));
        figure(2); zeigeblob(blob); 
        grid on; grid minor;
        title(['Gen: ' int2str(gen) ' Blob Qualität: ' num2str(maxfit(end)) ' /100']);
        
        for pp=2:size(population,1)
             solution = squeeze(population(pp,:,:));
             blob = phenotypBlob(solution,size(elefant,1));
             figure(pp+1); zeigeblob(blob); 
             grid on; grid minor;
             title(['Blob Qualität: ' num2str(fitness(pp))]);
         
         end
        
        figure(size(population,1)+2); hold off; plot(maxfit); hold on;
        plot(medianFit); xlabel('Generationen'); ylabel('Fitness');axis([0 maxGen 0 100]);
        figure(size(population,1)+3); plot(distToElite); xlabel('Generationen'); ylabel('Median Distanz zu Elite');axis([0 maxGen 0 3]);
        %figure(10);imagesc(reshape(population,size(population,1),[]))
        drawnow;
        %drawProgress = false;
    end
end


%% END OF CODE
