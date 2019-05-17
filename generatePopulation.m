function populationList = generatePopulation(populationSize, percentVaccinated)
% Creates and returns a matrix that represents a population
% Matrix of size: populationSize x variablesPerPerson
   
%===============================%
%========= TO_DO LIST ==========%
%===============================%
% Bugs to fix:
    % Hospital visit chance may exceed 100%
        

        
%===== Index mapping of variables of person data
age = 1;
% isSick = 2;
isVaccinated = 3;
socialNetworkSize = 4;
socialLevel = 5;
hospitalVisit = 6;
% symptomaticPeriod = 7;
% daysSick = 8;
% incubationPeriod = 9;
hasSymptoms = 10;
atHome = 11;
% previouslyInfected = 12;
index = 13;

%===============================%
%============ Setup ============%
%===============================%

%===== Initialise variable to hold population data
varCount = 13;
populationList = zeros(populationSize, varCount);

%===== Get data pool used to randomise properties of person
personDataRange = getPersonData(populationSize);
% p_age = 1;
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
     mu = 30;    % 30yro
     populationList(person, age) = ceil(random('Exponential',mu));
     
     % Seed vaccinated people into the population
     populationList(person, isVaccinated) = rand() < percentVaccinated;

     % Determine the size/number of people in person's social network
     % Assumed normally distributed
     mu = personDataRange(1, p_socialNetworkSize);
     sigma = personDataRange(2, p_socialNetworkSize);
     sns = ceil(normrnd(mu, sigma));
     % make sure at least 1 connection
     while (sns <= 0)
         sns = ceil(normrnd(mu, sigma));
     end
     populationList(person, socialNetworkSize) = sns;
     
     % Determine average number of people person will interact with on a daily basis
     % uniformly distributed
     % percentage of social network
     socLevel = 0;
     
     % ensure at least 1 person and is a whole number
     while (socLevel <= 0)
         socLevel = ceil(rand()*2 * sns * personDataRange(2, p_socialLevel));
     end
     populationList(person, socialLevel) = socLevel;
     
     
     % Probability person will visit the hospital given symptoms
     % Consider an increase as symptoms develop / increase in severity
     % Assumed normally distributed
     mu = personDataRange(1, p_visitHospital);
     sigma = personDataRange(2, p_visitHospital);
     chance = normrnd(mu, sigma); % may exceed 1 ~ 100%
     populationList(person, hospitalVisit) = chance;
          
     
     % Displaying symptoms
     populationList(person, hasSymptoms) = 0;
     
     % At home, prevents interaction and spread of the virus/disease
     populationList(person, atHome) = 0;
          
     % Index/ID
     populationList(person, index) = person;
     
end

    
end