function networkGraph = generateNetworkGraph(populationSize, socialNetworkSizeData, socialNetwork)
% Graphs connects each person has with the rest of the population

%%%% Graphing social network
startNode = [];
endNode = [];
for person=1:populationSize
    personFriendCount = socialNetworkSizeData(person,1);
    for friendIndex=1:personFriendCount
        startNode = [startNode, person];
        endNode = [endNode, socialNetwork(person,friendIndex)];
    end
end


networkGraph = graph(startNode, endNode);
end