function personData = visitHospital(personData)
% handles the logic, events and status updates for a person who visits the
% hospital

atHome = 11;

% make person stay at home
personData(1, atHome) = 1;

end