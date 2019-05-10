function diseaseData = getDiseaseData()
% Returns the upper and lower bounds of variables that define disease's
% behaviour


% data indexing
d_infectionProbability = 1;
d_incubationPeriod = 2;
d_symptomaticPeriod = 3;
d_fatalityRate = 4;

%%%%
% row 1: mean
% row 2: standard deviation
varCount = 4;
diseaseData = zeros(2, varCount);

% How likely an unvaccinated person is to contract the disease from a
% carrier
% Percentage, 0-1
diseaseData(1, d_infectionProbability) = 0.90;

% Incubation period
% Number of days it takes for symptoms to appear. LogNormal distribution
% log-normal distribution - values are calculated to match
m = 10; % mean
v = 4;  % variance
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));

diseaseData(1, d_incubationPeriod) = mu;
diseaseData(2, d_incubationPeriod) = sigma;


% Duration of symptoms - correlated to the active period of the diease
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
