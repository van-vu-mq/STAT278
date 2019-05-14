function population = generatePopulation(populationSize)
% Creates and returns a matrix that represents a population
% Matrix of size: populationSize x variablesPerPerson
   
%===============================%
%========= TO_DO LIST ==========%
%===============================%
% Bugs to fix:
    % Hospital visit chance may exceed 100%
        

        
%===== Index mapping of variables of person data
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
personID = 13;

%===============================%
%============ Setup ============%
%===============================%
% Population properties
startingSick = 0;
startingVaccinated = 0.95;

%===== Initialise variable to hold data
varCount = 13;
population = zeros(populationSize, varCount);

%===== Get data pool used to randomise properties of person
personDataRange = getPersonData(populationSize);
p_age = 1;
p_socialNetworkSize = 2;
p_socialLevel = 3;
p_visitHospital = 4;

%===============================%
%=== Generate Population Data ==%
%===============================%
for person=1:populationSize
     %%%% Consider using real population data
     % Age of person
     % distributed along expontential curve
     mu = personDataRange(2,p_age)*0.3;    % 30percent of max age
     population(person, age) = ceil(random('Exponential',mu));
     
     % Seed vaccinated people into the population
     population(person, isVaccinated) = rand() < startingVaccinated;
     
     % Seed sick people into the poplation
     % need to move this out of the loop to avoid vaccinated people
     % causing skews/reducing the number of seeded infected people
     chance = rand();
     % check that random person is not vaccinated
     if (chance < startingSick && population(person,isVaccinated)==0)
         population(person, isSick) = 1;
         population(person, :) = updateNewPatient(population(person,:));
         population(person, previouslyInfected) = 1;
     end

     % Determine the size/number of people in person's social network
     % Assumed normally distributed
     mu = personDataRange(1, p_socialNetworkSize);
     sigma = personDataRange(2, p_socialNetworkSize);
     sns = ceil(normrnd(mu, sigma));
     % make sure at least 1 connection
     while (sns <= 0)
         sns = ceil(normrnd(mu, sigma));
     end
     population(person, socialNetworkSize) = sns;
     
     % Determine average number of people person will 
        % interact with on a daily basis
     % uniformly distributed
     % percentage of social network
     socLevel = 0;
     
     % ensure at least 1 person and is a whole number
     while (socLevel <= 0)
         socLevel = ceil(rand()*2 * sns * personDataRange(2, p_socialLevel));
     end
     population(person, socialLevel) = socLevel;
     
     
     % Probability person will visit the hospital given symptoms
     % Consider an increase as symptoms develop / increase in severity
     % Assumed normally distributed
     mu = personDataRange(1, p_visitHospital);
     sigma = personDataRange(2, p_visitHospital);
     chance = normrnd(mu, sigma); % may exceed 1 ~ 100%
     population(person, hospitalVisit) = chance;
          
     
     % Displaying symptoms
     population(person, hasSymptoms) = 0;
     
     % At home, prevents interaction and spread of the virus/disease
     population(person, atHome) = 0;
          
     % Index/ID
     population(person, personID) = person;
     
end

    
end