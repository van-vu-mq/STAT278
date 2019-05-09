function socialNetwork = highlightSick(plottedGraph, socialNetwork, sickData)
% Colours the nodes of 


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
% colour healthy people green
highlight(plottedGraph, sickList, 'NodeColor', 'r');
highlight(plottedGraph, notSickList, 'NodeColor', 'g');

end