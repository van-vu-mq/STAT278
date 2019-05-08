function socialNetwork = generateSocialNetwork(populationSize, socialNetworkSizeData)

%disp(socialNetworkSizeData);

% 1 row per person
% 1 column per friend of person
socialNetwork = zeros(populationSize, max(socialNetworkSizeData));

for person=1:populationSize
    
    friendCount = socialNetworkSizeData(person);
    
    for i=1:friendCount
        % randomly pick from population
        friend = randi(populationSize);
        % make sure selected person is not already in the social circle
        % make sure person is not a friend of themselves
        while (friend == person || ismember(friend, socialNetwork(person,:)) == 1)
            friend = ceil(rand()*populationSize);
        end
        % add friend to person's row in matrix
        socialNetwork(person, i) = friend;
    end
end

end
