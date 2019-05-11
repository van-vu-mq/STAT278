function personData = getPersonData(populationSize)
% Function acts as a storage and retrieval system for data that 
% describes the distribution and bounds of various properties of a person
% Used to randomise data that describes a person


%===== Index mapping of variables of person data
p_age = 1;
p_socialNetworkSize = 2;
p_socialLevel = 3;
p_visitHospital = 4;

%===== Initialise variable to hold data
varCount = 4;
personData = zeros(2, varCount);


%===== Set Data Values

% age
% min, max
% consider using real population data
personData(1, p_age) = 1;
personData(2, p_age) = 100;

% Social network size / pool of aquaintances from which a person 
% may interact / come into contact with
% These are they people whom given person may spread virus/disease to.
% mu, sigma

% smaller value between 'mu' people and n% of population
% handles case of small population size
targetMean = 60;
mu = ceil(min(floor(populationSize*0.1), targetMean));
sigma = ceil(mu*0.1);
personData(1, p_socialNetworkSize) = mu;
personData(2, p_socialNetworkSize) = sigma;

% Number of people person will interact with on a daily basis
% min: arbitary value
% max: percentage of socialNetworkSize
personData(1, p_socialLevel) = 1;
personData(2, p_socialLevel) = 0.10;

% Likelihood that a person will visit the hospital given symptoms are
% displayed
% May vary if stages and severity of symptoms are defined in the model
    % e.g. cough/watery eyes > fever > rashes
% mean, sigma
personData(1, p_visitHospital) = 0.95;
personData(2, p_visitHospital) = 0.05;

end
