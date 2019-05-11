function networkGraph = generateNetworkGraph(populationSize, socialNetworkSizeData, socialNetwork)
% Plots vertices for each person.
% Draws an edge for each connection, defined by aquaintances between people

%===== Variables to hold parameters for edges
startNode = [];
endNode = [];

%===== Convert social network data into edge data
for person=1:populationSize
    personFriendCount = socialNetworkSizeData(person,1);
    for friend=1:personFriendCount
        friendIndex = socialNetwork(person,friend);
        % check that we have not already added all edges for friend
        % prevents duplicates
            % if A-B is done, no need to do B-A
        if (person<friendIndex)
            startNode = [startNode, person];
            endNode = [endNode, friendIndex];
        end
    end
end

%===== build graph
networkGraph = graph(startNode, endNode);
end