function personData = updateNewPatient(personData)
% Updates the data of a person who has contracted the disease.

diseaseData = getDiseaseData();

% update status to sick
personData(1, 2) = 1;


%%%% make a function that calculates incubationa nd expected sickness
%%%% duration.
% generate expected duration of sickness 
personData(1,7) = floor(normrnd(diseaseData(1,3), diseaseData(2,3)));

% generate incubation period
personData(1,8) = ceil(normrnd(diseaseData(1,2), diseaseData(2,2)));
end