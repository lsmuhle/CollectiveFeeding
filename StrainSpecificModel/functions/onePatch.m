%% compute food distribution for one food patch
function FUs = onePatch(numberFUs,L)

% initialize matrix for FUs representing the simulation surface
FUs = zeros(L,L);

% determine radius and position of food patch (r = 6; row/column = 18)
radius = 6;
rowMiddlePoint = 18;
columnMiddlePoint = 18;

% determine all lattice sites within radius of food patch
for ii = 1:L     % goes through all rows
    for jj = 1:L     % goes through all colums
        if sqrt((ii - rowMiddlePoint)^2 + (jj - columnMiddlePoint)^2) <= radius
            FUs(ii,jj) = 1;
        end
    end
end

%compute FUs per site of patch and distribute them in patch
FUsPerSite = round(numberFUs/sum(sum(FUs)));
FUs = FUs.*FUsPerSite;
end

