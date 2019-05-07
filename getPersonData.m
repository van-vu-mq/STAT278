function personData = getPersonData(populationSize)
% Returns the upper and lower bounds of variables that define a person
% Used to randomise a person for simulation


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%   Note: these are only the bounds, they do not describe the distribution
%
%   e.g. age is a right skewed exponential distrubution for an 
%   undeveloped nation
%   while a developed nation's popuation might be bimodal
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %



%%%% parameters of a person unless otherwise specified
% row 1: lower bound || mean / mu
% row 2: upper bound || standard deviantion / sigma 
varCount = 5;
personData = zeros(2, varCount);

% age
% min and max age
% consider using real population data
personData(1, 1) = 1;
personData(2, 1) = 100;

% If the person is currently sick
% default = 0 
% boolean. 0 = not sick, 1 = is sick
personData(1, 2) = 0;

% Whether person is vaccinated (efficacy is defined under diseaseData)
% mean, std
personData(1, 3) = 0.7;
personData(2, 3) = 0.3;

% Social network size / how many friends the person has
% These are the people the person will interact with on a daily basis
% min and max size of social circe
personData(1, 4) = 1;
% smaller value between 30 people vs 25% of population
personData(2, 4) = min(floor(populationSize*0.25), 30);    

% likihood that a person will visit the hospital given symptoms are
% displayed 
% mean, std
personData(1, 5) = 0.5;
personData(2, 5) = 0.5;


end
