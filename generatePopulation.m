function population = generatePopulation(populationSize)
% Generates a matrix 
    % 1 row per person
    % 1 column per variable to describe the person

% Variables:
    % Age
    %
    % etc

%%%% get bounds for data to describe a person 
% using a matrix to reduce clutter of numerous variables
personData = getPersonData(populationSize);


%%%% initialise list
varCount = 11;
population = zeros(populationSize, varCount);

startingSick = 0.1;

% repeatable random generation for testing
rng default

%%%% generate person data and insert into the list
for person=1:populationSize
     %%%% Consider using real population data
     % population age distributed along expontential curve
     population(person, 1) = floor(random('Exponential',personData(2,1)*0.3));
     
     % is currently sick
     % 1 percent of the population starts out sick
     population(person, 2) = rand() < startingSick;
     
     % is vaccinated
     population(person, 3) = randn() < personData(1,3);
     
     % social network size
     population(person, 4) = floor(rand()*(personData(2,4)-personData(1,4)) + personData(1,4));
     
     % hospital visit
     population(person, 5) = -1;    % random value out of allowed range
     while (population(person, 5) > 1 || population(person, 5) < 0)
         population(person, 5) = normrnd(personData(1, 5), personData(2, 5))/2;
     end
     
     % days person has been sick for
     population(person, 6) = 0;
     
     % if sick
     if (population(person, 2) == 1)
         % expected duration of sickness 
         population(person, :) = updateNewPatient(population(person,:));
     end
     
     % Displaying symptoms
     population(person, 9) = 0;
     
     % At home
     population(person, 10) = 0;
     
     
     
     %%%% index
     population(person, 11) = person;
     
end

    
end