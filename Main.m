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


%%%% setup
simulationPeriod = 2;   % days
populationSize = 15;    % 100k people takes ~30-60seconds, as of 6/May/19

populationList = generatePopulation(populationSize);
socialNetwork = generateSocialNetwork(populationSize, populationList(:,4));
diseaseData = getDiseaseData();

%%%% variable names to make reading code easier
% keywords mapped to matrix column index

%%%%%%%%%%%% Print to console for verifcation 
display = 1;
if (display == 1)
    disp("Initial population data");
    disp(populationList);
    %disp(socialNetwork);
end

%%%% model logic
% key points / function calls are marked on left side next to line number
for day=1:simulationPeriod
   
    for person=1:populationSize
        % if person is sick
        if (populationList(person, 2) == 1)
% =====                 
            % update person
            % pass the person's data to function, replace with data given
            % back       
            populationList(person, :) = updateExistingPatient(populationList(person, :));
            
            % if person is not at home / is still interacting with people
            if (populationList(person, 10) == 0)               
                personNetworkSize = populationList(person, 4);
                
                % simulate interaction with friends
                for friend=1:personNetworkSize
                    % roll dice if friend catches the disease
                    diceRoll = rand();
                    % they lost the dice roll, lul
                    if (diceRoll < diseaseData(1,1))
                        friendIndex = socialNetwork(person, friend);
% =====                             
                        % update friend who is now sick
                        populationList(friendIndex, :) = updateNewPatient(populationList(friendIndex, :));
                    end 
                end                               
            end                
        end
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
    
end

%%%% Analyse data
% graph, plot data, distribution fits, growth/decay analysis etc

disp("Column labels");
disp("1.Age, 2.isSick, 3.isVaccinated, 4.friendCount, 5.hospital");
disp("6.sickDuration, 7.daysSick, 8.incubation, 9.symptoms, 10.atHome");
toc     % lap timer