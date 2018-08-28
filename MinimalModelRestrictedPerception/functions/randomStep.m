%% compute random step to either direct or remote neighbourhood
function [motionUpdate,indicesInput] = randomStep(indicesInput,n,speed,directNeighbourhood,remoteNeighbourhood,L)

%calculate all possible step updates depending on the step length (to
%direct or remote neighbourhood)
if speed == 1
    possibleSteps = directNeighbourhood;
else
   possibleSteps = remoteNeighbourhood;    
end

%choose one of the possible steps and check if site is not occupied by
%another worm
choice = randi(size(possibleSteps,1),1);
motionUpdate = possibleSteps(choice,:);
remainingPossibilities = possibleSteps;
remainingPossibilities(choice,:) = [];

% check if lattice site reached with chosen step is unoccupied, if not
% an alternative motion update is computed
[motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,...
        indicesInput,remainingPossibilities,L);
end
