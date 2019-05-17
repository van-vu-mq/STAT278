function socialNetwork = generateSocialNetwork(populationSize, socialNetworkSizeData)
% Creates connections between people within the population

%===============================%
%========= TO_DO LIST ==========%
%===============================%
% Bug list
    % To prevent long search times for a person who has not yet reached
    % assigned aquaintance count, function allows an N% assignment over the
    % socialNetworkSize for each person.
        % results in incorrect socialNetworkSize data
        % temporary solution, Main will adjust each person's
        % socialNetworkSize to match assigned social network
    
    
%===== Initialise variable to hold data
% 1 row per person
% 1 column per friend of person
socialNetwork = zeros(populationSize, max(socialNetworkSizeData));
assignedCounter = zeros(populationSize, 1);

% 
overCapacityThreshold = 1.1;

%===== Assign Aquaintances
for person=1:populationSize
    % how many to assign minus how many already assigned
    friendCount = 0;
    % make sure not over limit
    if (assignedCounter(person) < socialNetworkSizeData(person)*overCapacityThreshold)
        friendCount = socialNetworkSizeData(person) - assignedCounter(person);
    end
    
    for i=1:friendCount
        % randomly pick from population
        friend = randi(populationSize);
        
        % make sure friend is not themself
        % friend is not in person's social network
        % person is not in friend's social network
        
        % will not make friend have too many people in social network
            % temporary solution, allow n% additional social network size
        while (friend == person ...
            || ismember(friend, socialNetwork(person,:)) == 1 ...
            || ismember(person, socialNetwork(friend,:)) == 1 ...
            || assignedCounter(friend) >= socialNetworkSizeData(friend)*overCapacityThreshold ...
        )
            friend = randi(populationSize);
        end
        % add friend to person's network
        assignedCounter(person, 1) = assignedCounter(person,1) + 1;
        socialNetwork(person, assignedCounter(person, 1)) = friend;
        
        % add person to friend's network
        assignedCounter(friend, 1) = assignedCounter(friend,1) + 1;
        socialNetwork(friend, assignedCounter(friend, 1)) = person;
    end
end

end
