clear;

% specify folder to save outputs
savepath = '../dataDifferentFeedingRates/';
filesuffix = 'FeedingRates'; % file name ending

%% Parameter Initialization
for nPatches = [1 2 4]
L = 35;                                                 % size of the lattice --> lattice has LxL sites   
N = 40;                                                  % number of worms in simulation
time = 1000;                                            % number of times steps for which the simulation is executed 
numberSimulations = 500;                                  % number of repetitions of the simulation
numberFUs = 10*L*L;                                     % number of distributed food units (FU)
if nPatches == 1
    initialFUs = onePatch(numberFUs,L);                     % initial distribution of FUs on lattice
elseif nPatches == 2
    initialFUs = twoPatches(numberFUs,L);                     % initial distribution of FUs on lattice
elseif nPatches == 4
    initialFUs = fourPatches(numberFUs,L);                     % initial distribution of FUs on lattice
else
    error(['unsupported number of food patches: ' num2str(nPatches)])
end
totalFUs = sum(sum(initialFUs));
%% Initialize parameters for simulation with attraction                                 
allStepsNpr1 = zeros(N,time,numberSimulations);         % stores number of steps each npr-1 worm has taken at every time step and every simulation repetition
FUsEatenNpr1 = zeros(N,time,numberSimulations);         % stores number of FU each npr-1 worm has eaten at every time step and every simulation repetition
remainingFUsNpr1 = zeros(numberSimulations,time);       % stores the number of remaining food units on the lattice for every time step and every repetition of the simulation
time90percentEatenNpr1 = zeros(numberSimulations,1);    % stores the time when 90% of the food units have been eaten for every repetition of the simulation
speedOnFoodNpr1 = 2;                                    % determines speed of npr-1 worms on food
speedOffFoodNpr1 = 2;                                   % determines speed of npr-1 worms in absence of food 
leavingRateNpr1 = 0                                  % determines food-leaving rate of npr-1 worms 
relativeFeedingRateNpr1 = 0.576
%% Script for foraging with possible targeted steps

parfor simCtr = 1:numberSimulations
    rng(simCtr) % random-number generator seeded reproducibly for this simulation
    % initialize simulation-specific parameters
    thisNpr1 = zeros(N,2,time);                             % stores position of each npr-1 worm for every time step within one repetition
    thisFUsNpr1 = zeros(L,L,time);                          % stores distribution of food units for every time step within one repetition
    % get intitial position of worms and food 
    initialWorms = circularWorms(N,L,nPatches);                      % initial distribution of worms on lattice
    npr1Worms = initialWorms;
    FUsNpr1 = initialFUs;
    
    for t=1:time
   
        % Step 1: Compute the eaten FUs at the current positions of the
        % worms
        [FUsUpdate,FUsEatenNpr1(:,t,simCtr)] = computeFUsUpdate(FUsNpr1,npr1Worms,relativeFeedingRateNpr1);
        FUsNpr1 = max(0,FUsNpr1 + FUsUpdate); % enforce minimum food

        % Step 2: Determine motion update of the worms and save
        % individually taken steps
        [motionUpdate,allStepsNpr1(:,t,simCtr)] = computeMotionUpdateNpr1(N,L,FUsNpr1,...
            npr1Worms,leavingRateNpr1,speedOnFoodNpr1,speedOffFoodNpr1);

        % Step 3: Update the position of the worms
        npr1Worms = npr1Worms + motionUpdate;
        npr1Worms(npr1Worms > L) = npr1Worms(npr1Worms > L) - L;                % employ PBCs
        npr1Worms(npr1Worms < 1) = npr1Worms(npr1Worms < 1) + L;                % employ PBCs

        % Step 4: Save worm and FUs distribution
        thisNpr1(:,:,t) = npr1Worms;
        thisFUsNpr1(:,:,t) = FUsNpr1;
    end
    
    % Calculate remaining FUs and time when 90% of them have been eaten
    remainingFUsNpr1(simCtr,:) = reshape(sum(sum(thisFUsNpr1)),[1,time]);
    allTimes90PercentEatenNpr1 = find(remainingFUsNpr1(simCtr,:) < (sum(sum(initialFUs)) - ...
        (numberFUs * 0.9)));
    if isempty(allTimes90PercentEatenNpr1)
        time90percentEatenNpr1(simCtr) = NaN;
        warning('Not all targets are eaten.Repeat simulation with increased time')
%         return;
    else
        time90percentEatenNpr1(simCtr) = allTimes90PercentEatenNpr1(1);
    end
end
%% save npr1 data
save([savepath 'L' num2str(L) 'N' num2str(N) 'patch' num2str(nPatches) 'Npr1' filesuffix],...
    'time90percentEatenNpr1','FUsEatenNpr1','allStepsNpr1')
    
%% Initialize parameters for simulation of random movement
allStepsN2 = zeros(N,time,numberSimulations);           % stores number of steps each N2 worm has taken at every time step of all simulations
FUsEatenN2 = zeros(N,time,numberSimulations);           % stores number of FUs each N2 worm has eaten at every time step of all simulations
remainingFUsN2 = zeros(numberSimulations,time);         % stores number of remaining food units on the lattice at every time step of all simulations
time90percentEatenN2 = zeros(numberSimulations,1);      % stores time when 90% of the food units have been eaten for each repetition of the simulations
speedOnFoodN2 = 1;                                      % determines speed of N2 worms on food
speedOffFoodN2 = 2;                                     % determines speed of N2 worms in absence of food
leavingRateN2 = 0                                   % determines food-leaving rate of N2 worms
relativeFeedingRateN2 = 1
%% Script for entirely random foraging

parfor simCtr = 1:numberSimulations
    rng(simCtr) % random-number generator seeded reproducibly for this simulation
    % initialize simulation-specific parameters
    thisN2 = zeros(N,2,time);                               % stores position of each N2 worm for every time step of one simulation repetition
    thisFUsN2 = zeros(L,L,time);                            % stores distribution of food units for every time of one simulation repetition

    % get initial position of worms and food 
    initialWorms = circularWorms(N,L,nPatches);                      % initial distribution of worms on lattice
    N2worms = initialWorms;
    FUsN2 = initialFUs;
    
    for l = 1:time

        % Step 1: Compute the eaten FUs at the current positions of the
        % worms
        [FUsUpdate,FUsEatenN2(:,l,simCtr)] = computeFUsUpdate(FUsN2,N2worms,relativeFeedingRateN2);
        FUsN2 = FUsN2 + FUsUpdate;

        % Step 2: Determine motion update of the worms and save
        % individually taken steps
        [motionUpdate,allStepsN2(:,l,simCtr)] = computeMotionUpdateN2(N,L,FUsN2,...
            N2worms,leavingRateN2,speedOnFoodN2,speedOffFoodN2);

        % Step 3: Update the position of the worms
        N2worms = N2worms + motionUpdate;
        N2worms(N2worms > L) = N2worms(N2worms > L) - L;                    % employ PBCs
        N2worms(N2worms < 1) = N2worms(N2worms < 1) + L;                    % employ PBCs

        % Step 4: Save worm and FUs distribution
        thisN2(:,:,l) = N2worms;
        thisFUsN2(:,:,l) = FUsN2;
    end
    
    % Calculate remaining FUs and time when 90% of them have been eaten
    remainingFUsN2(simCtr,:) = reshape(sum(sum(thisFUsN2)),[1,time]);
    allTimes90PercentEatenN2 = find(remainingFUsN2(simCtr,:) < (sum(sum(initialFUs))...
        - (numberFUs * 0.9)));
    if isempty(allTimes90PercentEatenN2)
        time90percentEatenN2(simCtr) = NaN;
        fprintf('Not all targets are eaten. Repeat simulation with increased time')
%         return;
    else
        time90percentEatenN2(simCtr) = allTimes90PercentEatenN2(1);
    end
end
%% save N2 data
save([savepath 'L' num2str(L) 'N' num2str(N) 'patch' num2str(nPatches) 'N2' filesuffix],...
    'time90percentEatenN2','FUsEatenN2','allStepsN2')
%% Create movie

% f = figure;
% set(f,'Units','pixels','Position',[0,0,1920,1080])
%     
% v = VideoWriter('1patch_L35_N40','MPEG-4');
% v.Quality = 100;
% open(v);
% for i = 1:time
%     data_forager = thisNpr1(:,:,i);
%     data_forager_2 = thisN2(:,:,i);
%     F = thisFUsNpr1(:,:,i);
%     F2 = thisFUsN2(:,:,i);
%     
% %     subplot(1,2,1);
%     mesh(F,'EdgeColor','none','FaceColor','interp');
%     hold on;
%     plot(data_forager(:,2),data_forager(:,1),'r.','MarkerSize',20);
%     hold off;
%     axis([1 L 1 L])
%     pbaspect([1 1 1])
%     set(gca,'XTickLabel',[])
%     set(gca,'YTickLabel',[])
%     caxis([0 max(max(initialFUs))])
%     view(0,-90)
%     grid on;
%     title1 = title('npr-1');
%     title1.FontSize = 34; 
%     
% %     subplot(1,2,2);
% %     mesh(F2,'EdgeColor','none','FaceColor','interp');
% %     hold on;
% %     plot(data_forager_2(:,2),data_forager_2(:,1),'r.','MarkerSize',20);
% %     hold off;
% %     axis([1 L 1 L])
% %     pbaspect([1 1 1])
% %     set(gca,'XTickLabel',[])
% %     set(gca,'YTickLabel',[])
% %     caxis([0 max(max(initialFUs))])
% %     view(0,-90)
% %     grid on;
% %     title2 = title('N2');
% %     title2.FontSize = 34;
%     
%     frame = getframe(gcf);
%     writeVideo(v,frame);
% end
% close(v);
end