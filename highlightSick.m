function socialNetwork = highlightSick(plottedGraph, socialNetwork, sickData)

% Separate population into two groups, sick and not sick
sickList = [1, sum(sickData)];
notSickList = [1, length(sickData)-sum(sickData)];
sickIndex = 0;
notSickIndex = 0;
for person=1:length(sickData)
    if (sickData(person) == 1) 
        sickIndex = sickIndex + 1;
        sickList(sickIndex) = person;
    else
        notSickIndex = notSickIndex + 1;
        notSickList(notSickIndex) = person;
    end
end

% colour sick people red
% only colour if there are sick people
% error occurs if we try with no sick
if (sum(sickData) > 0)
    highlight(plottedGraph, sickList, 'NodeColor', 'r');
end
% colour healthy people green
% only colour if there are healthy people
% error occurs if we try with no healthy
if (sum(sickData) < length(sickData))
    highlight(plottedGraph, notSickList, 'NodeColor', 'g');
end

end