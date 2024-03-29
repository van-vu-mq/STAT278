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
displaySummary = 1; % End of simulation summary of the measle spread
displayTimer = 0;   % Time taken to execute each stage of the simulation

% Simulation Parameters
% Edit these to fit your case
simulationDays = 300;   % max days
simulationRepeats = 1;  % iterations
populationSize = 10000;    
startingInfected = 2;   % number of people
percentVaccinated = 0.90;    % percentage of population


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
hospitalVisitChance = 6;
% symptomaticPeriod = 7;
% daysSick = 8;
% incubationPeriod = 9;
hasSymptoms = 10;
atHome = 11;
previouslyInfected = 12;
% index = 13

%===============================%
%========= Simulation ==========%
%===============================%
for sim=1:simulationRepeats
    
    %===============================%
    %=== Initialiase Environment ===%
    %===============================%    
    
    %===== Generate our population
    populationList = generatePopulation(populationSize, percentVaccinated);
    vaxCount = sum(populationList(:, isVaccinated));
    if(displayTimer == 1)
        disp("===============================================");
        disp("Setup population");
        toc;
        tic;
    end
    
    %===== Determine social connections for physical / close proximity  
            % interaction within our population
    socialNetwork = generateSocialNetwork(populationSize, populationList(:,socialNetworkSize));
    % correct mismatch of assigned aquaintance and socialNetworkSize
        % refer to generateSocialNetwork()
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
        % check that random person is not vaccinated or
            % already chosen as seed infected
        while (populationList(personIndex, isVaccinated) == 1 ...
                || populationList(personIndex, isSick) == 1)
            personIndex = randi(populationSize);
        end
        populationList(personIndex, :) = updateNewPatient(populationList(personIndex, :));
    end

    %===== Setup data storage for simulation results
    % row: person ID
    % column: day
    diseasePropagationData = zeros(populationSize, simulationDays+1);
    endOfDaySickCount = zeros(simulationDays, 1);
    % store initial state of the population
    diseasePropagationData(:, 1) = populationList(:,isSick);
    endOfDaySickCount(1) = sum(populationList(:,isSick));
    if(displayTimer == 1)
        disp("===============================================");
        disp("End Setup");
        toc;
        tic;
    end
    
    %===== Generate graph to visualize measles spread within our population
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
        % If there are no more cases of measles, stop the simulation
            % instance
        if (endOfDaySickCount(day) == 0)
            break
        end
        
        numberOfSickPeople = sum(populationList(:, isSick));
        listOfSickPeople = zeros(numberOfSickPeople, 1);
        sickPeopleFound = 0;

        %===== find the sick people in the population
        % Only their interaction can change the number of sick people in
        % the population
        for person=1:populationSize
            if (populationList(person, isSick) == 1)
                sickPeopleFound = sickPeopleFound + 1;
                listOfSickPeople(sickPeopleFound) = person;
            end
        end

        %===== Determine who sick people have spread the disease to
        newSickPeople = findNewPatients(populationList, socialNetwork, listOfSickPeople);

        %===== Update newly infected people's data to reflect their
            %condition
        for person=1:length(newSickPeople)
            newSickPersonIndex = newSickPeople(person);
            populationList(newSickPersonIndex, :) = updateNewPatient(populationList(newSickPersonIndex, :));
        end


        %===============================%
        %========= End of day ==========%
        %===============================%
        % Update data of the people sick at the beginning of the day
            % to reflect the passing of one day        
        for person=1:length(listOfSickPeople)
            sickPersonID = listOfSickPeople(person);
            populationList(sickPersonID, :) = updateExistingPatient(populationList(sickPersonID, :));
        end
        
        %===== Determine behaviour of people closely related to people who
            % have measles
        
        % Find closely related people
        paranoidPeople = getParanoidPeople(populationList, socialNetwork, listOfSickPeople);
        % Send them to the hospital
        for person=1:length(paranoidPeople)
            personID = paranoidPeople(person);
            populationList(personID, :) = visitHospital(populationList(personID, :));
        end


        %===== Process/log data
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
    if (displayTimer == 1)
        disp("===============================================");
        disp("Simulation");
        toc;
    end
    %===============================%
    %========= Process Data ========%
    %===============================%
    % graph, plot data, distribution fits, growth/decay analysis etc
    if (displaySummary == 1) 
        
        startSick = sum(endOfDaySickCount(1));

        avgNetSize = mean(populationList(:, socialNetworkSize));
        avgDailyInteraction = mean(populationList(:, socialLevel));
        avgHospVisitChance = mean(populationList(:, hospitalVisitChance))*100;

        peakSick = max(endOfDaySickCount);
        peakDay = 0;
        for day=1:simulationDays
            if (endOfDaySickCount(day) == peakSick)
                peakDay = day;
                break
            end
        end

        daysSimulated = sum(endOfDaySickCount>0)-1;

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
        if (displayTimer == 1)
            disp("===============================================");
            disp("Generate Summary");
            toc;
        end        
    end
    
    %===============================%
    %======== Write to File ========%
    %===============================%
    % setup file
    filename = "Measles_Vax-" + percentVaccinated + "_Instance-" + sim + ".txt";
    fileID = fopen(filename, 'w');
    % write the data
    fprintf(fileID, '%g\n', endOfDaySickCount);
    fclose(fileID);
    if (displayTimer == 1)
        disp("===============================================");
        disp("Write to file");
        toc;
    end
    
end

if (displayTimer == 0)
    disp("===============================================");
    disp("Total Run Time");
	toc;
end