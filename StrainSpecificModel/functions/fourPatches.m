%% compute food distribution for four food patches
function FUs = fourPatches(numberFUs,L)

% initialize matrix for FUs representing the simulation surface and
% define radius of each food patch
FUs = zeros(L,L);
radius = 3;

% vectors containing indices of the centres of all food patches
rowMiddlePoint = [9 9 27 27];
columnMiddlePoint = [9 27 27 9];

% compute all lattice sites within all food patches
for n = 1:4
    for ii = 1:L        % goes through all rows
        for jj = 1:L        % goes through all columns
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
