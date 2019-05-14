%{
% ======================================================================= %
% ======================================================================= %
The following is the collection of variables that can be modified to
alter the properties of the population prior to simulating the propagation
of the measle virus.

These variable affect the interaction between members of the population 
and the virus as well as the behaviour of the virus itself.
% ======================================================================= %
% ======================================================================= %

% ===== Format: 
    {FunctionName}:
        {dataRange}, {dataType}, {unit/description}

Main:
    simulationPeriod: 0+, integer, days
    populationSize: 1+, integer, people
    startingInfected: 1+, integer, people

generatePopulation():
    startingSick: 0-1, double, percentage
    startingVaccinated: 0-1, double, percentage
    varCount: 1+, integer, variables 1 person has

getDiseaseData():
    varCount: 1+, integer, number of pre-allocated disease variable

getPersonData():
    varCount: 1+, integer, number of pre-allocated person variable

generateSocialNetwork():
    overCapacityThreshold: 1+, double, percentage. multiplier of
            socialNetwork size

% ======================================================================= %
% ======================================================================= %
The following is the collection of variables that store the proression of
the simulation. These variables are to be analysed to derive meaningful
data
% ======================================================================= %
% ======================================================================= %



%}