function personData = updateExistingPatient(personData)
% Updates the data of a person who currently has the disease.

% TO_DO
% check comments
% countdown sickness duration
% update to not sick if sickness timed out
% update to display symptoms if incubation period is over


% variables
% age = 1;
% isSick = 2;
% isVaccinated = 3;
% socialNetworkSize = 4;
% socialLevel = 5;
hospitalVisit = 6;
% sickDuration = 7;
% daysSick = 8;
% incubationPeriod = 9;
hasSymptoms = 10;
atHome = 11;
% previouslyInfected = 12;

% person displays symptoms and is not already staying at home
if (personData(1, hasSymptoms)==1 && personData(1, atHome)==0)

    % determine whether person visits hospital
    chance = rand();
    if (chance < personData(1, hospitalVisit))
        % update person based on hospital interaction
        personData(1, :) = visitHospital(personData(1, :));
    end
end



end