function newPatients = findNewPatients(populationList, socialNetwork, listOfSickPeople)
% Logic to determine who becomes infected
% Return aa array containing the index/ID of the people who has
% contracted the disease.

% age = 1;
% isSick = 2;
isVaccinated = 3;
socialNetworkSize = 4;
socialLevel = 5;
% hospitalVisit = 6;
% symptomaticPeriod = 7;
% daysSick = 8;
% incubationPeriod = 9;
% hasSymptoms = 10;
% atHome = 11;
% previouslyInfected = 12;

diseaseData = getDiseaseData();
d_infectionProbability = 1;
% d_incubationPeriod = 2;
% d_symptomaticPeriod = 3;
% d_fatalityRate = 4;

newPatients = [];

for sickPerson=1:length(listOfSickPeople)
    sickPersonIndex = listOfSickPeople(sickPerson,1);
    mu = populationList(sickPersonIndex, socialLevel);
    sigma = mu*0.2;
    % people interact with different number of people daily
    % determine how many people sick person will interact with
    interactions = ceil(normrnd(mu, sigma));
    
    for i=1:interactions
        % pick random friend from person's friend list
        friend = randi(populationList(sickPersonIndex, socialNetworkSize));
        % get friend's index/ID in the populationList
        friendIndex = socialNetwork(sickPersonIndex, friend);
        
        % check friend is not vaccinated
        if (populationList(friendIndex, isVaccinated) == 0)
            % dice roll if person spreads the disease to friend
            chance = rand();
            if (chance < diseaseData(1,d_infectionProbability))
                newPatients = [newPatients, friendIndex];
            end
        end
    end
end

end