function personData = updateNewPatient(personData)
% Updates the data of a person who has contracted the disease.

diseaseData = getDiseaseData();


% variables
% age = 1;
isSick = 2;
% isVaccinated = 3;
% socialNetworkSize = 4;
% socialLevel = 5;
% hospitalVisit = 6;
sickDuration = 7;
% daysSick = 8;
incubationPeriod = 9;
% hasSymptoms = 10;
% atHome = 11;
% previouslyInfected = 12;

% update status to sick
personData(1, isSick) = 1;


%%%% make a function that calculates incubation and expected sickness
%%%% duration.
% generate expected duration of sickness 
personData(1,sickDuration) = ceil(normrnd(diseaseData(1,3), diseaseData(2,3)));

% generate incubation period
personData(1,incubationPeriod) = ceil(normrnd(diseaseData(1,2), diseaseData(2,2)));
end