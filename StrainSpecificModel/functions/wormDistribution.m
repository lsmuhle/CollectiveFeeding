%% compute the initial positions of worms on the lattice
function initialWorms = wormDistribution(numberSimulations,N,L)

%distribute worms new for each repetition of the simulation and ensure that
%2 worms cannot be on the same square (volume exclusion)

initialWorms = zeros(N,2,numberSimulations);
for ii = 1:numberSimulations
    worms = zeros(N,2);
    worms(1,:) = randi(L,1,2);
    for n = 2:N
        %initialize position so it is not empty
        occupancy = 1;
        %choose a position for a new worm on a lattice site without an
        %already existing worm
        while isempty(occupancy) == 0
            worms(n,:) = randi(L,1,2);      % randomly choose a position on the lattice for the new worm
            occupancy = find(worms(1:n-1,1) == worms(n,1) & worms(1:n-1,2) == worms(n,2));      % check if there already is a worm at the chosen position
        end
    end
    
    initialWorms(:,:,ii) = worms;
end
end
