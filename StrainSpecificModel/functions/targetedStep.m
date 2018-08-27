%% compute targeted step of social worms to direct neighbourhood
function [motionUpdate,indicesInput] = targetedStep(L,indicesInput,n,FUsNpr1,directNeighbours,directNeighbourhood)


% compute steps to sites with direct neighbours
stepsToNeighbours = directNeighbourhood(directNeighbours,:);

% compute direct neighbourhoods of direct neighbours
stepsToNeighbourhoodNeighbours = zeros(size(stepsToNeighbours,1)*8,2);
for ii = 1:size(stepsToNeighbours,1)
    stepsToNeighbourhoodNeighbours((ii-1)*8+1:ii*8,:) = stepsToNeighbours(ii,:) + directNeighbourhood;
end

% eliminate all steps that do not lead to direct neighbourhood and delete
% redundant entries
WrongDistance = abs(stepsToNeighbourhoodNeighbours(:,1)) == 2 | ...
    abs(stepsToNeighbourhoodNeighbours(:,2)) == 2;
stepsToNeighbourhoodNeighbours(WrongDistance,:) = [];
WrongDistanceZero = stepsToNeighbourhoodNeighbours(:,1) == 0 & stepsToNeighbourhoodNeighbours(:,2) == 0;
stepsToNeighbourhoodNeighbours(WrongDistanceZero,:) = [];
stepsToNeighbourhoodNeighbours = unique(stepsToNeighbourhoodNeighbours,'rows');

% compute food availability on chosen sites next to direct neighbours and
% only choose sites with food to go to
sitesNextToNeighbours = indicesInput(n,:) + stepsToNeighbourhoodNeighbours;
sitesNextToNeighbours(sitesNextToNeighbours > L) = sitesNextToNeighbours(sitesNextToNeighbours > L) - L;        % employ PBCs
sitesNextToNeighbours(sitesNextToNeighbours < 1) = sitesNextToNeighbours(sitesNextToNeighbours < 1) + L;        % employ PBCs
FUsAvailability = diag(FUsNpr1(sitesNextToNeighbours(:,1),...
sitesNextToNeighbours(:,2))) > 0;
allowedStepsNextToNeighbour = stepsToNeighbourhoodNeighbours(FUsAvailability,:);

% see if there are sites to go to or not, randomly choose one and determine fitting
% update
if isempty(allowedStepsNextToNeighbour)                              % if there is no available site with food, worm remains at its position
    motionUpdate = [0 0];
else
    choice = randi(size(allowedStepsNextToNeighbour,1),1);           % if there are sites with food it can go to, it chooses one possible update and then check if site is unoccupied
    motionUpdate = allowedStepsNextToNeighbour(choice,:);
    remainingPossibilities = allowedStepsNextToNeighbour;
    remainingPossibilities(choice,:) = [];
    [motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,...
    indicesInput,remainingPossibilities,L);
end
end