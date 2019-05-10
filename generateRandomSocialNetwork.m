function socialNetwork = generateRandomSocialNetwork(populationSize, socialNetworkSizeData)
% Creates connections between people within the population

%===============================%
%========= TO_DO LIST ==========%
%===============================%
% Bugs to fix:
    % Does not properly adhere to person's social network size
        % If personA has reached the assigned number of aquaintances
        % and personB is assigned personA as a friend, function does not
        % take into consideration that personA is already capped
        % results in personA having max+1 aquaintances
    % One way assignment
        % personA assigned to personB is the same as
        % personB assigned to personA
        % function does not account for this 

    
%===== Initialise variable to hold data
% 1 row per person
% 1 column per friend of person
socialNetwork = zeros(populationSize, max(socialNetworkSizeData));


%===== Assign Aquaintances
for person=1:populationSize
    % how many to assign
    friendCount = socialNetworkSizeData(person);
    
    for i=1:friendCount
        % randomly pick from population
        friend = randi(populationSize);
        
        % make sure friend is not themself
        % friend is not already in person's social network
        % person is not in friend's person's social network
        while (friend == person ...
            || ismember(friend, socialNetwork(person,:)) == 1 ...
            || ismember(person, socialNetwork(friend,:)) == 1 ...
        )
            friend = randi(populationSize);
        end
        % add friend to person's row in matrix
        socialNetwork(person, i) = friend;
    end
end

end
