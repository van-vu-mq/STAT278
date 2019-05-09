function population = generatePopulation(populationSize)
% Generates a matrix 
    % 1 row per person
    % 1 column per variable to describe the person
    
% repeatable random generation for testing
rng default
    
% Population properties
startingSick = 0.1;
startingVaccinated = 0;

%%%% initialise list
varCount = 13;
population = zeros(populationSize, varCount);


% Variables:
age = 1;
isSick = 2;
isVaccinated = 3;
socialNetworkSize = 4;
socialLevel = 5;
hospitalVisit = 6;
% sickDuration = 7;
% daysSick = 8;
% incubationPeriod = 9;
hasSymptoms = 10;
atHome = 11;
previouslyInfected = 12;

%%%% get bounds for data to describe a person 
% using a matrix to reduce clutter of numerous variables
personDataRange = getPersonData(populationSize);
p_age = 1;
p_socialNetworkSize = 2;
p_socialLevel = 3;
p_visitHospital = 4;

%%%% generate person data and insert into the list
for person=1:populationSize
     %%%% Consider using real population data
     % population age 
     % distributed along expontential curve
     mu = personDataRange(2,p_age)*0.3;    % 30percent of max age
     population(person, age) = ceil(random('Exponential',mu));
     
     % Seed vaccinated people into the population
     population(person, isVaccinated) = rand() < startingVaccinated;
     
     % Seed sick people into the poplation
     % might need to move this out of the loop, avoiding vaccinated people
     % skews/reduces the number of seeded infected people
     chance = rand();
     % check that random person is not vaccinated
     if (chance < startingSick && population(person,isVaccinated)==0)
         population(person, isSick) = 1;
         population(person, :) = updateNewPatient(population(person,:));
         population(person, previouslyInfected) = 1;
     end

     % determine the size/number of people in person's social network
     % assumed normally distributed
     mu = personDataRange(1, p_socialNetworkSize);
     sigma = personDataRange(2, p_socialNetworkSize);
     value = ceil(normrnd(mu, sigma));
     % makes sure at least 1 connection
     while (value < mu)
         value = ceil(normrnd(mu, sigma));
     end
     population(person, socialNetworkSize) = value;
     
     % determine how many people person will interact with on a daily basis
     % social interaction will be with people drawn randomly from social
     % network
     % uniformly distributed
     % percentage of social network
     % ceil function to ensure max value is a whole number and is never 0;
     maxSL = ceil(personDataRange(2, p_socialLevel)*population(person, socialNetworkSize));
     population(person, socialLevel) = ceil(rand() * maxSL);
     
     
     % probability person will visit the hospital given symptoms
     % can increase as symptoms develop / increase in severity
     % assumed normally distributed
     mu = personDataRange(1, p_visitHospital);
     sigma = personDataRange(2, p_visitHospital);
     chance = normrnd(mu, sigma); % may exceed 1 ~ 100%
     population(person, hospitalVisit) = chance;
          
     
     % Displaying symptoms
     population(person, hasSymptoms) = 0;
     
     % At home
     population(person, atHome) = 0;
          
     %%%% index
     population(person, varCount) = person;
     
end

    
end