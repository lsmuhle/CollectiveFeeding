%% compute targeted step of social worms to remote neighbourhood
function [motionUpdate,indicesInput] = targetedStepRemote(L,indicesInput,n,FUsNpr1,remoteNeighbours,directNeighbourhood,remoteNeighbourhood)

% choose all motion updates to sites with remote neighbours
stepsToNeighbours = remoteNeighbourhood(remoteNeighbours,:);

% compute direct neighbourhood of remote neighbours
stepsToNeighbourhoodNeighbours = zeros(size(stepsToNeighbours,1)*8,2);
for ii = 1:size(stepsToNeighbours,1)
    stepsToNeighbourhoodNeighbours((ii-1)*8+1:ii*8,:) = stepsToNeighbours(ii,:) + directNeighbourhood;
end

% eliminate all steps that do not lead to remote neighbourhood and delete
% redundant entries
WrongDistance = abs(stepsToNeighbourhoodNeighbours(:,1)) == 1 & ...
    abs(stepsToNeighbourhoodNeighbours(:,2)) == 1;
stepsToNeighbourhoodNeighbours(WrongDistance,:) = [];
WrongDistanceZero = stepsToNeighbourhoodNeighbours(:,1) == 0 & stepsToNeighbourhoodNeighbours(:,2) == 0;
stepsToNeighbourhoodNeighbours(WrongDistanceZero,:) = [];
wrongDistance2Far = abs(stepsToNeighbourhoodNeighbours(:,1)) == 3 | abs(stepsToNeighbourhoodNeighbours(:,2)) == 3;
stepsToNeighbourhoodNeighbours(wrongDistance2Far,:) = [];
wrongDistance2Close = sum(abs(stepsToNeighbourhoodNeighbours),2) == 1;
stepsToNeighbourhoodNeighbours(wrongDistance2Close,:) = []; 
stepsToNeighbourhoodNeighbours = unique(stepsToNeighbourhoodNeighbours,'rows');

% compute food availability on chosen sites next to remote neighbours and
% only choose sites with food to go to
sitesNextToNeighbours = indicesInput(n,:) + stepsToNeighbourhoodNeighbours;
sitesNextToNeighbours(sitesNextToNeighbours > L) = sitesNextToNeighbours(sitesNextToNeighbours > L) - L;        % employ PBCs
sitesNextToNeighbours(sitesNextToNeighbours < 1) = sitesNextToNeighbours(sitesNextToNeighbours < 1) + L;        % employ PBCs
foodAvailability = diag(FUsNpr1(sitesNextToNeighbours(:,1),...
sitesNextToNeighbours(:,2))) > 0;
allowedStepsNextToNeighbour = stepsToNeighbourhoodNeighbours(foodAvailability,:);

% see if there are sites worm is allowed to go to or not, determine fitting
% update and check if chosen site is unoccupied
if isempty(allowedStepsNextToNeighbour)
    motionUpdate = [0 0];
else
    choice = randi(size(allowedStepsNextToNeighbour,1),1);
    motionUpdate = allowedStepsNextToNeighbour(choice,:);
    remainingPossibilities = allowedStepsNextToNeighbour;
    remainingPossibilities(choice,:) = [];
    [motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,indicesInput,...
        remainingPossibilities,L);
end
end