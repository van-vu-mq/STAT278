tic     % start timer

% TO_DO LIST
% apply logic for population age distribution ~ optional
% simulate interaction with social network
% function: findNewPatient()
% update generateSocialNetwork
    % cluster format
% process data    

age = 1;
isSick = 2;
isVaccinated = 3;
socialNetworkSize = 4;
socialLevel = 5;
hospitalVisit = 6;
% symptomaticPeriod = 7;
% daysSick = 8;
% incubationPeriod = 9;
hasSymptoms = 10;
atHome = 11;
previouslyInfected = 12;


%%%% setup
simulationPeriod = 10;   % days
populationSize = 20;    % 2.6seconds per 10k people as at 9/May/19

populationList = generatePopulation(populationSize);
socialNetwork = generateRandomSocialNetwork(populationSize, populationList(:,socialNetworkSize));
diseaseData = getDiseaseData();

% In case no one is sick in the initial population
% Forcibly makes 1 person sick
% Sometimes happens for small population size
if (sum(populationList(:, isSick))==0)
    personIndex = randi(populationSize, 1, 1);
    populationList(personIndex, :) = updateNewPatient(populationList(personIndex, :));
end

% create data store for diease spread over the population
diseasePropagationData = cell(simulationPeriod+1, 1);
% store initial state of the population
diseasePropagationData{1} = populationList(:,isSick);
% generate graph
networkGraph = plot(generateNetworkGraph(populationSize, populationList(:,socialNetworkSize), socialNetwork));
% colour the graph to reflect disease spread / population health
highlightSick(networkGraph, socialNetwork, diseasePropagationData{1});


%%%% variable names to make reading code easier
% keywords mapped to matrix column index

%%%% model logic 
for day=1:simulationPeriod
    
    numberOfSickPeople = sum(populationList(:, isSick));
    listOfSickPeople = zeros(numberOfSickPeople, 1);
    sickPeopleFound = 0;
    
    % find the sick people in the population
    % only their interaction matters regarding disease spread
    for person=1:populationSize
        if (populationList(person, isSick) == 1)
            % add sick person's ID to array to track
            sickPeopleFound = sickPeopleFound + 1;
            listOfSickPeople(sickPeopleFound) = person;
            % update their info
            populationList(person, :) = updateExistingPatient(populationList(person, :));
        end
    end
    
    % all sick people found, determine who they have spread the disease to
    newSickPeople = findNewPatients(populationList, socialNetwork, listOfSickPeople);
    
    % update info for people who have now contracted the disease
    for person=1:length(newSickPeople)
        newSickPersonIndex = newSickPeople(person);
        populationList(newSickPersonIndex, :) = updateNewPatient(populationList(newSickPersonIndex, :));
    end

    %%%% process/log some data
    % store the isSick column
    diseasePropagationData{day+1} = populationList(:, isSick);
    
end

%%%% Analyse data
% graph, plot data, distribution fits, growth/decay analysis etc

toc     % lap timer