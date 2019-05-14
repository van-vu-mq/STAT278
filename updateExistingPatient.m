function populationList = updateExistingPatient(sickPersonID, populationList, socialNetwork)
% Updates the data of given person who currently has the disease 
% to emulate the passing of one day.


%===== Index mapping of variables of person data
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
% index = 13;

personData = polulationList(sickPersonID, :);

%===== Update time from inital infection
personData(1, daysSick) = personData(1, daysSick) + 1;


totalSickDuration = personData(1, incubationPeriod) + personData(1, symptomaticPeriod);
%===== Person has served their sickness sentence, they are fine now
if (personData(1, daysSick) >= totalSickDuration)
    personData(1, isSick) = 0;
    personData(1, incubationPeriod) = 0;
    personData(1, symptomaticPeriod) = 0;
    personData(1, daysSick) = 0;
    personData(1, hasSymptoms) = 0;
    
%===== Person is sick and not at home (pserson is able to spread the disease)
elseif (personData(1, atHome) == 0)
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

populationlist(sickPersonID,:) = sickPersonData;

end