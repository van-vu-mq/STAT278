function diseaseData = getDiseaseData()
% Function acts as a storage and retrieval system for data that 
% describes the distribution and bounds of various properties of a 
% virus/disease
% Used to randomise time periods between key stages of sickness


%===== Index mapping of variables of disease data
d_infectionProbability = 1;
d_incubationPeriod = 2;
d_symptomaticPeriod = 3;
d_fatalityRate = 4;

%===== Initialise variable to hold data
varCount = 4;
diseaseData = zeros(2, varCount);


%===== Set Data Values

% How likely an unvaccinated person is to contract 
% the disease from a carrier
% Percentage
diseaseData(1, d_infectionProbability) = 0.90;

% Incubation period
% Number of days it takes for symptoms to appear.
% log-normal distribution
m = 10; % mean
v = 4;  % variance
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));

diseaseData(1, d_incubationPeriod) = mu;
diseaseData(2, d_incubationPeriod) = sigma;


% Duration of symptoms - correlated to the active 
% and infectious period of the virus/diease
% Assumed log-normal distribution
m = 10; % mean
v = 2;  % variance
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
diseaseData(1, d_symptomaticPeriod) = mu;
diseaseData(2, d_symptomaticPeriod) = sigma;

% Fatality rate
% Percentage
diseaseData(1, d_fatalityRate) = 0.003;


end
