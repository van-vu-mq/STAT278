function personData = visitHospital(personData)
% Determines the events that take place 
% when given person visits the hospital.
% 
% Person's data is modified and returned
% 
% By current design, person is defaulted 
% to stay at home until all symptoms fade
 
atHome = 11;

% make person stay at home
personData(1, atHome) = 1;

end