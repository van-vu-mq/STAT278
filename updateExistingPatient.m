function personData = updateExistingPatient(personData)
% Updates the data of a person who currently has the disease.

% TO_DO
% check comments
% countdown sickness duration
% update to not sick if sickness timed out
% update to display symptoms if incubation period is over


% Index of variables
% age = 1;
 isSick = 2;
% isVaccinated = 3;
% socialNetworkSize = 4;
% socialLevel = 5;
hospitalVisit = 6;
symptomaticPeriod = 7;
daysSick = 8;
incubationPeriod = 9;
hasSymptoms = 10;
atHome = 11;
% previouslyInfected = 12;

% Update day tracker
personData(1, daysSick) = personData(1, daysSick) + 1;


totalSickDuration = personData(1, incubationPeriod) + personData(1, symptomaticPeriod);
if (personData(1, daysSick) > totalSickDuration)
    % Person has served their sickness sentence, they are fine now
    personData(1, isSick) = 0;
    personData(1, incubationPeriod) = 0;
    personData(1, symptomaticPeriod) = 0;
    personData(1, daysSick) = 0;
    personData(1, hasSymptoms) = 0;
    
elseif (personData(1, atHome == 0))
    % person is still sick but not at home
    
    % check if person should be displaying symptoms 
    if (personData(1, daysSick) > personData(1, incubationPeriod))
        personData(1, hasSymptoms) = 1;
    end
    
    % person has visible symptoms
    if (personData(1, hasSymptoms)==1)

        % determine whether person visits hospital
        chance = rand();
        if (chance < personData(1, hospitalVisit))
            % update person based on hospital interaction
            personData(1, :) = visitHospital(personData(1, :));
        end
    end
end



end