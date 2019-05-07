function socialNetwork = generateSocialNetwork(populationSize, socialNetworkSizeData)


% 1 row per person
% 1 column per friend of person
socialNetwork = zeros(populationSize, max(socialNetworkSizeData));


for person=1:populationSize
    
    friendCount = socialNetworkSizeData(person);
    
    for i=1:friendCount
        % randomly pick from population
        friend = ceil(rand()*populationSize);
        % make sure selected person is not already in the social circle
        while(ismember(friend, socialNetwork(person,:)))
            friend = ceil(rand()*populationSize);
        end
        
        % add friend to person's row in matrix
        socialNetwork(person, i) = friend;
    end
end

end
