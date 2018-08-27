%% compute random step to either direct or remote neighbourhood
function [motionUpdate,indicesInput] = randomStep(L,indicesInput,n,speed,directNeighbourhood,remoteNeighbourhood)

% calculate all possible steps depending on the speed of worm (to
% direct or remote neighbourhood)
if speed == 1
    possibleSteps = directNeighbourhood;
else
   possibleSteps = remoteNeighbourhood;    
end

% choose one of the possible steps randomly and check if site is occupied by
% another worm
choice = randi(size(possibleSteps,1),1);
motionUpdate = possibleSteps(choice,:);
remainingPossibilities = possibleSteps;
remainingPossibilities(choice,:) = [];
[motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,...
        indicesInput,remainingPossibilities,L);
end
