function paranoidPeople = getParanoidPeople(populationList, socialNetwork, listOfSickPeople)

% age = 1;
% isSick = 2;
% isVaccinated = 3;
socialNetworkSize = 4;
socialLevel = 5;
% hospitalVisit = 6;
% symptomaticPeriod = 7;
% daysSick = 8;
% incubationPeriod = 9;
% hasSymptoms = 10;
atHome = 11;
% previouslyInfected = 12;

paranoidPeople = []; % people who are worried and may visit the hospital
% multiplier of social level, how many people person 
% will talk with regarding measles 
newsSpreadDegreeOne = 5; % multiplier of how many people sick person notifies
newsSpreadDegreeTwo = 2; % multiplier of how many people friend of sick person notifies


% sick person tells friends
for person=1:length(listOfSickPeople)
    sickPersonID = listOfSickPeople(person);
    % If person is at home, they know they have measles
    if (populationList(sickPersonID, atHome) == 1)
        friendOfSick = [];
        % Go through sick person's social network
        friendCount = populationList(sickPersonID, socialNetworkSize);
        % Determine how many of their friends learn about sick person's
        % measles
        notified = ceil(newsSpreadDegreeOne * rand() * populationList(sickPersonID, socialLevel));
        notified = min(friendCount*0.9, notified);  % prevent exceeding socialNetworkSize
        for friend=1:notified
            % randomly pick which friends are notified
            f = ceil(rand() * friendCount);
            friendID = socialNetwork(sickPersonID, f);
            % check not a repeat of friend already notified
            while (ismember(friendID, friendOfSick) == 1)
                f = ceil(rand() * friendCount);
                friendID = socialNetwork(sickPersonID, f);               
            end
            friendOfSick = [friendOfSick, friendID];
        end
        paranoidPeople = [paranoidPeople, friendOfSick];
    end
end

% friend of sick person tells friends
firstDegreeNotifed = length(paranoidPeople);
for person=1:firstDegreeNotifed
    
    paranoidFriendID = paranoidPeople(person);
    friendOfParanoid = [];
    
    % Go through paranoid person's social network
    friendCount = populationList(paranoidFriendID, socialNetworkSize);
    % Determine how many people paranoid person passes info to
    notified = ceil(newsSpreadDegreeTwo * rand() * populationList(paranoidFriendID, socialLevel));
    notified = min(friendCount*0.9, notified);
    for friend=1:notified
        % randomly pick friend to talk with
        f = ceil(rand() * friendCount);
        friendID = socialNetwork(paranoidFriendID, f);
        % make sure not a repeat
        while (ismember(friendID, friendOfParanoid) == 1)
            f = ceil(rand() * friendCount);
            friendID = socialNetwork(paranoidFriendID, f);               
        end
        friendOfParanoid = [friendOfParanoid, friendID];
    end
    paranoidPeople = [paranoidPeople, friendOfParanoid];
end


end