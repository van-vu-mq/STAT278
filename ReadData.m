tic;


%===============================%
%============ Setup ============%
%===============================%

simulationRepeats = 5;  % iterations
populationSize = 10000;    
startingInfected = 2;   % number of people
percentVaccinated = 0.9;    % percentage of population

dataCollection = zeros(simulationDays, simulationRepeats);
for sim=1:simulationRepeats
    filename = "Measles_Vax-" + percentVaccinated + "_Instance-" + sim + ".txt";
    fileID = fopen(filename, 'r');
    data = fscanf(fileID, "%f");
    dataCollection(:, sim)  = data;
    fclose(fileID);
end

filename = "Measles_Vax-" + percentVaccinated + "_Aggregate.txt";
filename = filename + ".txt";
fileID = fopen(filename, 'w');
% write the data
for row = 1:size(dataCollection,1)
    fprintf(fileID,'%g\t',dataCollection(row,:));
    fprintf(fileID,'\n');
end
fclose(fileID);

toc;