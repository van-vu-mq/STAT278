simulationRepeats = 10;
daysSimulated = 500;

dataCollection = zeros(daysSimulated, simulationRepeats);

for sim=1:simulationRepeats
    filename = "Measles" + sim;
    filename = filename + ".txt";
    fileID = fopen(filename, 'r');
    dataCollection(:, sim) = fscanf(fileID, "%f");
    fclose(fileID);
end

filename = "Aggregate";
filename = filename + ".txt";
fileID = fopen(filename, 'w');
% write the data
for row = 1:size(dataCollection,1)
    fprintf(fileID,'%g\t',dataCollection(row,:));
    fprintf(fileID,'\n');
end
% fprintf(fileID, '%i', dataCollection);
% fclose(fileID);