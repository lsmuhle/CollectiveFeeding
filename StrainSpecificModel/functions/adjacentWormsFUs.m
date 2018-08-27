%% compute number of worms and targets in direct and remote neighbourhood
function [directNeighbours,directFUs,remoteNeighbours,remoteFUs] = ...
    adjacentWormsFUs(L,indices,n,FUs,directNeighbourhood,remoteNeighbourhood)

% check availability of FUs in direct neighbourhood
sitesDistance1 = indices(n,:) + directNeighbourhood;
sitesDistance1(sitesDistance1 > L) = sitesDistance1(sitesDistance1 > L) - L;    % employ PBCs
sitesDistance1(sitesDistance1 < 1) = sitesDistance1(sitesDistance1 < 1) + L;    % employ PBCs
directFUs = diag(FUs(sitesDistance1(:,1),sitesDistance1(:,2))) > 0;             % create logical array containing whether adjacent sites have food or not

% check existence of neighbours in direct neighbourhood
directNeighbours = false(size(sitesDistance1,1),1);
for ii = 1:size(sitesDistance1,1)
    existent = find(indices(:,1) == sitesDistance1(ii,1) &...
        indices(:,2) == sitesDistance1(ii,2));
    if isempty(existent) == 0
        directNeighbours(ii) = true;
    end
end

% check availability of FUs in remote neighbourhood
sitesDistance2 = indices(n,:) + remoteNeighbourhood;
sitesDistance2(sitesDistance2 > L) = sitesDistance2(sitesDistance2 > L) - L;    % employ PBCs
sitesDistance2(sitesDistance2 < 1) = sitesDistance2(sitesDistance2 < 1) + L;    % employ PBcs
remoteFUs = diag(FUs(sitesDistance2(:,1),sitesDistance2(:,2))) > 0;             % create logical array containing whether sites in remote neighbourhood have food or not

% check existence of neighbours in remote neighbourhood
remoteNeighbours = false(size(sitesDistance2,1),1);
for ii = 1:size(sitesDistance2,1)
    existent = find(indices(:,1) == sitesDistance2(ii,1) &...
        indices(:,2) == sitesDistance2(ii,2));
    if isempty(existent) == 0
        remoteNeighbours(ii) = true;
    end
end
    
end