%% compute step to direct neighbourhood to remain on food
function [motionUpdate,indicesInput] = stepRemainingDirect(L,indicesInput,n,directFUs,directNeighbourhood)

% compute steps to sites with food in direct neighbourhood
possibleSteps = directNeighbourhood(directFUs,:);

% if there is no site in direct neighbourhood with food, worm remains on 
% its position; if there are sites with food in direct neighbourhood, worm
% randomly chooses one of them to move to and checks if it is unoccupied 
if isempty(possibleSteps)
    motionUpdate = [0 0];
else
    choice = randi(size(possibleSteps,1),1);
    motionUpdate = possibleSteps(choice,:);
    remainingPossibilities = possibleSteps;
    remainingPossibilities(choice,:) = [];
    [motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,indicesInput,...
        remainingPossibilities,L);
end


end