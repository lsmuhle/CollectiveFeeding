%% Function to compute motion updates of social worms
function [motionUpdate,stepTaken] = computeMotionUpdateSocial(speedOnFood,speedOffFood,socialWorms,FUs,N,L)

% create matrix containing motion updates of all worms
motionUpdate = zeros(N,2);

% define index updates to lattice sites in direct and remote neighbourhood
directNeighbourhood = [-1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1];
remoteNeighbourhood = [-2 -2; -2 -1; -2 0; -2 1; -2 2; -1 2; 0 2; 1 2; 2 2;...
       2 1; 2 0; 2 -1; 2 -2; 1 -2; 0 -2; -1 -2];

% mix update indices for random order of updating to avoid bias
mixingVector = randperm(N);
indicesInput = socialWorms(mixingVector,:);
indicesBeforeUpdate = indicesInput;

% create a vector containing length of the steps worms have taken
stepTaken = zeros(N,1);

% consecutively compute motion updates for all worms
for n = 1:N
    
    % compute number of FUs in direct neighbourhood of worm and on its
    % current position and determine if worm has direct neighbours
    foodAvailability = computeSurroundingFUs(n,indicesBeforeUpdate,FUs,directNeighbourhood,L);
    directNeighbours = computeSurroundingWorms(n,indicesBeforeUpdate,directNeighbourhood,L);
    
    % compute random step to remote neighbourhood if worm is not on food 
    % and has no food in its direct neighbourhood
    if sum(foodAvailability) == 0 
        [motionUpdate(n,:),indicesInput] = randomStep(indicesInput,n,speedOffFood,directNeighbourhood,remoteNeighbourhood,L);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
    
    % compute random step to direct neighbourhood if worm is on food or has food
    % in its direct neighbourhood, but no direct neighbours
    elseif sum(directNeighbours) == 0
        [motionUpdate(n,:),indicesInput] = randomStep(indicesInput,n,speedOnFood,directNeighbourhood,remoteNeighbourhood,L);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
    
    % compute targeted step if worm is on food/has food in its direct
    % neighbourhood and has direct neighbours
    else
        [motionUpdate(n,:),indicesInput] = targetedStep(n,directNeighbours,indicesInput,directNeighbourhood,L);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
    end
end

% recreate original order of matrix with motion updates 
matrixReorder = [mixingVector' motionUpdate stepTaken];
orderedMatrix = sortrows(matrixReorder);
motionUpdate = orderedMatrix(:,2:3);
stepTaken = orderedMatrix(:,4);

end


