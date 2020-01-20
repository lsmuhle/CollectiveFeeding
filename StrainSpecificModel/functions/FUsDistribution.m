%% compute food distributions for all repetitions of the simulations
function foodDistributions = FUsDistribution(numberFU,numberSimulations,gamma,L)

% create matrix to store the initial food distributions for all the
% repetions of the simulation
foodDistributions = zeros(L,L,numberSimulations);
for ii = 1:numberSimulations
    
    % compute food distribution for one simulation 
    food = zeros(L);

    % matrix with indices of FU
    indexFU = zeros(numberFU,2);
    indexFU(1,:) = randi(L,1,2);
    for n = 2:numberFU

        % compute distance d where new FU should appear
        r = rand(1);
        if gamma == 0
            indexFU(n,:) = randi(L,1,2);
        else
            if r < (1/(L/sqrt(2)))^gamma
                d = 1 + ((L/sqrt(2))-1) * rand(1);
            else 
                d = r^(-1/gamma);
            end

            % choose existing FU as basis
            basis = randi(n-1);

            % compute direction of update
            direction = 2*pi*rand(1);
            update(1,1) = round(-(d * sin(direction)));
            update(1,2) = round(d * cos(direction));
            new_position = indexFU(basis,:) + update;
            new_position(new_position > L) = new_position(new_position > L) - L;   % consider periodic boundary conditions (PBC)
            new_position(new_position < 1) = new_position(new_position < 1) + L;   % consider PBC
            indexFU(n,:) = new_position;
        end
        % update target matrix
        food(indexFU(n,1),indexFU(n,2)) = food(indexFU(n,1),indexFU(n,2)) + 1;
    end
    food(indexFU(1,1),indexFU(1,2)) = food(indexFU(1,1),indexFU(1,2)) + 1;
    
    % save target distribution
    foodDistributions(:,:,ii) = food;
end
end
