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
sickDuration = 6;
daysSick = 7;
incubationPeriod = 8;
hasSymptoms = 9;
atHome = 10;


%%%% setup
simulationPeriod = 1;   % days
populationSize = 21;    

populationList = generatePopulation(populationSize);
socialNetwork = generateRandomSocialNetwork(populationSize, populationList(:,socialNetworkSize));
diseaseData = getDiseaseData();

% In case no one is sick in the initial population
% Forcibly makes 1 person sick
% Sometimes happens for small population size
if (sum(populationList(:, isSick) == 0))
    personIndex = randi(populationSize, 1, 1);
    populationList(personIndex, :) = updateNewPatient(populationList(personIndex, :));
end

% generate graph, highlight
networkGraph = plot(generateNetworkGraph(populationSize, populationList(:,socialNetworkSize), socialNetwork));
highlightSick(networkGraph, socialNetwork, populationList(:,isSick));
diseasePropagationData = cell(simulationPeriod+1, 1);
diseasePropagationData{1} = populationList(:,isSick);

%%%% variable names to make reading code easier
% keywords mapped to matrix column index

%%%%%%%%%%%% Print to console for verifcation 
display = 0;
if (display == 1)
    disp("Initial population data");
    disp(populationList);
    %disp(socialNetwork);
end

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
    newSickPeople = findNewPatients(populationList, listOfSickPeople);
    
    % update info for people who have now contracted the disease
    for person=1:length(newSickPeople)
        newSickPersonIndex = newSickPeople(person,1);
        populationList(newSickPersonIndex, :) = updateNewPatient(newSickPersonIndex, :);
    end

    %%%%%%%%%%%% display for simulation verification
    if (display == 1)
        disp("===================================================================================================");
        disp(">>>>> End of day results. Day:" + day);
        disp(populationList);    
    end
    
    %%%% process some data
    % log/write to file etc
    % we can either save data to a global variable (this method will take
        % up considerable amount of RAM)
    % OR
    % write to a csv / text file to read later by another matlab program
    diseasePropagationData{day+1} = populationList(:, isSick);
    
end

%%%% Analyse data
% graph, plot data, distribution fits, growth/decay analysis etc
if (display == 1)
    disp("Column labels");
    disp("1.Age, 2.isSick, 3.isVaccinated, 4.friendCount, 5.hospital");
    disp("6.sickDuration, 7.daysSick, 8.incubation, 9.symptoms, 10.atHome");
end
toc     % lap timer