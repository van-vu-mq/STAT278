function diseaseData = getDiseaseData()
% Returns the upper and lower bounds of variables that define disease's
% behaviour



%%%%
% row 1: mean
% row 2: standard deviation
varCount = 4;
diseaseData = zeros(2, varCount);

% Infection rate, how likely it is to spread.
% Percentage, s0-1
diseaseData(1, 1) = 1;
diseaseData(2, 1) = 0;

% % Incubation period 
% % Number of days it takes for symptoms to appear
% diseaseData(1, 2) = 5;
% diseaseData(2, 2) = 1;

% Live time / how long a person stays sick
% mean, std / mu, sigma
diseaseData(1, 3) = 20;
diseaseData(2, 3) = 5;

% Fatality rate
% Percentage, 0-1
diseaseData(1, 4) = 0.01;
diseaseData(2, 4) = 0.001;


end
