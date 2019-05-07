function personData = updateExistingPatient(personData)
% Updates the data of a person who currently has the disease.

% TO_DO
% check comments

% countdown sickness duration

% update to not sick if sickness timed out

% update to display symptoms if incubation period is over


% person displays symptoms and is not already staying at home
if (personData(1, 9)==1 && personData(1, 10)==0)

    % determine whether person visits hospital
    diceRoll = rand();
    if (diceRoll < personData(1, 5))
        % update person based on hospital interaction
        personData(1, :) = visitHospital(personData(1, :));
    end
end



end