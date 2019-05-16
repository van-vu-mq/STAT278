function personData = visitHospital(personData)
% Determines the events that take place 
% when given person visits the hospital.
% 
% Person's data is modified and returned
% 
% By current design, person is defaulted 
% to stay at home until all symptoms fade

% age = 1;
isSick = 2;
isVaccinated = 3;
% socialNetworkSize = 4;
% socialLevel = 5;
% hospitalVisit = 6;
% symptomaticPeriod = 7;
% daysSick = 8;
% incubationPeriod = 9;
% hasSymptoms = 10;
atHome = 11;
% previouslyInfected = 12;


if(personData(1, isSick) == 1)
    % if person is sick they are told to stay home
    personData(1, atHome) = 1;
else
    % otherwise, they get vaccinated
    personData(1, isVaccinated) = 1;
end

end