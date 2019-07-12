%% compute motion updates of N2 worms
function [motionUpdate,stepTaken] = computeMotionUpdateN2(N,L,FUsN2,...
    N2Worms,leavingRateN2,speedOnFoodN2,speedOffFoodN2)

%create matrix containing motion updates of all worms
motionUpdate = zeros(N,2);

% define index updates to lattice sites in direct and remote neighbourhood
directNeighbourhood = [-1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1];
remoteNeighbourhood = [-2 -2; -2 -1; -2 0; -2 1; -2 2; -1 2; 0 2; 1 2; 2 2;...
       2 1; 2 0; 2 -1; 2 -2; 1 -2; 0 -2; -1 -2];

% mix update indices for random order of updating to avoid bias
mixingVector = randperm(size(N2Worms,1));
indicesInput = N2Worms(mixingVector(:),:);
indicesBeforeUpdate = indicesInput;

% create a vector containing length of the steps worms have taken
stepTaken = zeros(N,1);


for n = 1:N 
    
    % calculate direct and remote neighbour worms and FUs in direct and remote neighbourhood  
    [~,directFUs,~,~] = adjacentWormsFUs(L,indicesBeforeUpdate,n,FUsN2,...
        directNeighbourhood,remoteNeighbourhood);
     
    % worm is not on food and performs random step to remote neighbourhood
    if FUsN2(indicesBeforeUpdate(n,1),indicesBeforeUpdate(n,2)) <= 0
        [motionUpdate(n,:),indicesInput] = randomStep(L,indicesInput,n,speedOffFoodN2,...
            directNeighbourhood,remoteNeighbourhood);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
        
    % worm is on food and food is available on every site in the direct neighbourhood
    % --> performs random step to direct neighbourhood     
    elseif sum(directFUs) == size(directFUs,1) 
        [motionUpdate(n,:),indicesInput] = randomStep(L,indicesInput,n,speedOnFoodN2,...
            directNeighbourhood,remoteNeighbourhood);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
    
    % worm is on food, but food is not available on every site in direct neighbourhood --> 
    % worm decides according to its food-leaving rate whether to
    % move to a site with or without food
    else
        random = rand(1);
        if random > leavingRateN2
            [motionUpdate(n,:),indicesInput] = stepRemainingDirect(L,indicesInput,n,...
                directFUs,directNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));
        else
            [motionUpdate(n,:),indicesInput] = stepLeavingDirect(L,indicesInput,n,...
                directFUs,directNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));
        end
    end
end

% recreate original order for motion update 
matrixReorder = [mixingVector' motionUpdate stepTaken];
orderedMatrix = sortrows(matrixReorder);
motionUpdate = orderedMatrix(:,2:3);
stepTaken = orderedMatrix(:,4);

end
