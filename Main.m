% Progam intended to simulate the spread of measles in a population
% Measle spread takes into consideration:
%     Propgation properties of the virus
%     Simplified social behaviour of the populace
%     Simplified and limited options to contain, prevent or 
%         otherwise control the spread of the virus


tic     % start timer

%===============================%
%========= TO_DO LIST ==========%
%===============================%
% apply logic for population age distribution ~ optional
% simulate interaction with social network
% function: findNewPatient()
% update generateSocialNetwork
    % cluster format
% process data    


%===============================%
%=== PopulationList Variables ==%
%===============================%
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


%===============================%
%============ Setup ============%
%===============================%

%===== Performance ~ 10/May/19
% Without graph plot
    % ~33-35s -> 100k people
    
% repeatable random generation for testing
%rng default

% plot the graph during runtime, 0=no, 1=yes
displayGraphRuntime = 0; 

simulationPeriod = 500;   % days
populationSize = 100000;    
% only use for small number
% for larger number, go to generatePopulation();
startingInfected = 2;   


%===== Initialise population
populationList = generatePopulation(populationSize);
disp("===============================================");
disp("Setup population");
toc;
tic;
socialNetwork = generateSocialNetwork(populationSize, populationList(:,socialNetworkSize));
% correct mismatch of assigned aquataince and socialNetworkSize
    % refer to generate socialNetwork()
for person=1:populationSize
    populationList(person, socialNetworkSize) = sum(socialNetwork(person, :)>0);
end
disp("===============================================");
disp("Setup social network");
toc;
tic;
%===== Seed in infected people
for inf=1:startingInfected
    personIndex = randi(populationSize);
    % check that random person is not vaccinated
    while (populationList(personIndex, isVaccinated) == 1 || populationList(personIndex, isSick) == 1)
        personIndex = randi(populationSize);
    end
    populationList(personIndex, :) = updateNewPatient(populationList(personIndex, :));
end

%===== Data store reach of the virus at any given point
% row: person ID
% column: day
diseasePropagationData = zeros(populationSize, simulationPeriod+1);
endOfDaySickCount = zeros(populationSize, 1);
% store initial state of the population
diseasePropagationData(:, 1) = populationList(:,isSick);
endOfDaySickCount(1) = sum(populationList(:,isSick));
 
%===== Generate graph
networkGraph = generateNetworkGraph(populationSize, populationList(:,socialNetworkSize), socialNetwork);
if (displayGraphRuntime == 1)
    networkPlot = plot(networkGraph);
    % colour the graph to reflect disease spread / population health
    highlightSick(networkPlot, socialNetwork, diseasePropagationData(:, 1));
end
disp("===============================================");
disp("Generate Network Graph");
toc;
tic;

%===============================%
%============ Logic ============%
%===============================%
for day=1:simulationPeriod
    if (endOfDaySickCount(day) == 0)
        break
    end
    
    numberOfSickPeople = sum(populationList(:, isSick));
    listOfSickPeople = zeros(numberOfSickPeople, 1);
    sickPeopleFound = 0;
    
    %===== find the sick people in the population
    % only their interaction matters regarding disease spread
    for person=1:populationSize
        if (populationList(person, isSick) == 1)
            % add sick person's ID to array to track
            sickPeopleFound = sickPeopleFound + 1;
            listOfSickPeople(sickPeopleFound) = person;
        end
    end
    
    %===== determine who sick people have spread the disease to
    newSickPeople = findNewPatients(populationList, socialNetwork, listOfSickPeople);
    
    %===== update info for people who have now contracted the disease
    for person=1:length(newSickPeople)
        newSickPersonIndex = newSickPeople(person);
        populationList(newSickPersonIndex, :) = updateNewPatient(populationList(newSickPersonIndex, :));
    end
    
    
    %===============================%
    %========= End of day ==========%
    %===============================%
    % update information of people sick at the beginning of the day
    for person=1:length(listOfSickPeople)
        sickPersonID = listOfSickPeople(person);
        populationList(sickPersonID, :) = updateExistingPatient(sickPersonID, populationList, socialNetworks);
    end
   
    %===== process/log data
    % Store health state of the population
    diseasePropagationData(:, day+1) = populationList(:,isSick);
    endOfDaySickCount(day+1) = sum(populationList(:,isSick));
    
    %===== Graph the status of the population
    if (displayGraphRuntime == 1)
        highlightSick(networkPlot, socialNetwork, diseasePropagationData(:, day+1));  
        disp(" ");
        disp("End of day: " + day);
        disp(endOfDaySickCount(day+1) + " people are sick");
    end

end

%==== Analyse data
% graph, plot data, distribution fits, growth/decay analysis etc
vaxCount = sum(populationList(:, isVaccinated));
startSick = sum(endOfDaySickCount(1));

avgNetSize = mean(populationList(:, socialNetworkSize));
avgDailyInteraction = mean(populationList(:, socialLevel));
avgHospVisitChance = mean(populationList(:, hospitalVisit))*100;

peakSick = max(endOfDaySickCount);
peakDay = 0;
for day=1:simulationPeriod
    if (endOfDaySickCount(day) == peakSick)
        peakDay = day;
        break
    end
end

disp("===============================================");
disp("Simulation");
toc;


disp("===============================================");
disp("Intended days simulated: " + simulationPeriod);
disp("Days simulated: " + (sum(endOfDaySickCount>0)-1));
disp("Population Size: " + populationSize);
disp(" ");
disp("Average social network size: " + avgNetSize);
disp("Average daily interactions: " + avgDailyInteraction);
disp("Average chance of hospital visit given symptoms: " + avgHospVisitChance + "%");
disp(" ");
disp("People vaccinated: " + vaxCount + " / " + vaxCount/populationSize*100 + "%");
disp("Initial number of sick people: " + startSick + " / " + startSick/populationSize*100 + "%");
disp(" ");
disp("Peak number of sick people: " + peakSick + " / " + peakSick/populationSize*100 + "%");
disp("     Day: " + peakDay);


