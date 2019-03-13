function solution = ga(fitnessFunction)
%% GA config
pc = 0.2;
pm = 1;
mutdist = 5;

popsize = 5;
maxgen = 25;
tsize = 2;
low = 0;
up = 10;
domain = [low:0.01:up];
maxruns = 1;

%% GA

pop = rand(popsize,1); pop = [pop fitnessFunction(pop(:,1))];
elites = []; pops = []; gen = 1;
colorsElites = [0:1/maxgen:1];colorsElites(end) = [];
colorsPop = repmat(colorsElites,popsize,1);
while gen <= maxgen
    
    [maxfit, elite] = max(pop(:,2),[],1);
    elites = [elites;pop(elite)];
    pops = [pops,pop(:,1)];
    newpop = zeros(popsize-1,2);
    % Recombination
    % Selection
    fits = pop(:,2);
    parents1 = randi(popsize-1,popsize-1,tsize);
    [fit1, p] = max(fits(parents1),[],2);
    Index1=sub2ind(size(pop(2:popsize,:)),1:popsize-1,p');
    
    parents2 = randi(popsize-1,popsize-1,tsize);
    [fit1, p] = max(fits(parents2),[],2);
    Index2=sub2ind(size(pop(2:popsize,:)),1:popsize-1,p');
    
    parents = [pop(parents1(Index1)')' pop(parents2(Index2)')'];
    % Crossover (simple arithmetic mean)
    newpop(:,1) = mean(parents,2);
    
    % Mutation
    sig = 1;        pm_ = pm * sig;         mutdist_ = mutdist * sig;
    newpop(:,1) = newpop(:,1) + (rand(popsize-1,1)-0.5).*(rand(popsize-1,1)<pm_)*mutdist_;
    newpop(:,2) = fitnessFunction(newpop(:,1));
    % Elitism
    newpop = [pop(elite,:);newpop];
    pop = newpop;
    gen = gen + 1;
end
