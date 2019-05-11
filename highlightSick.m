function socialNetwork = highlightSick(plottedGraph, socialNetwork, sickData)
% Colours social network connection plot a population to reflect the
% distribution/spread of study virus/disease.

%===== Separate population into two groups, sick and not sick
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

%===== Colour the nodes of the plot
% only colour if there are people that fall in the respective categories
% highlight function cannot take a zero array/matrix

% colour sick people red
if (sickIndex > 0)
    highlight(plottedGraph, sickList, 'NodeColor', 'r');
end
% colour healthy people green
if (notSickIndex > 0)
    highlight(plottedGraph, notSickList, 'NodeColor', 'g');
end

end