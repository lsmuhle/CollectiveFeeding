%% calculate initial positions of worms
function worms = circularWorms(N,L)

% define size and position of the circle containing initial positions of
% worms
% (rowMiddlePoint = 18,columnMiddlePoint = 18 for four patches; 
% rowMiddlePoint = 29 and columnMiddlePoint = 29 for one and two patch(es); radius 5)
radius = 5;
rowMiddlePoint = 29;
columnMiddlePoint = 29;

% calculate all lattice sites within circle
possibleSites = [];
for ii = 1:L    % goes through all rows
    for jj = 1:L    % goes through all columns
        if sqrt((ii - rowMiddlePoint)^2 + (jj - columnMiddlePoint)^2) <= radius
            possibleSites = vertcat(possibleSites,[ii jj]);
        end
    end
end

% choose N possible lattice sites randomly as starting points for worms
mixingVector = randperm(size(possibleSites,1));
mixedSites = sortrows([mixingVector' possibleSites]);
worms = mixedSites(1:N,2:3);
end
