%% computation of the squares of the lattice where food units are eaten 
function [FUsUpdate,FUsEatenPerWorm] = computeFUsUpdate(FUs,worms)

%compute matrix that gives information at which positions one food unit is
%eaten
FUsOccupation = zeros(size(FUs));
FUsOccupation(FUs > 0) = 1;

wormOccupation = zeros(size(FUs));
wormOccupation(sub2ind(size(FUs), worms(:, 1), worms(:, 2))) = 1;

FUsUpdate = zeros(size(FUs));

FUsUpdate((FUsOccupation.*wormOccupation) > 0) = -1;

%compute number of food units each worm eats
FUsEatenPerWorm = diag(FUs(worms(:,1),worms(:,2))) > 0;

end
