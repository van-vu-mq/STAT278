function incubationPeriod = generateIncubationPeriod()

incubationPeriod = 0;
diceroll = rand*100;
%Lookup table for incubation times to map to random nuber generated above,
%based on scientifiv literature
lookupIncubation = [5 8.9; 25 10.9; 50 12.5; 75 14.4; 95 17.7];

%Maps diceroll to incubation period
for i = 1:5
    if diceroll <= lookupIncubation(i);
        incubationPeriod = lookupIncubation(i,2);
        break
    end
end
%Above function does not deal with numbers above 95
if diceroll >95
    incubationPeriod = 17.7;
end

end
