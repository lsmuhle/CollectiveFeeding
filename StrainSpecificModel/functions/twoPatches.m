%% compute food distribution for two food patches
function FUs = twoPatches(numberFUs,L)

% initialize matrix for FUs representing the simulation surface and
% define radius of each food patch
FUs = zeros(L,L);
radius = 4;

% vectors containing indices of the centres of both food patches
rowMiddlePoint = [9 27];
columnMiddlePoint = [27 9];

% compute all lattice sites within both food patches
for n = 1:2   % repeat loop for each food patch
    for ii = 1:L        % goes through all rows
        for jj = 1:L          % goes through all columns
            if sqrt((ii - rowMiddlePoint(n))^2 + (jj - columnMiddlePoint(n))^2) <= radius
                FUs(ii,jj) = 1;
            end
        end
    end
end

%calculate FUs per site and distribute them in patches
FUsPerSite = round(numberFUs/sum(sum(FUs)));
FUs = FUs.*FUsPerSite;
end