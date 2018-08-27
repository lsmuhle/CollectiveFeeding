clear;
clear -vars;

%% Parameter Initialization
L = 35;                                                 % size of the lattice --> lattice has LxL sites   
N = 40;                                                  % number of worms in simulation
time = 1800;                                            % number of times steps for which the simulation is executed 
numberSimulations = 1;                                  % number of repetitions of the simulation
numberFUs = 10*L*L;                                     % number of distributed food units (FU)
initialWorms = circularWorms(N,L);                      % initial distribution of worms on lattice       
initialFUs = onePatch(numberFUs,L);                     % initial distribution of FUs on lattice
          
%% Initialize parameters for simulation with attraction                                 
saveNpr1 = zeros(N,2,time);                             % stores position of each npr-1 worm for every time step within one repetition
saveFUsNpr1 = zeros(L,L,time);                          % stores distribution of food units for every time step within one repetition
allStepsNpr1 = zeros(N,time,numberSimulations);         % stores number of steps each npr-1 worm has taken at every time step and every simulation repetition
FUsEatenNpr1 = zeros(N,time,numberSimulations);         % stores number of FU each npr-1 worm has eaten at every time step and every simulation repetition
remainingFUsNpr1 = zeros(numberSimulations,time);       % stores the number of remaining food units on the lattice for every time step and every repetition of the simulation
time90percentEatenNpr1 = zeros(numberSimulations,1);    % stores the time when 90% of the food units have been eaten for every repetition of the simulation
speedOnFoodNpr1 = 2;                                    % determines speed of npr-1 worms on food
speedOffFoodNpr1 = 2;                                   % determines speed of npr-1 worms in absence of food 
leavingRateNpr1 = 0.2;                                  % determines food-leaving rate of npr-1 worms 
%% Script for foraging with possible targeted steps

for loop = 1:numberSimulations
    
    % get intitial position of worms and food 
    npr1Worms = initialWorms;
    FUsNpr1 = initialFUs;
    
    for t = 1:time
   
        % Step 1: Compute the eaten FUs at the current positions of the
        % worms
        [FUsUpdate,FUsEatenNpr1(:,t,loop)] = computeFUsUpdate(FUsNpr1,npr1Worms);
        FUsNpr1 = FUsNpr1 + FUsUpdate;

        % Step 2: Determine motion update of the worms and save
        % individually taken steps
        [motionUpdate,allStepsNpr1(:,t,loop)] = computeMotionUpdateNpr1(N,L,FUsNpr1,...
            npr1Worms,leavingRateNpr1,speedOnFoodNpr1,speedOffFoodNpr1);

        % Step 3: Update the position of the worms
        npr1Worms = npr1Worms + motionUpdate;
        npr1Worms(npr1Worms > L) = npr1Worms(npr1Worms > L) - L;                % employ PBCs
        npr1Worms(npr1Worms < 1) = npr1Worms(npr1Worms < 1) + L;                % employ PBCs

        % Step 4: Save worm and FUs distribution
        saveNpr1(:,:,t) = npr1Worms;
        saveFUsNpr1(:,:,t) = FUsNpr1;
    end
    
    % Calculate remaining FUs and time when 90% of them have been eaten
    remainingFUsNpr1(loop,:) = reshape(sum(sum(saveFUsNpr1)),[1,time]);
    allTimes90PercentEatenNpr1 = find(remainingFUsNpr1(loop,:) < (sum(sum(initialFUs)) - ...
        (numberFUs * 0.9)));
    if isempty(allTimes90PercentEatenNpr1)
        time90percentEatenNpr1(loop) = NaN;
        fprintf('Not all targets are eaten.\nRepeat simulation with increased time\n')
        return;
    else
        time90percentEatenNpr1(loop) = allTimes90PercentEatenNpr1(1);
    end
end

%% Initialize parameters for simulation of random movement
saveN2 = zeros(N,2,time);                               % stores position of each N2 worm for every time step of one simulation repetition
saveFUsN2 = zeros(L,L,time);                            % stores distribution of food units for every time of one simulation repetition
allStepsN2 = zeros(N,time,numberSimulations);           % stores number of steps each N2 worm has taken at every time step of all simulations
FUsEatenN2 = zeros(N,time,numberSimulations);           % stores number of FUs each N2 worm has eaten at every time step of all simulations
remainingFUsN2 = zeros(numberSimulations,time);         % stores number of remaining food units on the lattice at every time step of all simulations
time90percentEatenN2 = zeros(numberSimulations,1);      % stores time when 90% of the food units have been eaten for each repetition of the simulations
speedOnFoodN2 = 1;                                      % determines speed of N2 worms on food
speedOffFoodN2 = 2;                                     % determines speed of N2 worms in absence of food
leavingRateN2 = 0.03;                                   % determines food-leaving rate of N2 worms
%% Script for entirely random foraging

for loop2 = 1:numberSimulations
    
    % get initial position of worms and food 
    N2worms = initialWorms;
    FUsN2 = initialFUs;
    
    for l = 1:time

        % Step 1: Compute the eaten FUs at the current positions of the
        % worms
        [FUsUpdate,FUsEatenN2(:,l,loop2)] = computeFUsUpdate(FUsN2,N2worms);
        FUsN2 = FUsN2 + FUsUpdate;

        % Step 2: Determine motion update of the worms and save
        % individually taken steps
        [motionUpdate,allStepsN2(:,l,loop2)] = computeMotionUpdateN2(N,L,FUsN2,...
            N2worms,leavingRateN2,speedOnFoodN2,speedOffFoodN2);

        % Step 3: Update the position of the worms
        N2worms = N2worms + motionUpdate;
        N2worms(N2worms > L) = N2worms(N2worms > L) - L;                    % employ PBCs
        N2worms(N2worms < 1) = N2worms(N2worms < 1) + L;                    % employ PBCs

        % Step 4: Save worm and FUs distribution
        saveN2(:,:,l) = N2worms;
        saveFUsN2(:,:,l) = FUsN2;
    end
    
    % Calculate remaining FUs and time when 90% of them have been eaten
    remainingFUsN2(loop2,:) = reshape(sum(sum(saveFUsN2)),[1,time]);
    allTimes90PercentEatenN2 = find(remainingFUsN2(loop2,:) < (sum(sum(initialFUs))...
        - (numberFUs * 0.9)));
    if isempty(allTimes90PercentEatenN2)
        time90percentEatenN2(loop2) = NaN;
        fprintf('Not all targets are eaten.\nRepeat simulation with increased time\n')
        return;
    else
        time90percentEatenN2(loop2) = allTimes90PercentEatenN2(1);
    end
end

%% Create movie

f = figure;
set(f,'Units','pixels','Position',[0,0,1920,1080])
    
v = VideoWriter('1patch_L35_N40','MPEG-4');
v.Quality = 100;
open(v);
for i = 1:time
    data_forager = saveNpr1(:,:,i);
    data_forager_2 = saveN2(:,:,i);
    F = saveFUsNpr1(:,:,i);
    F2 = saveFUsN2(:,:,i);
    
    subplot(1,2,1);
    mesh(F,'EdgeColor','none','FaceColor','interp');
    hold on;
    plot(data_forager(:,2),data_forager(:,1),'r.','MarkerSize',20);
    hold off;
    axis([1 L 1 L])
    pbaspect([1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    caxis([0 max(max(initialFUs))])
    view(0,-90)
    grid on;
    title1 = title('npr-1');
    title1.FontSize = 34; 
    
    subplot(1,2,2);
    mesh(F2,'EdgeColor','none','FaceColor','interp');
    hold on;
    plot(data_forager_2(:,2),data_forager_2(:,1),'r.','MarkerSize',20);
    hold off;
    axis([1 L 1 L])
    pbaspect([1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    caxis([0 max(max(initialFUs))])
    view(0,-90)
    grid on;
    title2 = title('N2');
    title2.FontSize = 34;
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);