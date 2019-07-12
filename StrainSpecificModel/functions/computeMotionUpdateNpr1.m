%% Computation of motions updates of npr-1 worms 
function [motionUpdate,stepTaken] = computeMotionUpdateNpr1(N,L,FUsNpr1,...
    npr1Worms,leavingRateNpr1,speedOnFoodNpr1,speedOffFoodNpr1)

%create matrix containing motion updates of all worms
motionUpdate = zeros(N,2);

% define index updates to lattice sites in direct and remote neighbourhood
directNeighbourhood = [-1 -1; -1 0; -1 1; 0 1; 1 1; 1 0; 1 -1; 0 -1];
remoteNeighbourhood = [-2 -2; -2 -1; -2 0; -2 1; -2 2; -1 2; 0 2; 1 2; 2 2;...
       2 1; 2 0; 2 -1; 2 -2; 1 -2; 0 -2; -1 -2];

% mix update indices for random order of updating to avoid bias
mixingVector = randperm(size(npr1Worms,1));
indicesInput = npr1Worms(mixingVector,:);
indicesBeforeUpdate = indicesInput;

% create a vector containing length of the steps worms have taken
stepTaken = zeros(N,1);

% consecutively compute motion updates for all worms
for n = 1:N 
    
    % calculate direct and remote neighbour worms and FUs in direct and remote neighbourhood 
    [directNeighbours,directFUs,remoteNeighbours,remoteFUs]...
        = adjacentWormsFUs(L,indicesBeforeUpdate,n,FUsNpr1,directNeighbourhood,remoteNeighbourhood);
    
    % worm is not on food and performs random step to remote neighbourhood
    if FUsNpr1(indicesBeforeUpdate(n,1),indicesBeforeUpdate(n,2)) <= 0
        [motionUpdate(n,:),indicesInput] = randomStep(L,indicesInput,n,speedOffFoodNpr1,...
            directNeighbourhood,remoteNeighbourhood);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
        
    % worm is on food, has direct neighbour(s) and everywhere in direct
    % neighbourhood food can be found --> performs targeted step to direct
    % neighbourhood
    elseif sum(directNeighbours) > 0 && sum(directFUs) == length(directFUs)
        [motionUpdate(n,:),indicesInput] = targetedStep(L,indicesInput,n,FUsNpr1,...
            directNeighbours,directNeighbourhood);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
    
    % worm has direct neighbour(s), but not everywhere in direct neighbourhood food,
    % decision via food-leaving rate
    elseif sum(directNeighbours) > 0 && sum(directFUs) ~= length(directFUs)
        
        random = rand(1);                                                 
        if random > leavingRateNpr1
            [motionUpdate(n,:),indicesInput] = targetedStep(L,indicesInput,n,FUsNpr1,...
            directNeighbours,directNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));
        else
            % worm has direct neighbour(s) and, thus, moves to lattice
            % site without food in direct neighbourhood
            [motionUpdate(n,:),indicesInput] = stepLeavingDirect(L,indicesInput,n,...
                directFUs,directNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));
        end      
        
    % worm is on food, only has neighbour(s) in remote neighbourhood and there is food
    % everywhere in remote neighbourhood
    elseif sum(remoteNeighbours) > 0 && sum(remoteFUs) == length(remoteFUs)
        [motionUpdate(n,:),indicesInput] = targetedStepRemote(L,indicesInput,n,FUsNpr1,...
            remoteNeighbours,directNeighbourhood,remoteNeighbourhood);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
    
    % worm is on food, only has remote neighbour(s) and food is not
    % available everywhere in remote neighbourhood
    elseif sum(remoteNeighbours) > 0 && sum(remoteFUs) ~= length(remoteFUs)
        
        random = rand(1);
        if random > leavingRateNpr1
            [motionUpdate(n,:),indicesInput] = targetedStepRemote(L,indicesInput,n,...
                FUsNpr1,remoteNeighbours,directNeighbourhood,remoteNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));
        else
           [motionUpdate(n,:),indicesInput] = stepLeavingRemote(L,indicesInput,n,...
               remoteFUs,remoteNeighbourhood); 
            stepTaken(n) = max(abs(motionUpdate(n,:))); 
        end
        
    % worm is on food, has no neighbours and there is food on every site in remote neighbourhood   
    elseif sum(remoteFUs) == length(remoteFUs)
        [motionUpdate(n,:),indicesInput] = randomStep(L,indicesInput,n,speedOnFoodNpr1,...
            directNeighbourhood,remoteNeighbourhood);
        stepTaken(n) = max(abs(motionUpdate(n,:)));
        
    % worm is on food, has no neighbours and food cannot be found on every 
    % site in remote neighbourhood --> worms decides according to its food 
    % leaving rate whether to stay on food or leave it
    else
        random = rand(1);
        if random > leavingRateNpr1
            [motionUpdate(n,:),indicesInput] = stepRemainingRemote(L,indicesInput,...
                n,remoteFUs,remoteNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));
        else        
            [motionUpdate(n,:),indicesInput] = stepLeavingRemote(L,indicesInput,n,...
                remoteFUs,remoteNeighbourhood);
            stepTaken(n) = max(abs(motionUpdate(n,:)));   
        end
    end
end

%recreate original order for motion update 
matrixReorder = [mixingVector' motionUpdate stepTaken];
orderedMatrix = sortrows(matrixReorder);
motionUpdate = orderedMatrix(:,2:3);
stepTaken = orderedMatrix(:,4);

end


