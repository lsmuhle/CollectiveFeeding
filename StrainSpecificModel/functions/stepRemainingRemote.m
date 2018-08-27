%% compute step to remote neighbourhood to remain on food
function [motionUpdate,indicesInput] = stepRemainingRemote(L,indicesInput,n,remoteFUs,remoteNeighbourhood)

% compute steps to sites in remote neighbourhood with food
possibleSteps = remoteNeighbourhood(remoteFUs,:);

% if there is no site in remote neighbourhood with food, worm remains on 
% its position; if there are sites with food in remote neighbourhood, worm
% randomly chooses one of them to move to and checks if it is unoccupied 
if isempty(possibleSteps)
    motionUpdate = [0 0];
else
    choice = randi(size(possibleSteps,1),1);
    motionUpdate = possibleSteps(choice,:);
    remainingPossibilities = possibleSteps;
    remainingPossibilities(choice,:) = [];
    [motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,...
    indicesInput,remainingPossibilities,L);
end
end
    
    

     

