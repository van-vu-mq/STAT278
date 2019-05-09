function diseaseData = getDiseaseData()
% Returns the upper and lower bounds of variables that define disease's
% behaviour


% data indexing
rashesIncubation = 2;


%%%%
% row 1: mean
% row 2: standard deviation
varCount = 4;
diseaseData = zeros(2, varCount);

% Infection rate, how likely it is to spread.
% Percentage, s0-1
diseaseData(1, 1) = 1;
diseaseData(2, 1) = 0;

% Incubation period - rashes
% Number of days it takes for rashes to appear. LogNormal distribution
% mu, sigma, calculated for a log-normal distribution
m = 14; % mean
v = 4; % variance
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));

diseaseData(1, rashesIncubation) = mu;
diseaseData(2, rashesIncubation) = sigma;

% Live time / how long a person stays sick
% mu, sigma
diseaseData(1, 3) = 20;
diseaseData(2, 3) = 5;

% Fatality rate
% Percentage, 0-1
diseaseData(1, 4) = 0.01;
diseaseData(2, 4) = 0.001;


end
