tic     % start timer

% TO_DO LIST
% apply logic for population age distribution ~ optional
% simulate interaction with social network
% simulation disease spread
    % which friends get sick
    % do people die / get removed from the population pool
% simluation behavour when sick
    % stay home
    % get treatment
% add in costs of medical treatment, etc
% add social interaction complexity
    % currently, sick person will interact with every person they know
    % add a variable/range to randomise how many people from their social
    % circle they will interact with
% add a more realistics friend network, currently it is entirely random.
    % first pass: assign half of friends randomly 
    % second pass: assign remaining half from friend's social network
        % simulates people in a social clique
% process data     
age = 1;
isSick = 2;
isVaccinated = 3;
friendCount = 4;
sickDuration = 6;
daysSick = 7;
incubationPeriod = 8;
hasSymptoms = 9;
atHome = 10;


%%%% setup
simulationPeriod = 1;   % days
populationSize = 20;    

populationList = generatePopulation(populationSize);
socialNetwork = generateRandomSocialNetwork(populationSize, populationList(:,friendCount));
diseaseData = getDiseaseData();

% generate graph, highlight
networkGraph = plot(generateNetworkGraph(populationSize, populationList(:,friendCount), socialNetwork));
highlightSick(networkGraph, socialNetwork, populationList(:,isSick));
diseaePropagationData = cell(simulationPeriod+1, 1);
diseaePropagationData{1} = populationList(:,isSick);

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
    
    numberOfPeopleSick = sum(populationList(:, isSick));
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
    newSickPeople = findNewPatients(populationList, listofSickPeople);
    
    % update info for people who have now contracted the disease
    for person=1:length(newSickPeople)
        sickPersonIndex = newSickPeople(person,1);
        populationList(sickPersonIndex, :) = updateNewPatient(sickPersonIndex, :);
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
    diseaePropagationData{day+1} = populationList(:, isSick);
    
end

%%%% Analyse data
% graph, plot data, distribution fits, growth/decay analysis etc
if (display == 1)
    disp("Column labels");
    disp("1.Age, 2.isSick, 3.isVaccinated, 4.friendCount, 5.hospital");
    disp("6.sickDuration, 7.daysSick, 8.incubation, 9.symptoms, 10.atHome");
end
toc     % lap timer