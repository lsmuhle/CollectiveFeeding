%% check if the square worm wants to go to is unoccupied and, if not, chose alternative motion update
function [motionUpdate,indicesInput] = checkOccupancy(motionUpdate,n,indicesInput,remainingPossibilities,L)

% check if lattice site reached with motion update is unoccupied
newPosition = indicesInput(n,:) + motionUpdate;
newPosition(newPosition > L) = newPosition(newPosition > L) - L;   % consider PBCs
newPosition(newPosition < 1) = newPosition(newPosition < 1) + L;   % consider PBCs

occupancy = find(indicesInput(:,1) == newPosition(1) & indicesInput(:,2) == newPosition(2));

% check if square is unoccupied or if worm should try to move to another square 

% site worm wants to go to is unoccupied
if isempty(occupancy)
    indicesInput(n,:) = newPosition;

% site worm wants to go to is occupied by another worm    
else
    % worm remains at its position if it is not allowed to do a different
    % step
    if isempty(remainingPossibilities)
        motionUpdate = [0 0];
        
    % worm is allowed to do an alternative step; check if it can reach an
    % unoccupied site with it
    else
        permutation = randperm(size(remainingPossibilities,1));                                          % choose one of the possible steps randomly
        for ii = 1:size(remainingPossibilities,1)                                                        % try all allowed steps until either an unoccupied site is found or there are no possible steps left 
            update = remainingPossibilities(permutation(ii),:);
            newPosition = indicesInput(n,:) + update;
            newPosition(newPosition > L) = newPosition(newPosition > L) - L;                             % consider PBCs
            newPosition(newPosition < 1) = newPosition(newPosition < 1) + L;                             % consider PBCs
            occupancy = find(indicesInput(:,1) == newPosition(1) & indicesInput(:,2) == newPosition(2)); % check occupancy of chosen site to go to
            if isempty(occupancy)
                motionUpdate = update;
                indicesInput(n,:) = newPosition;
                break;
            else
                motionUpdate = [0 0];
              
            end            
        end
    end
end
    
end