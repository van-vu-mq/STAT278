function personData = updateNewPatient(personData)
% Updates the data of a person who has contracted the disease.


diseaseData = getDiseaseData();
% Disease variable index
% d_infectionProbability = 1;
d_incubationPeriod = 2;
d_symptomaticPeriod = 3;
% d_fatalityRate = 4;


% Patient variables
% age = 1;
isSick = 2;
% isVaccinated = 3;
% socialNetworkSize = 4;
% socialLevel = 5;
% hospitalVisit = 6;
symptomaticPeriod = 7;
daysSick = 8;
incubationPeriod = 9;
% hasSymptoms = 10;
% atHome = 11;
previouslyInfected = 12;


% update status to sick
personData(1, isSick) = 1;
personData(1, previouslyInfected) = 1;
personData(1, daysSick) = 0; % reset

% Expected duration of sickness
% Incubation
    % log-normal distribution
mu = diseaseData(1, d_incubationPeriod);
sigma = diseaseData(2, d_incubationPeriod);
personData(1, incubationPeriod) = ceil(lognrnd(mu, sigma));

% Symptoms
% Bundled, no separation between minor severe/tell-tale signs of measles
    % log-normal distribution
mu = diseaseData(1, d_symptomaticPeriod);
sigma = diseaseData(2, d_symptomaticPeriod);
personData(1, symptomaticPeriod) = ceil(lognrnd(mu, sigma));


end