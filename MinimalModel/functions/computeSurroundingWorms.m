%% determine if there are neighbour worms in the direct neighbourhood of the worm 
function directNeighbours = computeSurroundingWorms(n,indicesBeforeUpdate,directNeighbours,L)

% compute the indices of the squares in the direct neighbourhood of the
% worm
index = indicesBeforeUpdate(n,:);
indicesSurrounding = index + directNeighbours;
indicesSurrounding(indicesSurrounding > L) = indicesSurrounding(indicesSurrounding > L) - L;
indicesSurrounding(indicesSurrounding < 1) = indicesSurrounding(indicesSurrounding < 1) + L;

%create logical vector containing information if there is a worm on
%adjacent square or not
directNeighbours = zeros(8,1);
for m = 1:8
    neighbour = find(indicesBeforeUpdate(:,1) == indicesSurrounding(m,1) & indicesBeforeUpdate(:,2) == indicesSurrounding(m,2));
    directNeighbours(m) = isempty(neighbour) == 0;
end
%create logical array for surrounding worms
directNeighbours = logical(directNeighbours);
end
