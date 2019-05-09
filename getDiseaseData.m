function diseaseData = getDiseaseData()
% Returns the upper and lower bounds of variables that define disease's
% behaviour


% data indexing
infectionProbability = 1;
incubationPeriod = 2;
symptomaticPeriod = 3;
fatalityRate = 4;

%%%%
% row 1: mean
% row 2: standard deviation
varCount = 4;
diseaseData = zeros(2, varCount);

% How likely an unvaccinated person is to contract the disease from a
% carrier
% Percentage, 0-1
diseaseData(1, infectionProbability) = 0.95;

% Incubation period
% Number of days it takes for symptoms to appear. LogNormal distribution
% log-normal distribution - values are calculated to match
m = 10; % mean
v = 4;  % variance
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));

diseaseData(1, incubationPeriod) = mu;
diseaseData(2, incubationPeriod) = sigma;


% Duration of symptoms - correlated to the active period of the diease
% Assumed log-normal distribution
m = 10; % mean
v = 2;  % variance
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
diseaseData(1, symptomaticPeriod) = mu;
diseaseData(2, symptomaticPeriod) = sigma;

% Fatality rate
% Percentage
diseaseData(1, fatalityRate) = 0.003;



end
