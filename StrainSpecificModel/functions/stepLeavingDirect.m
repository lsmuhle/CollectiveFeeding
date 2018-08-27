%% step to direct neighbourhood to leave food
function [motionUpdate,indicesInput] = stepLeavingDirect(L,indicesInput,n,directFUs,directNeighbourhood)

% compute steps to sites without food in direct
% neighbourhood
possibleSteps = directNeighbourhood(directFUs == false,:);  

% if there is no site in direct neighbourhood without food, worm remains on 
% its position; if there are sites without food in direct neighbourhood, worm
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