function socialNetwork = generateRandomSocialNetwork(populationSize, socialNetworkSizeData)

%disp(socialNetworkSizeData);

% 1 row per person
% 1 column per friend of person
socialNetwork = zeros(populationSize, max(socialNetworkSizeData));

for person=1:populationSize
    
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
