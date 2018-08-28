%% Function to compute motion updates of solitary worms
function [motionUpdate,stepTaken] = computeMotionUpdateSolitary(speedOnFood,speedOffFood,solitaryWorms,FUs,N,L)

% create matrix containing motion updates of all worms
motionUpdate = zeros(N,2);

% define index updates to lattice sites in direct and remote neighbourhood
directNeighbourhood = [-1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1];
remoteNeighbourhood = [-2 -2; -2 -1; -2 0; -2 1; -2 2; -1 2; 0 2; 1 2; 2 2;...
       2 1; 2 0; 2 -1; 2 -2; 1 -2; 0 -2; -1 -2];

% mix update indices for random order of updating to avoid bias
mixingVector = randperm(size(solitaryWorms,1));
indicesInput = solitaryWorms(mixingVector(:),:);
indicesBeforeUpdate = indicesInput;

% create a vector containing length of the steps worms have taken
stepTaken = zeros(N,1);

% consecutively compute motion updates for all worms
for n = 1:N
    
    % determine if worm is on food; if so, the worm moves with step length
    % 1, otherwise with step length 2
    if FUs(indicesBeforeUpdate(n,1),indicesBeforeUpdate(n,2)) == 0
        speed = speedOffFood;
    else
        speed = speedOnFood;
    end 
    
    % compute random step to either direct or remote neighbourhood depending
    % on food availability
    [motionUpdate(n,:),indicesInput] = randomStep(indicesInput,n,speed,directNeighbourhood,remoteNeighbourhood,L);    
    
    % compute length of the taken step
    stepTaken(n) = max(abs(motionUpdate(n,:)));
        
end

% recreate original order of matrix with motion updates 
matrixReorder = [mixingVector' motionUpdate stepTaken];
orderedMatrix = sortrows(matrixReorder);
motionUpdate = orderedMatrix(:,2:3);
stepTaken = orderedMatrix(:,4);

end