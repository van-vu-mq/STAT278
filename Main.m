% Progam intended to simulate the spread of measles in a population
% Measle spread takes into consideration:
%     Propgation properties of the virus
%     Simplified social behaviour of the populace
%     Simplified and limited options to contain, prevent or 
%         otherwise control the spread of the virus


tic;     % start timer


%===============================%
%============ Setup ============%
%===============================%

% repeatable random generation for testing
% rng default

% Display useful data about the simulation
displayGraph = 0;   % Social network relation graph
displaySummary = 0; % End of simulation summary of the measle spread
displayTimer = 1;   % Time taken to execute each stage of the simulation

% Simulation Parameters
% Edit these to fit your case
simulationDays = 300;   % max days
simulationRepeats = 1;  % iterations
populationSize = 100000;    
startingInfected = 2;   % number of people
percentVaccinated = 0.95;    % percentage of population


%===============================%
%=== PopulationList Variables ==%
%===============================%
% Used for referencing the population in place of integers
% DO NOT MODIFY THIS
% age = 1;
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
%========= Simulation ==========%
%===============================%
for sim=1:simulationRepeats
    
    %===============================%
    %=== Initialiase Environment ===%
    %===============================%    
    
    %===== Initialise population
    populationList = generatePopulation(populationSize, percentVaccinated);
    if(displayTimer == 1)
        disp("===============================================");
        disp("Setup population");
        toc;
        tic;
    end
    socialNetwork = generateSocialNetwork(populationSize, populationList(:,socialNetworkSize));
    % correct mismatch of assigned aquataince and socialNetworkSize
        % refer to generate socialNetwork()
    for person=1:populationSize
        populationList(person, socialNetworkSize) = sum(socialNetwork(person, :)>0);
    end
    if(displayTimer == 1)
        disp("===============================================");
        disp("Setup social network");
        toc;
        tic;
    end
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
    diseasePropagationData = zeros(populationSize, simulationDays+1);
    endOfDaySickCount = zeros(simulationDays, 1);
    % store initial state of the population
    diseasePropagationData(:, 1) = populationList(:,isSick);
    endOfDaySickCount(1) = sum(populationList(:,isSick));

    %===== Generate graph
    if (displayGraph == 1)
        networkGraph = generateNetworkGraph(populationSize, populationList(:,socialNetworkSize), socialNetwork);
        networkPlot = plot(networkGraph);
        % colour the graph to reflect disease spread / population health
        highlightSick(networkPlot, socialNetwork, diseasePropagationData(:, 1));
        if(displayTimer == 1)
            disp("===============================================");
            disp("Generate Network Graph");
            toc;
            tic;
        end        
    end


    %===============================%
    %============ Logic ============%
    %===============================%
    for day=1:simulationDays
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
            populationList = updateExistingPatient(sickPersonID, populationList, socialNetwork);
        end

        %===== process/log data
        % Store health state of the population
        diseasePropagationData(:, day+1) = populationList(:,isSick);
        endOfDaySickCount(day+1) = sum(populationList(:,isSick));

        %===== Graph the status of the population
        if (displayGraph == 1)
            highlightSick(networkPlot, socialNetwork, diseasePropagationData(:, day+1));  
            disp(" ");
            disp("End of day: " + day);
            disp(endOfDaySickCount(day+1) + " people are sick");
        end

    end

    %===============================%
    %========= Process Data ========%
    %===============================%
    % graph, plot data, distribution fits, growth/decay analysis etc
    
    vaxCount = sum(populationList(:, isVaccinated));
    startSick = sum(endOfDaySickCount(1));

    avgNetSize = mean(populationList(:, socialNetworkSize));
    avgDailyInteraction = mean(populationList(:, socialLevel));
    avgHospVisitChance = mean(populationList(:, hospitalVisit))*100;

    peakSick = max(endOfDaySickCount);
    peakDay = 0;
    for day=1:simulationDays
        if (endOfDaySickCount(day) == peakSick)
            peakDay = day;
            break
        end
    end

    daysSimulated = sum(endOfDaySickCount>0)-1;

    if (displayTimer == 1)
        disp("===============================================");
        disp("Simulation");
        toc;
    end
    
    if (displaySummary == 1) 

        disp("===============================================");
        disp("Intended days simulated: " + simulationDays);
        disp("Days simulated: " + daysSimulated);
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
    end
    
    %===============================%
    %======== Write to File ========%
    %===============================%
    % setup file
    filename = "Measles_Vax-" + percentVaccinated + "_Instance-" + sim + ".txt";
    fileID = fopen(filename, 'w');
    % write the data
    fprintf(fileID, '%i\n', endOfDaySickCount);
    fclose(fileID);
    
end

if (displayTimer == 0)
    disp("===============================================");
    disp("Total Run Time");
	toc;
end