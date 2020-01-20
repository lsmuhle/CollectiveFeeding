clear; 
clear -vars;
%% Parameter Initialization
gamma = 0;                                                          % controls  degree of food clustering
L = 35;                                                             % size of the lattice --> lattice has LxL sites   
N = 40;                                                             % number of worms in simulation  
time = 1000;   % choose smaller for lower gamma                     % number of times steps for which the simulation is executed 
numberSimulations = 1;                                            % number of repetitions of the simulation
numberFUs = 10*L*L;                                                 % number of distributed food units (FU)
initialWorms = wormDistribution(numberSimulations,N,L);             % initial distribution of worms on lattice
initialFUs = FUsDistribution(numberFUs,numberSimulations,gamma,L);  % initial distribution of FUs on lattice
speedOnFood = 1;                                                    % step length of worms on lattice site with food
speedOffFood = 2;                                                   % step length of worms on lattice site without food
%% Initialization for social worms
saveSocialWorms = zeros(N,2,time);                                  % stores position of each social worm for every time step 
saveFUsSocial = zeros(L,L,time);                                    % stores distribution of food units for every time step
allStepsSocial = zeros(N,time,numberSimulations);                   % stores number of steps each social worm has taken at every time step and every simulation repetition
FUsEatenSocial = zeros(N,time,numberSimulations);                   % stores number of FU each social worm has eaten at every time step and every simulation repetition
remainingFUsSocial = zeros(numberSimulations,time);                 % stores the number of remaining food units on the lattice for every time step and every repetition of the simulation
time90percentEatenSocial = zeros(numberSimulations,1);              % stores the time when 90% of the food units have been eaten for every repetition of the simulation
%% Script for social foraging

for loop = 1:numberSimulations

    % get intitial position of worms and food for the respective simulation
    % repetition
    socialWorms = initialWorms(:,:,loop);
    FUsSocial = initialFUs(:,:,loop);

    for t = 1:time
        
        % Step 1: Compute the eaten FUs at the current positions of the
        % worms
        [FUsUpdate,FUsEatenSocial(:,t,loop)] = computeFUsUpdate(FUsSocial,socialWorms);
        FUsSocial = FUsSocial + FUsUpdate;
       
        % Step 2: Determine motion update of the worms and save individually taken
        % steps
        [motionUpdate,allStepsSocial(:,t,loop)] = computeMotionUpdateSocial(speedOnFood,speedOffFood,socialWorms,FUsSocial,N,L);

        % Step 3: Update the position of the worms
        socialWorms = socialWorms + motionUpdate;
        socialWorms(socialWorms > L) = socialWorms(socialWorms > L) - L;        % consider PBCs 
        socialWorms(socialWorms < 1) = socialWorms(socialWorms < 1) + L;        % consider PBCs

        % Step 4: Save worm and FUs distribution
        saveSocialWorms(:,:,t) = socialWorms;
        saveFUsSocial(:,:,t) = FUsSocial;
    end

    % Calculate remaining FUs and time when 90% of them have been eaten
    remainingFUsSocial(loop,:) = reshape(sum(sum(saveFUsSocial)),[1,time]);
    eaten90percent = find(remainingFUsSocial(loop,:) < round(sum(sum(initialFUs)) * 0.1));
    if isempty(eaten90percent)
        time90percentEatenSocial(loop) = NaN;
        fprintf('Not all food units are eaten.\nRepeat simulation with increased time\n')
        return;
    else
        time90percentEatenSocial(loop) = eaten90percent(1);
    end
end

%% Initialization for solitary worms
saveSolitaryWorms = zeros(N,2,time);                                % stores position of each solitary worm for every time step 
saveFUsSolitary = zeros(L,L,time);                                  % stores distribution of food units for every time 
allStepsSolitary = zeros(N,time,numberSimulations);                 % stores number of steps each solitary worm has taken at every time step of all simulations
FUsEatenSolitary = zeros(N,time,numberSimulations);                 % stores number of FUs each solitary worm has eaten at every time step of all simulations 
remainingFUsSolitary = zeros(numberSimulations,time);               % stores number of remaining food units on the lattice at every time step of all simulations
time90percentEatenSolitary = zeros(numberSimulations,1);            % stores time when 90% of the food units have been eaten for each repetition of the simulations
%% Script for solitary worms
for loop2 = 1:numberSimulations

    solitaryWorms = initialWorms(:,:,loop2);
    FUsSolitary = initialFUs(:,:,loop2);

    for l = 1:time
        
        %Step 1: Compute the eaten FUs at the current positions of the
        %worms
        [FUsUpdate,FUsEatenSolitary(:,l,loop2)] = computeFUsUpdate(FUsSolitary,solitaryWorms);
        FUsSolitary = FUsSolitary + FUsUpdate;

        %Step 2: Determine motion update of the worms and save the taken
        %steps
        [motionUpdate,allStepsSolitary(:,l,loop2)] = computeMotionUpdateSolitary(speedOnFood,speedOffFood,solitaryWorms,FUsSolitary,N,L);

        %Step 3: Update the position of the worms
        solitaryWorms = solitaryWorms + motionUpdate;
        solitaryWorms(solitaryWorms > L) = solitaryWorms(solitaryWorms > L) - L;        % consider PBCs
        solitaryWorms(solitaryWorms < 1) = solitaryWorms(solitaryWorms < 1) + L;        % consider PBCs

        %Step 4: Save worms and FU distribution
        saveSolitaryWorms(:,:,l) = solitaryWorms;
        saveFUsSolitary(:,:,l) = FUsSolitary;
    end

    % Calculate remaining FUs and time when 90% of them have been eaten
    remainingFUsSolitary(loop2,:) = reshape(sum(sum(saveFUsSolitary)),[1,time]);
    eaten90percent = find(remainingFUsSolitary(loop2,:) < round(sum(sum(initialFUs)) * 0.1));
    if isempty(eaten90percent)
        time90percentEatenSolitary(loop2) = NaN;
        fprintf('Not all targets are eaten.\nRepeat simulation with increased time\n')
        return;
    else
        time90percentEatenSolitary(loop2) = eaten90percent(1);
    end
end

%% Create movie

f = figure;
set(f,'Units','pixels','Position',[0,0,1920,1080])
    
v = VideoWriter(['gamma' num2str(gamma) '_L35_N40'],'MPEG-4');
v.Quality = 100;
open(v);
for i = 1:time
    dataSocialWorms = saveSocialWorms(:,:,i);
    dataSolitaryWorms = saveSolitaryWorms(:,:,i);
    F = saveFUsSocial(:,:,i);
    F2 = saveFUsSolitary(:,:,i);
    
    subplot(1,2,1);
    mesh(F,'EdgeColor','none','FaceColor','interp');
    hold on;
    plot(dataSocialWorms(:,2),dataSocialWorms(:,1),'r.','MarkerSize',20);
    hold off;
    axis([1 L 1 L])
    pbaspect([1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    caxis([0 max(max(initialFUs))])
    view(0,-90)
    grid on;
    title1 = title('collective foraging');
    title1.FontSize = 34; 
    
    subplot(1,2,2);
    mesh(F2,'EdgeColor','none','FaceColor','interp');
    hold on;
    plot(dataSolitaryWorms(:,2),dataSolitaryWorms(:,1),'r.','MarkerSize',20);
    hold off;
    axis([1 L 1 L])
    pbaspect([1 1 1])
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    caxis([0 max(max(initialFUs))])
    view(0,-90)
    grid on;
    title2 = title('solitary foraging');
    title2.FontSize = 34;
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);