function personData = updateNewPatient(personData)
% Takes a list matrix corresponding to the people who 
% have contracted the virus/disease. Each person is assigned
% time markers for key stages in the virus/disease's lifecycle.
% 
% Marker values are determined via random values based upon clinically
% observed data
% 
% Data matrix is edited for each person and returned

%===== Draw data to generate random values
diseaseData = getDiseaseData();

%===== Index mapping of variables of disease data
% d_infectionProbability = 1;
d_incubationPeriod = 2;
d_symptomaticPeriod = 3;
% d_fatalityRate = 4;


%===== Index mapping of variables of patient data
% age = 1;
isSick = 2;
% isVaccinated = 3;
% socialNetworkSize = 4;
% socialLevel = 5;
% hospitalVisitChance = 6;
symptomaticPeriod = 7;
daysSick = 8;
incubationPeriod = 9;
% hasSymptoms = 10;
% atHome = 11;
previouslyInfected = 12;
% index = 13;


%===== update status to sick
personData(1, isSick) = 1;
personData(1, previouslyInfected) = 1;
personData(1, daysSick) = 0; % reset

%===== Key stages of virus/disease
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