function socialNetwork = highlightSick(plotted, socialNetwork, sickData)
% Graphs connects each person has with the rest of the population


sickList = [];
for person=1:length(sickData)
    if (sickData(person) == 1) 
        sickList = [sickList, person];
    end
end
highlight(plotted, sickList, 'NodeColor', 'r');

end