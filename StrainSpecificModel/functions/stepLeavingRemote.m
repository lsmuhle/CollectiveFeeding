%% step to remote neighbourhood to leave food
function [motionUpdate,indicesInput] = stepLeavingRemote(L,indicesInput,n,remoteFUs,remoteNeighbourhood)

% compute steps to sites in remote neighbourhood without food
possibleSteps = remoteNeighbourhood(remoteFUs == false,:);

% if there is no site in remote neighbourhood without food, worm remains on 
% its position; if there are sites without food in remote neighbourhood, worm
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


    