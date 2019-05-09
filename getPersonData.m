function personData = getPersonData(populationSize)
% Data store, data that describes the distribution of qualities of a
% population
% Used to randomise data that describes a person


% Variables
p_age = 1;
p_socialNetworkSize = 2;
p_socialLevel = 3;
p_visitHospital = 4;

varCount = 3;
personData = zeros(2, varCount);

% age
% min and max age
% consider using real population data
personData(1, p_age) = 1;
personData(2, p_age) = 100;

% Social network size / how many friends the person has
% These are the people the person will interact with on a daily basis
% mu, sigma
% smaller value between 'mu' people and 20% of population
targetMean = 30;
mu = min(floor(populationSize*0.1), targetMean);
sigma = ceil(mu*0.2);
personData(1, p_socialNetworkSize) = mu;
personData(2, p_socialNetworkSize) = sigma;

% How many people person will interact with on a daily basis
% Social interaction will be with people drawn randomly from social
% network
% min as value, max as a percentage of socialNetworkSize
personData(1, p_socialLevel) = 1;
personData(2, p_socialLevel) = 0.2;

% likelihood that a person will visit the hospital given symptoms are
% displayed
% may vary if stages and severity of symptoms are defined in the model
    % e.g. cough/watery eyes > fever > rashes
% mean, std
personData(1, p_visitHospital) = 0.9;
personData(2, p_visitHospital) = 0.1;

end
