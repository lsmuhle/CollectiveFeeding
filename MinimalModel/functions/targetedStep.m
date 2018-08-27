%% compute targeted step of social worms to direct neighbourhood
function [motionUpdate,indicesInput] = targetedStep(n,directNeighbours,indicesInput,directNeighbourhood,L)

% compute updates to squares with neighbours
allUpdates = directNeighbourhood;
updatesToNeighbours = allUpdates(directNeighbours,:);

% calculate updates to fields next to neighbours that can be reached with 1
% step
updatesNextNeighbour = zeros(size(updatesToNeighbours,1)*8,2);
for ii = 1:size(updatesToNeighbours,1)
    updatesNextNeighbour((ii-1)*8+1:ii*8,:) = updatesToNeighbours(ii,:) + allUpdates;
end

% eliminate all steps longer/shorter than one step and delete same
% entries
wrongDistance = abs(updatesNextNeighbour(:,1)) == 2 | ...                               % eliminate updates that are longer than one step
    abs(updatesNextNeighbour(:,2)) == 2;
updatesNextNeighbour(wrongDistance,:) = [];
WrongDistanceZero = updatesNextNeighbour(:,1) == 0 & updatesNextNeighbour(:,2) == 0;    % eliminate updates with which the worm would remain at its position
updatesNextNeighbour(WrongDistanceZero,:) = [];
updatesNextNeighbour = unique(updatesNextNeighbour,'rows');                             % eliminate duplicates of updates

% choose one of the possible updates and check if site is available
choice = randi(size(updatesNextNeighbour,1),1);
motionUpdate = updatesNextNeighbour(choice,:);
remainingPossibilities = updatesNextNeighbour;
remainingPossibilities(choice,:) = [];
[motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,...
    indicesInput,remainingPossibilities,L);

end