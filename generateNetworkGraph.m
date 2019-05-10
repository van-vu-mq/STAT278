function networkGraph = generateNetworkGraph(populationSize, socialNetworkSizeData, socialNetwork)
% Plots vertices for each person.
% Draws an edge for each connection, defined by aquaintances between people

%===== Variables to hold parameters for edges
startNode = [];
endNode = [];

%===== Convert social network data into edge data
for person=1:populationSize
    personFriendCount = socialNetworkSizeData(person,1);
    for friendIndex=1:personFriendCount
        startNode = [startNode, person];
        endNode = [endNode, socialNetwork(person,friendIndex)];
    end
end

%===== build graph
networkGraph = graph(startNode, endNode);
end