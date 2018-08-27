%% compute the number of targets on the squares in the direct neighbourhood of the worm and its current position
function surroundingFUs = computeSurroundingFUs(n,indicesBeforeUpdate,FUs,directNeighbourhood,L)

%compute indices of matrix fields in the direct neighbourhood of worm and
%on its current positions to find out how many food units there are
surrounding = cat(1,directNeighbourhood,[0 0]);
indicesSurrounding = indicesBeforeUpdate(n,:) + surrounding;

%employ periodic boundary conditions to the indices
indicesSurrounding(indicesSurrounding > L) = indicesSurrounding(indicesSurrounding > L) - L;
indicesSurrounding(indicesSurrounding < 1) = indicesSurrounding(indicesSurrounding < 1) + L;

%compute targets at position
surroundingFUs = diag(FUs(indicesSurrounding(:,1),indicesSurrounding(:,2))) > 0;
